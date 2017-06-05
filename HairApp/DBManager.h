//
//  DBManager.h
//  SqliteExample
//
//  Created by Ram Singh  on 30/03/15.
//  Copyright (c) 2015 Ram Singh . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;

-(BOOL) saveData:(NSString*)meber_id sendORreceved:(NSString*)status message:(NSString*)message message_id:(NSString *)msg_id time:(NSString *)time;
-(NSArray*) findchat_data:(NSString*)member_id;
-(void)deletDataBase;

@end
