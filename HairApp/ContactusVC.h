//
//  ContactusVC.h
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactusVC : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet TPKeyboardAvoidingScrollView *tp_scroll;
    IBOutlet UITextField *text_name;
    IBOutlet UITextField *text_email;
    IBOutlet UITextField *text_subject;

    IBOutlet UITextView *text_description;
}
@end
