//
//  ConsoltationVC.h
//  HairApp
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsoltationVC : UIViewController<APPhotoPickerDelegate,UIGestureRecognizerDelegate>
{

    IBOutlet UIButton *front_side;
    IBOutlet UIButton *left_side;
    IBOutlet UIButton *right_side;
    IBOutlet UIButton *top_side;
    IBOutlet UIButton *back_side;


}
@end
