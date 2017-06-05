//
//  EdutationVC.h
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EdutationVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{

    IBOutlet UITableView *table;
    NSMutableDictionary *dic_image;

}
@end
