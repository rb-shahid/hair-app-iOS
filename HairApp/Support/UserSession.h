//
//  UserSession.h
//  Friendsy
//
//  Created by Ashish Kumar Sharma on 13/07/16.
//  Copyright © 2016 Ashish Kumar Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject
@property(nonatomic,strong)NSString *first_name;
@property(nonatomic,strong)NSString *last_name;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *user_name;
@property(nonatomic,strong)NSString *zip_code;

@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSData *image_data;
@property(nonatomic,strong)NSString *password;


-(void)saveSession;
-(instancetype)initWithSession;
-(void)saveFollowIds:(NSDictionary *)dic;
+(void)clearSession;

@end
