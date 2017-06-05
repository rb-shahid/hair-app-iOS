//
//  WebServiceCalls.m
//  Ponder_remake
//
//  Created by Yudiz Solutions on 04/07/13.
//  Copyright (c) 2013 Yudiz Solutions. All rights reserved.
//

#import "WebServiceCalls.h"
#import "AFNetworking.h"

static AFHTTPRequestOperationManager *manager;


@interface WebServiceCalls(){
}
@end

static NSString *getuserphone;

@implementation WebServiceCalls

+ (void)initialize
{
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves];
}

+ (void)POST:(NSString *)url parameter:(NSDictionary *)parameter completionBlock:(WebCallBlock)block
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        [self warningAlert:@"No internet connection"];;
    }
    else
    {
    @try
    {
        NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
        NSData *data  = [NSData dataWithContentsOfURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        NSDictionary *vehicel_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        block(vehicel_dic,WebServiceResultSuccess);
    }
    @catch (NSException *exception)
    {
        block(@"1",WebServiceResultSuccess);
    }
    }
}

+ (void)POST:(NSString *)url parameter:(NSDictionary *)parameter imageData:(NSData *)imageData completionBlock:(WebCallBlock)block
{
}



+(void)warningAlert:(NSString *)alertString
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:alertString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
+(void)alert:(NSString *)alertString
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:alertString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

+(BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegEx =
    @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
    @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL isvalid =[emailTest evaluateWithObject:email];
    return isvalid;
}
+(BOOL)isValidphone:(NSString *)phone
{
    NSString *phoneRegex = @"[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];

    BOOL isvalid =[phoneTest evaluateWithObject:phone];
    return isvalid;
}


@end

