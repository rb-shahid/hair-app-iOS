//
//  RegisterVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
{
        // this is use for check the terms and conditions checkbox
        int checkTermsAndConditions;
}
@end

@implementation RegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    GET_HEADER_BACK_BUTTON
    
    [main_scrol setContentSize:CGSizeMake(WIDTH, 650)];
    text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
     text_username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_username.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    text_password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_password.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    text_fname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_fname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_lname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_lname.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    text_phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_phone.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_vpassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_vpassword.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    text_fname.layer.cornerRadius =   text_password.layer.cornerRadius = text_vpassword.layer.cornerRadius = text_phone.layer.cornerRadius = text_lname.layer.cornerRadius =  text_email.layer.cornerRadius = 4;
    
    text_phone.keyboardType = UIKeyboardTypePhonePad;
    text_email.keyboardType = UIKeyboardTypeEmailAddress;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (IBAction)tap_register:(id)sender
{
    
    
    if (text_username.text.length > 0 && text_fname.text.length > 0 && text_lname.text.length > 0 && text_email.text.length > 0 && text_password.text.length > 0 && text_vpassword.text.length > 0 && text_phone.text.length > 0 )
    {
        
        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
        {
            text_email.layer.borderWidth = 0;

            if ([text_password.text isEqualToString:text_vpassword.text])
            {
                if (checkTermsAndConditions == 1)
                {
                    HIDE_KEY
                    [SVProgressHUD showWithStatus:@"Registering..."];
                    [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
                }
                else
                    [WebServiceCalls warningAlert:@"Please agree terms & services"];
                
            }
            else [WebServiceCalls warningAlert:@"Please enter same password."];
            
        }
        else {
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
    NSString *string = [NSString stringWithFormat:@"signup.php?username=%@&email=%@&password=%@&repassword=%@&zip_code=n/a&firstname=%@&lastname=%@&phone=%@",text_username.text,text_email.text,text_password.text,text_password.text,text_fname.text,text_lname.text,text_phone.text];
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
                 user.user_name = text_username.text;
                 user.first_name = text_fname.text;
                 user.last_name = text_lname.text;
                 user.phone = text_phone.text;
                 user.password = text_password.text;
                 user.user_id = [NSString stringWithFormat:@"%@",JSON[@"details"][@"user_id"]];
                 user.zip_code = [NSString stringWithFormat:@"%@",JSON[@"details"][@"zip_code"]];

                 [user saveSession];
                 [self performSegueWithIdentifier:@"goHomeReg" sender:nil];
             }
             
             else [WebServiceCalls warningAlert:@"Network Error"];
         } @catch (NSException *exception)
         {
         } @finally {
             
         }
        //
     }];
}
- (IBAction)tapCheckBox:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        checkTermsAndConditions=1;
        sender.tag = 1;
        [sender setImage:[UIImage imageNamed:@"check_white"] forState:UIControlStateNormal];
    }
    else
    {
        checkTermsAndConditions=0;
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:@"uncheck_white"] forState:UIControlStateNormal];
    
    }
}

- (IBAction)operTerms:(UIButton *)sender
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        //[self warningAlert:@"No internet connection"];
    }
    else
    {
        webView = [[UIWebView alloc]initWithFrame:sender.frame];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.affordablehairtransplants.com/terms-and-conditions"]]];
        [self.view addSubview:webView];
        
        
        webView.delegate = self;
        cross = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 20, 44, 44)];
        [cross setImage:[UIImage imageNamed:@"cross_2"] forState:UIControlStateNormal];
        [cross addTarget:self action:@selector(crossWebView) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cross];
        
        [UIView animateWithDuration:0.3 animations:^{
            webView.frame = self.view.frame;
        }];
    }
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD show];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:6];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
-(void)dismiss
{
    [SVProgressHUD dismiss];
}
-(void)crossWebView
{
    [webView removeFromSuperview];
    [cross removeFromSuperview];
}
HIDE_KEY_ON_TOUCH
@end
