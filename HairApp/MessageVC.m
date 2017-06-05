//
//  MessageVC.m
//  HairApp
//
//  Created by Apple on 16/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MessageVC.h"
#import "DBManager.h"
#import "UserMessage.h"
#import "AdminMessage.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    GET_HEADER_VIEW
 
    
    text_msg.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_msg.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_msg.returnKeyType = UIReturnKeySend;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma MARKE TABLE VIEW

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return message_array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [[message_array objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    if (text.length<40)
    {
        return 55;
    }
    if (text.length<70)
    {
        return 70;
    }
    else if (text.length<95)
    {
         return 90;
    }
    else return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
        
        NSDate * timeNotFormatted = [dateFormatter dateFromString:[[message_array objectAtIndex:indexPath.row] objectForKey:@"time"]];
        
        NSString *timeString = [self dateStringForDate:timeNotFormatted];

        static NSString *staticCell = @"cell";

        if([[[message_array objectAtIndex:indexPath.row] objectForKey:@"status"] isEqualToString:@"s"])
        {
            UserMessage *cell = (UserMessage *)[tableView  dequeueReusableCellWithIdentifier:staticCell];
            
            if (cell == nil)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil] objectAtIndex:1];
            }
           
            cell.timeLbl.text = timeString;
            cell.message.text = [[message_array objectAtIndex:indexPath.row] objectForKey:@"message"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.message.numberOfLines = 10;

            return cell;
        }
        else
        {
            AdminMessage *cell = (AdminMessage *)[tableView  dequeueReusableCellWithIdentifier:staticCell];

            if (cell == nil)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:self options:nil] objectAtIndex:0];
            }
           
            cell.timeLbl.text = timeString;
            cell.message.text = [[message_array objectAtIndex:indexPath.row] objectForKey:@"message"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.message.numberOfLines = 10;
            return cell;
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (NSString *)dateStringForDate:(NSDate *)date {
    
    NSString *timeStamp = @"";
    NSCalendarUnit units = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday | NSCalendarUnitWeekOfYear;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:units fromDate:date toDate:[NSDate date] options:NSCalendarWrapComponents];
 
    if (components.year >= 1) {
        
        if (components.year == 1) {
            timeStamp = @"Last year";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld years ago", (long)components.year];
        }
    }
    else if (components.month >= 1) {
        
        if (components.month == 1) {
            timeStamp = @"Last month";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld months ago", (long)components.month];
        }
    }
    else if (components.weekOfYear >= 1) {
        
        if (components.weekOfYear == 1) {
            timeStamp = @"Last Week";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld weeks ago", (long)components.weekOfYear];
        }
    }
    else if (components.day >= 1) {
        
        if (components.day == 1) {
            timeStamp = @"Yesterday";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld days ago", (long)components.day];
        }
    }
    else if (components.hour >= 1) {
        
        if (components.hour == 1) {
            timeStamp = @"An hour ago";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld hours ago", (long)components.hour];
        }
    }
    else if (components.minute >= 1) {
        
        if (components.minute == 1) {
            timeStamp = @"A minute ago";
        }
        else {
            timeStamp = [NSString stringWithFormat:@"%ld minutes ago", (long)components.minute];
        }
    }
    else if (components.second > 5) {
        timeStamp = [NSString stringWithFormat:@"%ld seconds ago", (long)components.second];
    }
    else {
        timeStamp = @"Just Now";
    }
    
    return timeStamp;
}

#pragma mark Api Calling

- (IBAction)tapOn_send:(id)sender
{
    if (text_msg.text.length>0)
    {
        HIDE_KEY
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            // [Web :@"Internet Access Failed"];
        }
        else
        {
            @try
            {
                [SVProgressHUD showWithStatus:@"Sending"];
                AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
                manager.securityPolicy.allowInvalidCertificates = YES;//This is for https
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                NSString *urlString = [NSString stringWithFormat:@"http://dynobranding.com/client/hairapp/api/user-message.php"];
                UserSession *user = [[UserSession alloc]initWithSession];

                NSDictionary *param = @{@"user_id":user.user_id,
                                        @"massage":text_msg.text};
                [manager POST:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                 { }success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     [SVProgressHUD dismiss];

                     @try
                     {

                         NSMutableDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                         
                         if ([responseJson[@"Status"] integerValue] ==0 )
                         {
                             NSDate *currentTime = [NSDate date];
                             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                             [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
                             NSString *messid = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:currentTime]];
                             [dateFormatter setDateFormat:@"MM-dd-yyyy hh:mm:ss a"];
                            
                             DBManager *dmanager = [[DBManager alloc]init];
                             [dmanager saveData:@"0" sendORreceved:@"s" message:text_msg.text message_id:messid time:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:currentTime]]];
                             message_array = [dmanager findchat_data:@"0"];
                             [table_chat reloadData];
                             
                             if ([message_array count]>0)
                             {
                                 NSIndexPath* ip = [NSIndexPath indexPathForRow:([table_chat numberOfRowsInSection:0]-1) inSection:0];
                                 [table_chat scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                             }
                         }
                         text_msg.text = nil;
                     }
                     @catch (NSException *exception)
                     {
                         
                     }
                 }failure:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     [SVProgressHUD dismiss];
                 }];
            }
            @catch (NSException *exception)
            {
                NSLog(@"%@",exception);
            }
        }
    }
    else
    {
        
        
    }
}

- (IBAction)getMessages
{
    if ([AppDelegate AppDelegate].menuTag == 2)
    {
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            //[self alert:@"Internet Access Failed"];
        }
        else
        {
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
            manager.securityPolicy.allowInvalidCertificates = YES;
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            UserSession *user = [[UserSession alloc]initWithSession];
            
            NSString *urlString = [NSString stringWithFormat:@"http://dynobranding.com/client/hairapp/api/user-message.php"];
       
            [manager POST:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:@{@"user_id":user.user_id} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject)
             {
                 
                 @try
                 {
                     NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                     NSArray *getArray = responseJson[@"details"];
                     DBManager *dmanager = [[DBManager alloc]init];
                     
                     for (int i=0 ; i<getArray.count; i++)
                     {
                         NSString *time = [[getArray objectAtIndex:i] objectForKey:@"added_time"];
                         NSString *chat_text = [[getArray objectAtIndex:i] objectForKey:@"messege"];
                         NSString *chat_id = [[getArray objectAtIndex:i] objectForKey:@"messege_id"];
                         
                         [dmanager saveData:@"0" sendORreceved:@"r" message:chat_text message_id:chat_id time:time];
                     }
                     
                     message_array = [dmanager findchat_data:@"0"];
                     if ([message_array count]>0)
                     {
                         [table_chat reloadData];
                         NSIndexPath* ip = [NSIndexPath indexPathForRow:([table_chat numberOfRowsInSection:0]-1) inSection:0];
                         [table_chat scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                     }
                     
                     if([AppDelegate AppDelegate].menuTag == 2)
                     {
                         [self performSelector:@selector(getMessages) withObject:nil afterDelay:5];
                     }
                     
                     
                 } @catch (NSException *exception) {
                     
                 } @finally {
                     
                 }
                 
             } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                 
             } ];
            
            
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    main_scrol.contentOffset = CGPointMake(0, -100);
   // main_scrol.frame = CGRectMake(0, -100, WIDTH,main_scrol.frame.size.height);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    HIDE_KEY;
    if (text_msg.text.length>0)
    {
        [self tapOn_send:@""];
    }
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
   
    DBManager *dmanager = [[DBManager alloc]init];
    message_array = [dmanager findchat_data:@"0"];
    [table_chat reloadData];
    
    [self performSelector:@selector(getMessages) withObject:nil afterDelay:0];

    [AppDelegate AppDelegate].menuTag = 2;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

HIDE_KEY_ON_TOUCH
@end
