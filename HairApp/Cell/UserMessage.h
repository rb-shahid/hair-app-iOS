//
//  UserMessage.h
//  HairApp
//
//  Created by Apple on 17/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserMessage : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (strong, nonatomic) IBOutlet UILabel *message;
@end
