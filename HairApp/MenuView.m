//
//  MenuView.m
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

@synthesize table,tap_view,backSelf;

- (void)drawRect:(CGRect)rect
{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = backSelf.view.frame;
    }];
    
    titleArray = @[@"Education",@"Consultation",@"Messages",@"About Us",@"Location",@"Contact Us",@"Update Profile",@"Reset Password",@"Logout"];
    imageArray = @[@"education",@"user",@"message",@"about",@"loction",@"phone",@"about",@"about",@"logout"];
    
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    table.separatorColor = BLACK_COLOR;
}

-(CGFloat)tableView:(UITableView* )tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *staticCell = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:staticCell];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:staticCell];
    }
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(30,15,30,25)];
    image.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    [cell addSubview: image];
    
    cell.textLabel.text = [NSString stringWithFormat:@"               %@",[titleArray objectAtIndex:indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = WHITE_COLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([AppDelegate AppDelegate].menuTag == indexPath.row)
    {
        [self tapGeasture:@""];
    }
    else
    {
        [AppDelegate AppDelegate].menuTag = indexPath.row;

        if (indexPath.row==0)
        {
            
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[EdutationVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }

            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            EdutationVC *obj = [storybord instantiateViewControllerWithIdentifier:@"EdutationVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==1)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[ConsoltationVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ConsoltationVC *obj = [storybord instantiateViewControllerWithIdentifier:@"ConsoltationVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==2)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[MessageVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MessageVC *obj = [storybord instantiateViewControllerWithIdentifier:@"MessageVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==3)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[AboutusVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AboutusVC *obj = [storybord instantiateViewControllerWithIdentifier:@"AboutusVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==4)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[LocationsVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LocationsVC *obj = [storybord instantiateViewControllerWithIdentifier:@"LocationsVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==5)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[ContactusVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ContactusVC *obj = [storybord instantiateViewControllerWithIdentifier:@"ContactusVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==6)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[UpdateProfileVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UpdateProfileVC *obj = [storybord instantiateViewControllerWithIdentifier:@"UpdateProfileVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else if (indexPath.row==7)
        {
            NSArray *nav_array = [self.backSelf.navigationController viewControllers];
            for (UIViewController *controller in nav_array)
            {
                if ([controller isKindOfClass:[ResetPasswordVC class]])
                {
                    //Do not forget to import AnOldViewController.h
                    
                    [self.backSelf.navigationController popToViewController:controller animated:YES];
                    return;
                }
            }
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ResetPasswordVC *obj = [storybord instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
            [self.backSelf.navigationController pushViewController:obj animated:YES];
        }
        else
        {
            
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Logout" message:@"Are you sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){  }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                       {
                                           [UserSession clearSession];
                                           
                                           NSArray *nav_array = [self.backSelf.navigationController viewControllers];
                                           
                                           int count = 0;
                                           for (UIViewController *controller in nav_array)
                                           {
                                               if ([controller isKindOfClass:[LoginVC class]])
                                               {
                                                   //Do not forget to import AnOldViewController.h
                                                   count++;
                                                   [self.backSelf.navigationController popToViewController:controller animated:NO];
                                                   return;
                                               }
                                           }
                                           
                                           // [self.backSelf.navigationController viewControllers] = NULL;
                                           
                                           if (count == 0)
                                           {
                                               LoginVC *newView = [self.backSelf.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                                               [self.backSelf.navigationController pushViewController:newView animated:NO];
                                           }
                                           
                                           
                                       }];
            
            [alertController addAction:cancelAction ];
            [alertController addAction:okAction];
            [self.backSelf presentViewController:alertController animated:YES completion:nil];
        }
    }
    
    [self performSelector:@selector(tapGeasture:) withObject:nil afterDelay:1];
}

- (IBAction)tapGeasture:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(-WIDTH,0,WIDTH,HEIGHT); }];
}
@end
