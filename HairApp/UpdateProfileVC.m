//
//  UpdateProfileVC.m
//  HairApp
//
//  Created by Apple on 13/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "UpdateProfileVC.h"

@interface UpdateProfileVC ()

@end

@implementation UpdateProfileVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    GET_HEADER_VIEW
    
    
//////  Set Place Holder
    
    text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_lname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_lname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_user_name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_user_name.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_fname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_fname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_zipCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_zipCode.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_phone.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_zipCode.keyboardType = UIKeyboardTypeNumberPad;
    text_phone.keyboardType = UIKeyboardTypeNumberPad;
    text_email.keyboardType = UIKeyboardTypeEmailAddress;
   
//// Set User Fiels
    
    UserSession *user = [[UserSession alloc]initWithSession];
    text_email.text = user.email;
    text_fname.text = user.first_name;
    text_lname.text = user.last_name;
    text_user_name.text = user.user_name;
    text_zipCode.text = user.zip_code;
    text_phone.text = user.phone;

}

- (IBAction)tap_update:(id)sender
{
    HIDE_KEY
    if (text_user_name.text.length > 0 && text_fname.text.length > 0 && text_lname.text.length > 0 && text_email.text.length > 0 && text_zipCode.text.length > 0 && text_phone.text.length > 0)
    {
        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
        {
            text_email.layer.borderWidth = 0;
          
                HIDE_KEY
            [SVProgressHUD showWithStatus:@"Updating Profile.."];
                [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
                
        }
        else
        {
            [text_email becomeFirstResponder];
            text_email.layer.borderWidth = 0.8;
            text_email.layer.borderColor = [UIColor redColor].CGColor;
            [WebServiceCalls warningAlert:@"Please enter valid email address."];
        }
    }
    else [WebServiceCalls warningAlert:@"All field required."];
    
}
-(void)fireJson
{
    
    UserSession *user = [[UserSession alloc]initWithSession];

    NSString *string = [NSString stringWithFormat:@"update_profile.php?user_id=%@username=%@&email=%@&zip_code=%@&firstname=%@&lastname=%@&phone=%@",user.user_id,text_user_name.text,text_email.text,text_zipCode.text,text_fname.text,text_lname.text,text_phone.text];

    [WebServiceCalls POST:string parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         @try
         {
             [SVProgressHUD dismiss];
             
             if ([JSON[@"Status"] integerValue] == 26)
             {
                 [WebServiceCalls warningAlert:@"Username or email already exits."];
             }
             else if  ([JSON[@"Status"] integerValue] == 0)
             {
                 UserSession *user = [[UserSession alloc]init];
                 user.email = text_email.text;
                 user.user_name = text_user_name.text;
                 user.first_name = text_fname.text;
                 user.last_name = text_lname.text;
                 user.phone = text_phone.text;
                 user.zip_code = [NSString stringWithFormat:@"%@",JSON[@"details"][@"zip_code"]];
                 
                 [user saveSession];
                 [WebServiceCalls alert:@"Data Successfully Updated"];

             }
             else [WebServiceCalls warningAlert:@"Network Error"];
             
         }  @catch (NSException *exception)
         {
         } @finally {
             
         }
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
    [AppDelegate AppDelegate].menuTag = 6;

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
@end
