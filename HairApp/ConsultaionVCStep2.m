//
//  ConsultaionVCStep2.m
//  HairApp
//
//  Created by Apple on 15/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ConsultaionVCStep2.h"

@interface ConsultaionVCStep2 ()

@end

@implementation ConsultaionVCStep2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GET_HEADER_VIEW
    
    ptemp = 0;
    [SVProgressHUD showWithStatus:@"Loading.."];
    [self performSelector:@selector(GetQuestion) withObject:nil afterDelay:0];
    
    [main_scrol setContentSize:CGSizeMake(WIDTH,1000)];
    
    chechUncheck = [NSMutableArray array];
    NSArray *textArray = [NSArray arrayWithObjects:text_age,text_gender,text_ans1,text_ans2,text_ans3,text_ans4,text_ans5, nil];
    text_age.keyboardType = UIKeyboardTypeNumberPad;
    
    for (UITextField *text in textArray)
    {
        text.borderStyle = UITextBorderStyleRoundedRect;
        text.layer.borderWidth = 0;
        text.layer.cornerRadius = 0;
    }
    
}
-(void)GetQuestion
{
    // http://dynobranding.com/client/hairapp/api/
    
    [WebServiceCalls POST:@"queations_list.php" parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         @try
         {
             [SVProgressHUD dismiss];
             NSArray *lblArray = [NSArray arrayWithObjects:lblQes1,lblQes2,lblQes3,lblQes4,lblQes5, nil];
             dataArray = [NSArray arrayWithArray:JSON[@"details"]];
             int count = 2;
           
             for (UILabel *lbl in lblArray)
             {
                 lbl.text = JSON[@"details"][count][@"title"];
                 lbl.numberOfLines = 2;
                 count++;
             }
             
             float yPoint=30,xPoint=10;
             for (int i =0; i<[dataArray[2][@"field_data"] count]; i++)
             {
                 UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(xPoint, yPoint, 30, 30)];
                 [btn setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
                 [viewCheck addSubview:btn];
                 [btn addTarget:self action:@selector(checkUnckeck:) forControlEvents:UIControlEventTouchUpInside];
                 btn.tag = i;
                 
                 UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(xPoint+40, yPoint,WIDTH/2,30)];
                 lable.textColor = APP_COLOR;
                 [viewCheck addSubview:lable];
                 lable.text = [dataArray[2][@"field_data"] objectAtIndex:i];
                 lable.font = [UIFont systemFontOfSize:14];
                 
                 if (i%2==1)
                 {
                     xPoint =10;
                     yPoint +=40;
                 }
                 else
                 {
                     xPoint =WIDTH/2;
                 }
                 [chechUncheck addObject:@"0"];
             }
             
         } @catch (NSException *exception) {
             
         } @finally {
             
         }
    }];
}

-(void)checkUnckeck:(UIButton *)sender
{
    if ([[chechUncheck objectAtIndex:sender.tag] integerValue]==0)
    {
        [chechUncheck replaceObjectAtIndex:sender.tag withObject:@"1"];
        [sender setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
    else
    {
        [chechUncheck replaceObjectAtIndex:sender.tag withObject:@"0"];
        [sender setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)tap_send:(id)sender
{
    
}

#pragma mark Picker Delegate

- (IBAction)open_picker:(UIButton *)sender
{
    [self.view endEditing:YES];

    NSArray *array = [NSArray arrayWithObjects:text_gender,text_ans2,text_ans3,text_ans4, nil];
    tempTextField = [array objectAtIndex:sender.tag];
    if (sender.tag == 0)
    {
        picker_array = @[@"Male",@"Female"];
        text_gender.text = @"Male";
    }
    else
    {
        picker_array = @[@"Yes",@"No"];
    }
    
    if(ptemp==0)
    {
        viewTap = [[UIView alloc]initWithFrame:self.view.frame];
        viewTap.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        [self.view addSubview:viewTap];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePicker)];
        [viewTap addGestureRecognizer:tap];
        
        viewPicker =[[UIView alloc]initWithFrame:CGRectMake(0 ,HEIGHT,WIDTH,HEIGHT/4)];
        [self.view addSubview:viewPicker];
        viewPicker.backgroundColor = [UIColor lightGrayColor];
       
        picker =[[UIPickerView alloc]initWithFrame:CGRectMake(0 ,30,WIDTH,HEIGHT/4)];
        [picker setValue:[UIColor whiteColor] forKey:@"textColor"];
        picker.backgroundColor=[UIColor colorWithRed:13/255.0f green:138/255.0f blue:166/255.0f alpha:1.0f];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = YES;
        [viewPicker addSubview:picker];
        
        done_btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 60 ,0,60,30)];
        [done_btn setTitle:@"Done" forState:UIControlStateNormal];
        [done_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        done_btn.layer.shadowColor = [UIColor grayColor].CGColor;
        // [done_btn setBackgroundColor:[UIColor colorWithRed:13/255.0f green:138/255.0f blue:166/255.0f alpha:1.0f]];
        [done_btn addTarget:self action:@selector(hidePicker) forControlEvents:UIControlEventTouchUpInside];
        [viewPicker addSubview:done_btn];
        
        ptemp++;
        
        [UIView animateWithDuration:0.3 animations:^{
            viewPicker.frame=CGRectMake(0 ,HEIGHT/2+HEIGHT/4-30,WIDTH,HEIGHT/4);
        }];
    }
    else
    {
        ptemp=0;
    }

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return picker_array.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [picker_array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    tempTextField.text = [picker_array objectAtIndex:row];
    
}

-(void)hidePicker
{
    viewTap.hidden = YES;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        viewPicker.frame=CGRectMake(0 ,HEIGHT,WIDTH,HEIGHT/4);

    } completion:^(BOOL finished) {
        ptemp=0;
        [viewPicker removeFromSuperview];
        [viewTap removeFromSuperview];

    }];
}

- (IBAction)submint:(id)sender
{
    
    NSString *checkString = @"";
  
    for (int i =0; i<[dataArray[2][@"field_data"] count]; i++)
    {
        if ([[chechUncheck objectAtIndex:i] integerValue]==1)
        {
            if (checkString.length>0)
            {
                checkString = [NSString stringWithFormat:@"%@,%@",checkString,[dataArray[2][@"field_data"] objectAtIndex:i]];
            }
            else checkString = [NSString stringWithFormat:@"%@",[dataArray[2][@"field_data"] objectAtIndex:i]];
        }
    }
    
    if (text_ans2.text.length>0 && text_ans3.text.length>0 &&  text_ans4.text.length>0 && text_ans5.text.length>0 && text_gender.text.length>0 && text_age.text.length>0)
    {
        UserSession *user = [[UserSession alloc]initWithSession];

        NSArray *textArray = [NSArray arrayWithObjects:text_age,text_gender,text_ans2,text_ans3,text_ans4,text_ans5, nil];
        
        NSString *urlString = [NSString stringWithFormat:@"consultation_step1.php?user_id=%@,entry_id=%@",user.user_id,self.entry_id];

        for (int i=0; i<textArray.count; i++)
        {
            NSString *data_id = [NSString stringWithFormat:@"%@",dataArray[i][@"id"]];
            UITextField *text = [textArray objectAtIndex:i];
            if (i==1)
            {
                urlString = [NSString stringWithFormat:@"%@&[%@]=%@",urlString,data_id,text.text.lowercaseString];
            }
            else urlString = [NSString stringWithFormat:@"%@&[%@]=%@",urlString,data_id,checkString.lowercaseString];
            
        }
        
        [SVProgressHUD showWithStatus:@"Sending details.."];
        [WebServiceCalls POST:@"consultation_step2.php?" parameter:nil completionBlock:^(id JSON, WebServiceResult result)
         {
             [SVProgressHUD dismiss];
             NSArray *textArray = [NSArray arrayWithObjects:text_age,text_gender,text_ans2,text_ans3,text_ans4,text_ans5, nil];
             
             for (int i=0; i<textArray.count; i++)
             {
                 UITextField *text = [textArray objectAtIndex:i];
                 text.text = nil;
             }

             
             UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Thank You"  message:@"Successfully submitted" preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* restore = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                       {
                                           
                                               NSArray *nav_array = [self.navigationController viewControllers];
                                               
                                               for (UIViewController *controller in nav_array)
                                               {
                                                   if ([controller isKindOfClass:[EdutationVC class]])
                                                   {
                                                       //Do not forget to import AnOldViewController.h
                                                       
                                                       [self.navigationController popToViewController:controller animated:YES];
                                                       return;
                                                   }
                                               }
                                           
                                       }];
             [alert addAction:restore];
             [self presentViewController:alert animated:YES completion:nil];
             
         }];
        
      /*  UserSession *user = [[UserSession alloc]initWithSession];
        
       [SVProgressHUD showWithStatus:@"wait"];
       
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        
        [manager POST:[[NSString stringWithFormat:@"%@%@",BASE_URL,@"consultation_step1.php"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:@{@"user_id":user.user_id} constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
           
         }
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
             [self performSegueWithIdentifier:@"step2segue" sender:nil];
             
             [SVProgressHUD dismiss];
             
         }
              failure:^(AFHTTPRequestOperation *operation, NSError* error){} ]; */
       }
    else [WebServiceCalls warningAlert:@"All Field Required"];
}




HIDE_KEY_ON_TOUCH
@end
