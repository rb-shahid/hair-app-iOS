//
//  RegisterVC.h
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : UIViewController<UIGestureRecognizerDelegate,UIWebViewDelegate>
{
    IBOutlet TPKeyboardAvoidingScrollView *main_scrol;
    IBOutlet UITextField *text_username;
    IBOutlet UITextField *text_fname;
    IBOutlet UITextField *text_lname;
    IBOutlet UITextField *text_email;
    IBOutlet UITextField *text_password;
    IBOutlet UITextField *text_vpassword;
    IBOutlet UITextField *text_phone;
    
    UIWebView *webView;
    UIButton *cross;
}

@end
