//
//  MessageVC.h
//  HairApp
//
//  Created by Apple on 16/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *table_chat;
    IBOutlet UITextField *text_msg;
    
    NSArray *message_array;
    IBOutlet UIScrollView *main_scrol;

}
@end
