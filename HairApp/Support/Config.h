//
//  Config.h
//  Vizzou'
//
//  Created by Ashish Kumar Sharma on 04/07/16.
//  Copyright © 2016 Ashish Kumar Sharma. All rights reserved.
//

#ifndef Config_h

#define WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define BASE_URL @"https://dynobranding.com/client/hairapp/api/"

////// --- Colors

#define APP_COLOR [UIColor colorWithRed:45.0/255.0 green:18.0/255.0 blue:50.0/255.0 alpha:1]

#define WHITE_COLOR [UIColor colorWithRed:1 green:1 blue:1 alpha:1]

#define BLACK_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

#define HEADER_COLOR [UIColor colorWithRed:14/255.0 green:41/255.0 blue:46/255.0 alpha:1]

#define CLEAR_COLOR [UIColor clearColor]



////// --- Constant Codes

#define HIDE_KEY [self.view endEditing:YES];

#define HIDE_KEY_ON_TOUCH -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { HIDE_KEY }

#define HIDE_NAV_BAR self.navigationController.navigationBarHidden = YES;

#define POP_BACK [self.navigationController popViewControllerAnimated:YES];

#define STATUS_BAR_WHITE UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)]; status.backgroundColor = WHITE_COLOR; [self.view addSubview:status];

#define STATUS_BAR UIView *status = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)]; status.backgroundColor = STATUS_COLOR; [self.view addSubview:status];

#define TAB_BAR tabView *bar = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:1]; bar.selfBack=self; bar.tab_tag = tab_tag; [self.view addSubview:bar];

#define BACK_BUTTON BackView *backView  = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0]; backView.selfBack=self;  [self.view addSubview:backView];

#define GET_HEADER_VIEW HeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];header.backgroundColor = HEADER_COLOR; header.backSelf = self; [self.view addSubview:header]; header.frame = CGRectMake(0, 0, WIDTH, 70);

#define GET_HEADER_VIEW HeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];header.backgroundColor = HEADER_COLOR; header.backSelf = self; [self.view addSubview:header]; header.frame = CGRectMake(0, 0, WIDTH, 70);
/// -- imges

#define GET_HEADER_NO_BUTTON HeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];header.backgroundColor = HEADER_COLOR; header.backSelf = self; [self.view addSubview:header]; header.frame = CGRectMake(0, 0, WIDTH, 70); header.blank_header = 3;

#define GET_HEADER_BACK_BUTTON HeaderView *header = [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] objectAtIndex:0];header.backgroundColor = HEADER_COLOR; header.backSelf = self; [self.view addSubview:header]; header.frame = CGRectMake(0, 0, WIDTH, 70); header.blank_header = 1;

#define black_heart @"ic_favorite_black_24dp"

#define red_heart @"ic_red_heart"







#define Config_h

#endif