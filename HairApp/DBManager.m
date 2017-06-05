//
//  DBManager.m
//  SqliteExample
//
//  Created by Ram Singh  on 30/03/15.
//  Copyright (c) 2015 Ram Singh . All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance
{
    if (!sharedInstance)
    {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB
{
    @try
    {
        NSString *docsDir = nil;
        NSArray *dirPaths = nil;
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        // Build the path to the database file
        databasePath = [[NSString alloc] initWithString:
                        [docsDir stringByAppendingPathComponent: @"chat.sqlite"]];
        NSLog(@"databasePath = %@",databasePath);
        BOOL isSuccess = YES;
        NSFileManager *filemgr = [NSFileManager defaultManager];
        if ([filemgr fileExistsAtPath: databasePath ] == NO)
        {
            const char *dbpath = [databasePath UTF8String];
            if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt = "CREATE TABLE IF NOT EXISTS member (member_name text,base64 text,member_id text primary key)";
                if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                    != SQLITE_OK)
                {
                    isSuccess = NO;
                    NSLog(@"Failed to create table");
                }
                const char *sql_stmt1 = "CREATE TABLE IF NOT EXISTS message_data (member_id text,status text,message text,msg_id text primary key,time text)";
                if (sqlite3_exec(database, sql_stmt1, NULL, NULL, &errMsg)
                    != SQLITE_OK)
                {
                    isSuccess = NO;
                    NSLog(@"Failed to create table");
                }
                
                sqlite3_close(database);
                return  isSuccess;
            }
            else {
                isSuccess = NO;
                NSLog(@"Failed to open/create database");
            }
        }
        return isSuccess;
    }

    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
}

- (BOOL)saveData:(NSString*)meber_id sendORreceved:(NSString*)status message:(NSString*)message message_id:(NSString *)msg_id time:(NSString *)time
{
    @try
    {
        [self createDB];
       
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO message_data (member_id,status,message,msg_id,time) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",meber_id,status,message,msg_id,time];
            const char *insert_stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
           
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                sqlite3_reset(statement);
                return YES;
            }
            else
            {
                sqlite3_reset(statement);
                return NO;
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",exception);
    }
    return NO;
    
}

- (NSArray*) findchat_data:(NSString*)member_id
{
    @try
    {
        [self createDB];
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT status,message,time FROM message_data WHERE member_id=%@",member_id];
            const char *query_stmt = [querySQL UTF8String];
            NSMutableArray *resultArray = [[NSMutableArray alloc]init];
            
            if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                @try {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        NSString *status = [NSString stringWithFormat:@"%@",[[NSString alloc]initWithUTF8String:  (const char *) sqlite3_column_text(statement, 0)]];
                        [dic setObject:status forKey:@"status"];
                        
                        NSString *message = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)];
                        [dic setObject:message forKey:@"message"];
                        
                        NSString *time = [[NSString alloc]initWithUTF8String: (const char *) sqlite3_column_text(statement,2)];
                        [dic setObject:time forKey:@"time"];
                        [resultArray addObject:dic];
                    }
                } @catch (NSException *exception)
                {
                    
                } @finally {
                    
                }
                return  resultArray;
            }
            else
            {
                sqlite3_reset(statement);
                NSLog(@"Not found");
                return nil;
            }
        }
        else  return nil;
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

-(BOOL) saveMember:(NSString*)member_id member_name:(NSString*)member_name base64:(NSString *)base64
{
    [self createDB];
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO member (member_name ,member_id, base64) VALUES (\"%@\",\"%@\",\"%@\")",member_name,member_id,base64];
        const char *insert_stmt = [insertSQL UTF8String];
      
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            sqlite3_reset(statement);
            return YES;
        }
        else
        {
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

-(NSArray*) findMember
{
    [self createDB];
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM member "];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
       
      
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
        
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                NSString *name = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement,0)];
          
                [dic setObject:name forKey:@"name"];
                
                 NSString *base64 = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement,1)];
               
                [dic setObject:base64 forKey:@"base64"];
               
                 NSString *mem_id = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement,2)];
                [dic setObject:mem_id forKey:@"mem_id"];

                [resultArray addObject:dic];
            }

            return  resultArray;
        }
        else
        {
             sqlite3_reset(statement);
             NSLog(@"Not found");
             return nil;
        }
    }
    return nil;
}

-(void)deletDataBase
{
    @try
    {
        [self createDB];
        NSString *dbpath =[NSString stringWithFormat:@"%s",[databasePath UTF8String]];
        
        NSError *err;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        err = nil;
        NSURL *url = [NSURL fileURLWithPath:dbpath];
        [fm removeItemAtPath:[url path] error:&err];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}

@end
