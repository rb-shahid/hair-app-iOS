//
//  AppDelegate.h
//  HairApp
//
//  Created by Apple on 08/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readwrite) NSUInteger menuTag;

+(AppDelegate *)AppDelegate;
- (void)registerForNotification:(UIApplication *)application;

@end

