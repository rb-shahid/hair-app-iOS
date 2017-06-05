//
//  AppDelegate.m
//  HairApp
//
//  Created by Apple on 08/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+(AppDelegate *)AppDelegate {
    return
    [UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self registerForNotification:application];
    
    UserSession *user =[[UserSession alloc]initWithSession];
    
    if (user.user_id != nil && launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MessageVC *obj = [storybord instantiateViewControllerWithIdentifier:@"MessageVC"];
        UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:obj];
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
        
        return YES;
    }
    
    
    [AppDelegate AppDelegate].menuTag = 100;
    [SVProgressHUD  setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD  setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginVC *obj = [storybord instantiateViewControllerWithIdentifier:@"LoginVC"];

    if (user.user_id)
    {
        obj = [storybord instantiateViewControllerWithIdentifier:@"EdutationVC"];
    }
    
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:obj];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)registerForNotification:(UIApplication *)application {
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
        
    } else {
        
        [application registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error:%@",error);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"%@",token);
    
//    device_register.php?user_id=#&regiistration_id=#
    
    UserSession *user =[[UserSession alloc]initWithSession];
    if (user.user_id)
    {
        [WebServiceCalls POST:@"device_register.php" parameter:@{@"user_id":user.user_id, @"regiistration_id":token} completionBlock:^(id JSON, WebServiceResult result) {
            
            NSLog(@"%@", JSON);
        }];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"%@", userInfo);
    
    UserSession *user =[[UserSession alloc]initWithSession];
    
    if (application.applicationState == UIApplicationStateActive && user.user_id != nil) {
        
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MessageVC *obj = [storybord instantiateViewControllerWithIdentifier:@"MessageVC"];
        UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:obj];
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
