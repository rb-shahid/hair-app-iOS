//
//  AboutusVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "AboutusVC.h"

@interface AboutusVC ()

@end

@implementation AboutusVC

- (void)viewDidLoad {
    [super viewDidLoad];

    GET_HEADER_VIEW
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
}

-(void)fireJson
{
   
    [WebServiceCalls POST:@"aboutus.php" parameter:nil completionBlock:^(id JSON, WebServiceResult result)
    {
         @try
         {
             if ([JSON [@"Status"] integerValue]==0)
             {
                 about_text.text = JSON[@"details"][@"aboutus"];
                 about_text.hidden = YES;
                 UIWebView *webView = [[UIWebView alloc]initWithFrame:about_text.frame];
                 [webView loadHTMLString:[NSString stringWithFormat:@"<html><body >%@</body></html>",JSON[@"details"][@"aboutus"]] baseURL:nil];
                 webView.backgroundColor = [UIColor clearColor];
                 [self.view addSubview:webView];
                 [self performSelector:@selector(dismissHud) withObject:nil afterDelay:1];
                 
             }
         
         } @catch (NSException *exception)
         {
             [SVProgressHUD dismiss];

         } @finally
         {

         }
     }];
    
}
-(void)dismissHud
{
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [AppDelegate AppDelegate].menuTag = 3;

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

@end
