//
//  LocationsVC.m
//  HairApp
//
//  Created by Apple on 12/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "LocationsVC.h"
#import "LocationCell.h"
@interface LocationsVC ()
{
    NSMutableArray *array_row_number;
    NSArray *responceArray;
    NSMutableDictionary *dic_image;
    
}
@end

@implementation LocationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GET_HEADER_VIEW
    dic_image = [NSMutableDictionary dictionary];
    array_row_number = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
   
}

-(void)fireJson
{
     [WebServiceCalls POST:@"locations_list.php" parameter:nil completionBlock:^(id JSON, WebServiceResult result)
     {
         @try
         {
             [SVProgressHUD dismiss];
             responceArray = [NSArray arrayWithObject:JSON[@"details"]];
             
             for (int i = 0; i<[responceArray[0] count]; i++)
             {
                 [array_row_number addObject:@"0"];
             }
             [table reloadData];
             
         } @catch (NSException *exception)
         {
             
         } @finally {
             
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [array_row_number[section] integerValue];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [responceArray[0] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 250;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float vhgt;
    vhgt = 52;
    
    UIView *view_section = [[UIView alloc]initWithFrame:CGRectMake(0,0,WIDTH,vhgt)];
    view_section.backgroundColor = HEADER_COLOR;
    
    //// -- Open CLose Button
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,0, WIDTH-43,vhgt-2)];
    titleLabel.font =[UIFont boldSystemFontOfSize:16];
    titleLabel.text=responceArray[0][section][@"title"]; //[array_title_section objectAtIndexedSubscript:section];
    titleLabel.textColor = WHITE_COLOR;
    [view_section addSubview:titleLabel];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0,50,WIDTH,2)];
    line.backgroundColor = WHITE_COLOR;
    [view_section addSubview:line];
    
    UIButton *btn_open_close = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50,11, 30,30)];
    [btn_open_close setTitleColor:HEADER_COLOR forState:UIControlStateNormal];
    btn_open_close.tag = section;
    btn_open_close.backgroundColor = WHITE_COLOR;
    btn_open_close.layer.cornerRadius = 15;
    [btn_open_close addTarget:self action:@selector(open_close_DidClick:) forControlEvents:UIControlEventTouchUpInside];
    [view_section addSubview:btn_open_close];
    
    UIButton *btn_open = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-70,0,70,52)];
    [btn_open setTitleColor:HEADER_COLOR forState:UIControlStateNormal];
    [view_section addSubview:btn_open];
    btn_open.tag = section;
    btn_open.backgroundColor = CLEAR_COLOR;
    [btn_open addTarget:self action:@selector(open_close_DidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[array_row_number objectAtIndex:section] isEqualToString:@"0"])
    {
        //[btn_open_close setTitle:@"+" forState:UIControlStateNormal];
        [btn_open_close setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    }
    else
    {
        //[btn_open_close setTitle:@"-" forState:UIControlStateNormal];
        [btn_open_close setImage:[UIImage imageNamed:@"mines"] forState:UIControlStateNormal];
    }
    
    return view_section;
}

-(void)open_close_DidClick:(UIButton *)sender
{
    if ([[array_row_number objectAtIndex:sender.tag] isEqualToString:@"0"])
    {
        [array_row_number replaceObjectAtIndex:sender.tag withObject:@"1"];
        NSRange range = NSMakeRange(sender.tag, 1);
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
        [table reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        [array_row_number replaceObjectAtIndex:sender.tag withObject:@"0"];
        NSRange range = NSMakeRange(sender.tag, 1);
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
        [table reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
        static NSString *staticCell = @"LocCell";
        
        LocationCell *cell = (LocationCell *)[tableView  dequeueReusableCellWithIdentifier:staticCell];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] objectAtIndex:0];
        }
  
    @try
    {
        cell.loc_title.text = responceArray[0][indexPath.section][@"title"];
        cell.loc_address.text = responceArray[0][indexPath.section][@"address"];
        cell.phone.text = [NSString stringWithFormat:@"%@",responceArray[0][indexPath.section][@"phone"]];
        cell.tollFree.text = [NSString stringWithFormat:@"%@",responceArray[0][indexPath.section][@"toll_free"]];

        if ([dic_image objectForKey:responceArray[0][indexPath.section][@"id"]])
        {
            cell.loc_image.image = [UIImage imageWithData:[dic_image objectForKey:responceArray[0][indexPath.section][@"id"]]];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void)
                           {
                               @try
                               {
                                   
                                   NSString *image_url = [NSString stringWithFormat:@"%@",[responceArray[0][indexPath.section] objectForKey:@"photo"]];
                                   NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                                   UIImage *imgTest =[UIImage imageWithData:imgData];
                                   if (imgData)
                                   {
                                       [dic_image setObject:imgData forKey:responceArray[0][indexPath.section][@"id"]];

                                       dispatch_sync(dispatch_get_main_queue(), ^(void)
                                                     {
                                                         cell.loc_image.image = [UIImage imageWithData:imgData];
                                                     });
                                   }
                               } @catch (NSException *exception)
                               {
                                   
                               } @finally
                               {
                                   cell.loc_image.image = [UIImage imageNamed:@"building"];
                               }
   
                           });
        }
        cell.btn_phone.tag = indexPath.section;
        [cell.btn_phone addTarget:self action:@selector(fireCall:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_toll.tag = indexPath.section;
        [cell.btn_toll addTarget:self action:@selector(fireCallTall:) forControlEvents:UIControlEventTouchUpInside];

        cell.btn_dir.tag = indexPath.section;
        [cell.btn_dir addTarget:self action:@selector(showDirections:) forControlEvents:UIControlEventTouchUpInside];

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
    [SVProgressHUD showWithStatus:@"Loading..."];
    [self performSelector:@selector(fireJson) withObject:nil afterDelay:0];
    [AppDelegate AppDelegate].menuTag = 4;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


-(void)fireCall:(UIButton *)sender {
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *number = [responceArray[0][sender.tag][@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:number];
        
        NSURL *url = [NSURL URLWithString:phoneNumber];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

-(void)fireCallTall:(UIButton *)sender {
    
    UIDevice *device = [UIDevice currentDevice];
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *number = [responceArray[0][sender.tag][@"toll_free"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:number];
        
        NSURL *url = [NSURL URLWithString:phoneNumber];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


-(void)showDirections:(UIButton *)sender {
    
    NSString *pinTitle = responceArray[0][sender.tag][@"address"];
    double toLat = [responceArray[0][sender.tag][@"lat"] doubleValue];
    double tolong = [responceArray[0][sender.tag][@"lon"] doubleValue];
    
    if (toLat>0)
    {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(toLat, tolong);
        
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:@{(id)kABPersonAddressStreetKey: pinTitle}];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        if ([mapItem respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
        {
            [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
        }
        else
        {
            NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%f,%f&saddr=Current+Location", coordinate.latitude, coordinate.longitude];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
        
    }
    else [WebServiceCalls warningAlert:@"Coordinate not avilable"];
}
@end
