//
//  LoginVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    GET_HEADER_NO_BUTTON
    HIDE_NAV_BAR
    
       
// STATUS_BAR_WHITE

    text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_password.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_email.keyboardType = UIKeyboardTypeEmailAddress;

}
- (IBAction)tap_login:(id)sender
{
    
    if (text_password.text.length > 0 && text_email.text.length > 0  )
    {
//        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
//        {
                HIDE_KEY
                [SVProgressHUD showWithStatus:@"Loggin In"];
            
            [self performSelector:@selector(userLogin) withObject:nil afterDelay:0];
//        }
//        else [WebServiceCalls warningAlert:@"Please enter valid email address."];
    }
    else [WebServiceCalls warningAlert:@"All field required."];

}
-(void)userLogin
{

    NSString *string = [NSString stringWithFormat:@"signin.php?user_name=%@&password=%@",text_email.text,text_password.text];
    [WebServiceCalls POST:string parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         [SVProgressHUD dismiss];
         @try
         {
             if ([JSON [@"Status"] integerValue]==10)
             {
                 [WebServiceCalls warningAlert:@"Email or Password is Incorrect"];
             }
             else if ([JSON [@"Status"] integerValue]==0)
             {
                
                 UserSession *user = [[UserSession alloc]init];
               
                 user.email = [NSString stringWithFormat:@"%@",JSON[@"details"][@"email"]];
                 user.user_name = [NSString stringWithFormat:@"%@",JSON[@"details"][@"username"]];
                 user.first_name = [NSString stringWithFormat:@"%@",JSON[@"details"][@"firstname"]];
                 user.last_name = [NSString stringWithFormat:@"%@",JSON[@"details"][@"lastname"]];
                 user.phone = [NSString stringWithFormat:@"%@",JSON[@"details"][@"phone"]];
                 user.password = text_password.text;
                 user.user_id = [NSString stringWithFormat:@"%@",JSON[@"details"][@"user_id"]];
                 user.zip_code = [NSString stringWithFormat:@"%@",JSON[@"details"][@"zip_code"]];
                 
                 text_email.text = text_password.text = nil;
                 [user saveSession];
                 
                 AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                 [delegate registerForNotification:[UIApplication sharedApplication]];
                 [self performSegueWithIdentifier:@"goHome" sender:nil];
             }
         } @catch (NSException *exception) {
             
         } @finally {
             
         }
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

HIDE_KEY_ON_TOUCH
@end
