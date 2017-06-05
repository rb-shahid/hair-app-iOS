//
//  ConsoltationVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "ConsoltationVC.h"
#import "ConsultaionVCStep2.h"

@interface ConsoltationVC ()
{
    UIButton *button;
    NSMutableArray *dataArray;
    
}
@end

@implementation ConsoltationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GET_HEADER_VIEW
    
    front_side.layer.cornerRadius = left_side.layer.cornerRadius = right_side.layer.cornerRadius = back_side.layer.cornerRadius = top_side.layer.cornerRadius = back_side.layer.cornerRadius = 50;
    dataArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    
}

- (IBAction)select_emage:(UIButton *)sender
{
    button = [UIButton new];
    button = sender;
    [APPhotoLibrary sharedInstance].delegate=self;
    [[APPhotoLibrary sharedInstance]openPhotoFromCameraAndLibrary:self];
}

-(void)apActionSheetGetImage:(UIImage *)selectedPhoto
{
   // CGSize newSize = CGSizeMake(5,5);
    CGSize newSize = CGSizeMake(300,300);
    UIGraphicsBeginImageContext(newSize);
    [selectedPhoto drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [button setTitle:nil forState:UIControlStateNormal];
    [button setBackgroundImage:newImage forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 50;
    NSData *image_data = UIImageJPEGRepresentation(newImage,0.1);
    
    [dataArray replaceObjectAtIndex:button.tag withObject:image_data];
}

-(void)apActionSheetGetVideo:(NSURL *)selectedVideo
{
    
}
-(void)apActionSheetGetVideoThumbImage:(UIImage *)selectedVideoThumbImage
{
    
}

- (IBAction)tap_upload_image:(id)sender
{
    
   /* UIStoryboard *stepStoryBoard = [UIStoryboard storyboardWithName:@"Step" bundle:nil];
    ConsultaionVCStep2 *obj = [stepStoryBoard instantiateViewControllerWithIdentifier:@"ConsultaionVCStep2"];
    [self presentViewController:obj animated:YES completion:nil]; */
    
    // [self.navigationController pushViewController:obj animated:YES];

    int count = 0;
    
    for (int i =0 ;i<dataArray.count; i++)
    {
        if ([dataArray[i] length]==1)
        {
            count++;
        }
    }
    
    if (count == 0)
    {
        UserSession *user = [[UserSession alloc]initWithSession];
        [SVProgressHUD showWithStatus:@"Uploading.."];

        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[[NSString stringWithFormat:@"%@%@",BASE_URL,@"consultation_step1.php?="] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:@{@"user_id":user.user_id} constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         {
             [formData appendPartWithFileData:[dataArray objectAtIndex:0] name:@"image1" fileName:@"image1.jpg" mimeType:@"image/jpeg"];
             [formData appendPartWithFileData:[dataArray objectAtIndex:1] name:@"image2" fileName:@"image2.jpg" mimeType:@"image/jpeg"];
             [formData appendPartWithFileData:[dataArray objectAtIndex:2] name:@"image3" fileName:@"image3.jpg" mimeType:@"image/jpeg"];
             [formData appendPartWithFileData:[dataArray objectAtIndex:3] name:@"image4" fileName:@"image4.jpg" mimeType:@"image/jpeg"];
             [formData appendPartWithFileData:[dataArray objectAtIndex:4] name:@"image5" fileName:@"image5.jpg" mimeType:@"image/jpeg"];
         }
              success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [SVProgressHUD dismiss];
              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
              NSLog(@"%@",json);
             
             UIStoryboard *stepStoryBoard = [UIStoryboard storyboardWithName:@"Step" bundle:nil];
             ConsultaionVCStep2 *obj = [stepStoryBoard instantiateViewControllerWithIdentifier:@"ConsultaionVCStep2"];
             obj.entry_id =[NSString stringWithFormat:@"%@",json[@"details"][@"entry_id"]];
             [self.navigationController pushViewController:obj animated:YES];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError* error){} ];
    }
    else [WebServiceCalls warningAlert:@"Select All Images First"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [AppDelegate AppDelegate].menuTag = 1;

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
@end
