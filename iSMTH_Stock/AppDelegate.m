//
//  AppDelegate.m
//  iSMTH_Stock
//
//  Created by  on 12-3-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "smth_favoriteBoard.h"

#import "smth_boardSearch.h"
#import "smth_waterflowPictureShow.h"
#import "AppAboutViewController.h"
#import "MobClick.h"

#import "TempViewController.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navigationController=_navigationController;


//508dfc395270151c54000046

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MobClick startWithAppkey:UMENG_ID reportPolicy:REALTIME channelId:nil];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2,*viewController3, *viewController4;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[smth_favoriteBoard alloc] initWithNibName:@"smth_favoriteBoard_iPhone" bundle:nil];
        viewController2 = [[smth_boardSearch alloc] initWithNibName:@"smth_boardSearch_iPhone" bundle:nil];
        viewController3 = [[smth_waterflowPictureShow alloc] initWithNibName:@"smth_waterflowPictureShow" bundle:nil];
        
        viewController4 = [[AppAboutViewController alloc] initWithNibName:@"AppAboutViewController" bundle:nil];
    } else {
        viewController1 = [[smth_favoriteBoard alloc] initWithNibName:@"smth_favoriteBoard_iPad" bundle:nil];
        viewController2 = [[smth_boardSearch alloc] initWithNibName:@"smth_boardSearch_iPad" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3,viewController4,nil];
    self.window.rootViewController = self.tabBarController;
    //self.tabBarController.navigationController in
    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIFont fontWithName:@"Arial-Bold"size:5.0], UITextAttributeFont,
                          [UIColor colorWithRed:134/255.0 green:122/255.0 blue:65/255.0 alpha:1],UITextAttributeTextColor,
                          [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                        
                          nil];
    
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:227/255.0 green:227/255.0 blue:223/255.0 alpha:1.0];
    
    self.navigationController.navigationBar.topItem.title = @"精彩板块";
    //self.navigationController.navigationBar.topItem.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/
static void uncaughtExceptionHandler(NSException *exception) {
    
    NSLog(@"CRASH: %@", exception);
    
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    
    // Internal error reporting
    
}

@end
