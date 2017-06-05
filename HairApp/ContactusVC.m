//
//  ContactusVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ContactusVC.h"

@interface ContactusVC ()

@end

@implementation ContactusVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    GET_HEADER_VIEW
    
    text_email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_email.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    text_subject.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_subject.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    text_name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:text_name.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
}

- (IBAction)tap_login:(id)sender
{
    
    if (text_subject.text.length > 0 && text_email.text.length > 0  && text_name.text.length > 0 )
    {
        if ([WebServiceCalls isValidEmail:text_email.text] == YES)
        {
            HIDE_KEY
            [SVProgressHUD showWithStatus:@"Sending wait..."];
            
            [self performSelector:@selector(userLogin) withObject:nil afterDelay:0];
        }
        else [WebServiceCalls warningAlert:@"Please enter valid email address."];
    }
    else [WebServiceCalls warningAlert:@"All field required."];
    
}

-(void)userLogin
{
    NSString *string = [NSString stringWithFormat:@"contactus.php?name=%@&email=%@&subject=%@&details=%@",text_name.text,text_email.text,text_subject.text,text_description];
    [WebServiceCalls POST:string parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         [SVProgressHUD dismiss];
         @try
         {
            if ([JSON [@"Status"] integerValue]==10)
             {
                 [WebServiceCalls warningAlert:@"Email or Password is Incorrect"];
             }
             else if ([JSON [@"Status"] integerValue]==0)
             {
                 text_name.text = text_email.text = text_subject.text = nil;
                 text_description.text = @"Description";
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thank you for contacting us." message:@"We will respond as soon as possible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
             }
         } @catch (NSException *exception) {
             
         } @finally {
             
         }
     }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [tp_scroll setContentSize:CGSizeMake(WIDTH, HEIGHT+100)];
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}


-(void) textViewDidChange:(UITextView *)textView
{
    
    if(textView.text.length == 0)
    {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Description";
        [textView resignFirstResponder];
    }
}


-(void) textViewDidEndEditing:(UITextView *)textView
{
    
    if(textView.text.length == 0)
    {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Description";
        [textView resignFirstResponder];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [AppDelegate AppDelegate].menuTag = 5;

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
