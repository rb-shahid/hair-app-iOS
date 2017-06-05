//
//  LocationsVC.h
//  HairApp
//
//  Created by Apple on 12/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface LocationsVC : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{

    IBOutlet UITableView *table;
}
@end
