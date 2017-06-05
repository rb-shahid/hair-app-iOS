//
//  ConsultaionVCStep2.h
//  HairApp
//
//  Created by Apple on 15/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultaionVCStep2 : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{

    IBOutlet UITextField *text_age;
    IBOutlet UITextField *text_ans1;
    IBOutlet UITextField *text_ans2;
    IBOutlet UITextField *text_ans3;
    IBOutlet UITextField *text_ans4;
    IBOutlet UITextField *text_ans5;
    IBOutlet UITextField *text_gender;

    IBOutlet TPKeyboardAvoidingScrollView *main_scrol;
    
    IBOutlet UILabel *lblQes1;
    IBOutlet UILabel *lblQes2;
    IBOutlet UILabel *lblQes3;
    IBOutlet UILabel *lblQes4;
    IBOutlet UILabel *lblQes5;

    UIView *viewPicker,*viewTap;
    UIButton *done_btn ;
    UIPickerView *picker;
    NSInteger ptemp,temp;
    NSArray *picker_array,*dataArray;
    UITextField *tempTextField;
    
    IBOutlet UIView *viewCheck;
    
    NSMutableArray *chechUncheck;
}
@property(nonatomic,strong)NSString *entry_id;
@end
