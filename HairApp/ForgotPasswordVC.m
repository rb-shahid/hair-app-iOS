//
//  ForgotPasswordVC.m
//  HairApp
//
//  Created by Apple on 12/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    GET_HEADER_BACK_BUTTON
    
     text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter registered email" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap_send:(id)sender
{
    if (text_email.text.length > 0  )
    {
        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
        {
            
            HIDE_KEY
            [SVProgressHUD showWithStatus:@"Sending Recovery Email.."];
            
            [self performSelector:@selector(fireAPI) withObject:nil afterDelay:0];
        }
        else [WebServiceCalls warningAlert:@"Please enter valid email address."];
    }
    else [WebServiceCalls warningAlert:@"Please enter email first."];
}

-(void)fireAPI
{


    NSString *string = [NSString stringWithFormat:@"forgotpassword.php?email=%@",text_email.text];
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
             [self performSegueWithIdentifier:@"goHome" sender:nil];
         }
             
         } @catch (NSException *exception) {
             
         } @finally {
             
         }

         
     }];
}

HIDE_KEY_ON_TOUCH
@end
