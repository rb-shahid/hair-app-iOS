//
//  UserSession.m
//  Friendsy
//
//  Created by Ashish Kumar Sharma on 13/07/16.
//  Copyright © 2016 Ashish Kumar Sharma. All rights reserved.
//

#import "UserSession.h"
#import "DBManager.h"
@implementation UserSession
@synthesize first_name,last_name,email,user_id,image_data,password,phone,zip_code,user_name;

-(void)saveSession
{
    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults]setObject:last_name forKey:@"last_name"];
    [[NSUserDefaults standardUserDefaults]setObject:first_name forKey:@"first_name"];
    [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]setObject:user_id forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults]setObject:image_data forKey:@"image_data"];
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]setObject:zip_code forKey:@"zip_code"];
    [[NSUserDefaults standardUserDefaults]setObject:user_name forKey:@"user_name"];

}

- (instancetype)initWithSession
{
    email = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    last_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"last_name"];
    first_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"first_name"];
    password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    image_data = [[NSUserDefaults standardUserDefaults]objectForKey:@"image_data"];
    zip_code = [[NSUserDefaults standardUserDefaults]objectForKey:@"zip_code"];
    user_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_name"];

    return self;
}
+(void)clearSession
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phone"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"last_name"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"first_name"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"image_data"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"zip_code"];
    
    DBManager *dmanager = [[DBManager alloc]init];
    [dmanager deletDataBase];
    
}

-(void)saveFollowIds:(NSDictionary *)dic
{
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"followids"];
}

-(void)saveFollowerArray:(NSArray *)array
{
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:@"FollowerArray"];
}

@end
