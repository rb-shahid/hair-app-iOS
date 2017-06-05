//
//  ResetPasswordVC.h
//  HairApp
//
//  Created by Apple on 13/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordVC : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITextField *text_email;
    IBOutlet UITextField *text_old_password;
    IBOutlet UITextField *text_new_password;
    
}
@end
