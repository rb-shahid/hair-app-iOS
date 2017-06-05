//
//  LocationCell.h
//  HairApp
//
//  Created by Apple on 15/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *loc_image;
@property (strong, nonatomic) IBOutlet UILabel *loc_title;
@property (strong, nonatomic) IBOutlet UILabel *loc_address;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *tollFree;
@property (strong, nonatomic) IBOutlet UIButton *btn_phone;
@property (strong, nonatomic) IBOutlet UIButton *btn_toll;
@property (strong, nonatomic) IBOutlet UIButton *btn_dir;

@end
