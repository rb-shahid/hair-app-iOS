//
//  MenuView.h
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *imageArray,*titleArray;
}

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *tap_view;
@property(nonatomic,strong)UIViewController *backSelf;


@end
