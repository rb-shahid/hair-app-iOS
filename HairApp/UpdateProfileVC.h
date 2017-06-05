//
//  UpdateProfileVC.h
//  HairApp
//
//  Created by Apple on 13/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateProfileVC : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITextField *text_user_name;
    IBOutlet UITextField *text_fname;
    IBOutlet UITextField *text_lname;
    IBOutlet UITextField *text_email;
    IBOutlet UITextField *text_zipCode;
    IBOutlet UITextField *text_phone;

}
@end
