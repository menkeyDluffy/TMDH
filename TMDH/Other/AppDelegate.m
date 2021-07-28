//
//  AppDelegate.m
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import "AppDelegate.h"
#import "TMNavigationVC.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    TMNavigationVC *navVC = [[TMNavigationVC alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = navVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
