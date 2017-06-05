//
//  HeaderView.h
//  Friendsy
//
//  Created by Ashish Kumar Sharma on 14/07/16.
//  Copyright © 2016 Ashish Kumar Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView


@property (readwrite, nonatomic) int blank_header;

@property (strong, nonatomic)    IBOutlet UIButton *btn_write;

@property (strong, nonatomic) IBOutlet UIButton *btn_menu;
@property (strong, nonatomic) IBOutlet UIButton *bnt_menu_img;

@property (strong, nonatomic) IBOutlet UIButton *btn_back;

@property(nonatomic,strong) UIViewController *backSelf;

@end
