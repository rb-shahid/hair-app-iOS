//
//  ResetPasswordVC.m
//  HairApp
//
//  Created by Apple on 13/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()

@end

@implementation ResetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    GET_HEADER_VIEW
    
    text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_old_password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_old_password.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_new_password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_new_password.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_old_password.secureTextEntry = YES;
    text_email.keyboardType = UIKeyboardTypeEmailAddress;
    UserSession *user = [[UserSession alloc]initWithSession];
    text_email.text = user.email;
}

- (IBAction)tap_reset:(id)sender
{
    HIDE_KEY
    if (text_old_password.text.length > 0 && text_new_password.text.length > 0 && text_email.text.length > 0  )
    {
        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
        {
            UserSession *user = [[UserSession alloc]initWithSession];
            
            if ([user.password isEqualToString:text_old_password.text])
            {
                if ([text_new_password.text isEqualToString:text_old_password.text])
                {
                    [WebServiceCalls warningAlert:@"Enter different password"];
                }
                else
                {
                    [SVProgressHUD showWithStatus:@"Resetting Password.."];
                    [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
                }
            }else [WebServiceCalls warningAlert:@"Old password is wrong."];
        }else
            {
                [text_email becomeFirstResponder];
                text_email.layer.borderWidth = 0.8;
                text_email.layer.borderColor = [UIColor redColor].CGColor;
                [WebServiceCalls warningAlert:@"Please enter valid email address."];
            }
    } else [WebServiceCalls warningAlert:@"All field required."];
}

-(void)fireJson
{
    
     NSString *string = [NSString stringWithFormat:@"reset_password.php?email=%@&password=%@&oldpassword=%@",text_email.text,text_new_password.text,text_old_password.text];

    [WebServiceCalls POST:string parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         [SVProgressHUD dismiss];
         @try
         {
             text_new_password.text = text_old_password.text = nil;
             if ([JSON [@"Status"] integerValue]==10)
             {
                 [WebServiceCalls warningAlert:@"Email or Password is Incorrect"];
             }
             else
             {
                 UserSession *user = [[UserSession alloc]initWithSession];
                 user.password = text_new_password.text;
               
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank you" message:@"We will respond as soon as possible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];

                 //[WebServiceCalls alert:@"New Password Sucessfuly Reset"];
             }
         }@catch(NSException *exception)
         {}@finally
         {}
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [AppDelegate AppDelegate].menuTag = 7;

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
