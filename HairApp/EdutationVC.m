//
//  EdutationVC.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "EdutationVC.h"
#import "EducationCell.h"

@interface EdutationVC ()
{
    NSMutableArray *responceArray;
}
@end

@implementation EdutationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    HIDE_NAV_BAR
    GET_HEADER_VIEW
    dic_image = [NSMutableDictionary dictionary];
}

-(void)fireJson
{

    [WebServiceCalls POST:@"education_list.php" parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         @try
         {
             responceArray = [NSMutableArray arrayWithArray:JSON[@"details"]];
             [table reloadData];
             [SVProgressHUD dismiss];
            
         } @catch (NSException *exception)
         {
             
         } @finally {
             
         }
     }];
}

#pragma TableView Delegate

-(CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 280;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return responceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *staticCell = @"cell";
    
    EducationCell *cell = (EducationCell *)[tableView  dequeueReusableCellWithIdentifier:staticCell];
    @try
    {
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] objectAtIndex:1];
        }
        
        cell.title.text = [[responceArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        
        NSString *date = [[responceArray objectAtIndex:indexPath.row] objectForKey:@"added_datetime"];
        cell.date.text = [date substringWithRange:NSMakeRange(0, 10)];
        cell.text.text = [[responceArray objectAtIndex:indexPath.row] objectForKey:@"details"];
        
        if ([dic_image objectForKey:responceArray[indexPath.row][@"id"]])
        {
            cell.image.image = [UIImage imageWithData:[dic_image objectForKey:responceArray[indexPath.row][@"id"]]];
        }
        else
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void)
                           {
                               @try
                               {
                                   NSString *image_url = [NSString stringWithFormat:@"http:%@",[[responceArray objectAtIndex:indexPath.row] objectForKey:@"photo"]];
                                   NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                                   
                                   if (imgData)
                                   {
                                       [dic_image setObject:imgData forKey:responceArray[indexPath.row][@"id"]];
                                       dispatch_sync(dispatch_get_main_queue(), ^(void)
                                                     {
                                                         cell.image.image = [UIImage imageWithData:imgData];
                                                         
                                                     });
                                   }
                                   
                               } @catch (NSException *exception)
                               {
                                   
                               } @finally {
                                   
                               }
                               
                               
                           });
        }
        return cell;
        
    } @catch (NSException *exception)
    {
        
    } @finally
    {
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [AppDelegate AppDelegate].menuTag = 0;
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
