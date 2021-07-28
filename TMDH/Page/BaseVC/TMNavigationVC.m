//
//  TMNavigationVC.m
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import "TMNavigationVC.h"

@interface TMNavigationVC ()

@end

@implementation TMNavigationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark -
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.topViewController.presentedViewController && ![self.topViewController.presentedViewController isBeingDismissed]) {
        return [self.topViewController.presentedViewController preferredStatusBarStyle];
    }
    
    return [self.topViewController preferredStatusBarStyle];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    if (self.pushBlock) {
        self.pushBlock();
    }
}

@end
