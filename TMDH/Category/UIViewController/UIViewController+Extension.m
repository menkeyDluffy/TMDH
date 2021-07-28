//
//  UIViewController+Extension.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (UIViewController *)topViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].windows.firstObject.rootViewController;
    return [[UIViewController class] topViewControllerOfViewController:rootViewController];
}

+ (UIViewController *)topViewControllerOfViewController:(nullable UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedViewController = ((UITabBarController *)viewController).selectedViewController;
        return [UIViewController topViewControllerOfViewController:selectedViewController];
    }
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visibleViewController = ((UINavigationController *)viewController).visibleViewController;
        return [UIViewController topViewControllerOfViewController:visibleViewController];
    }
    
    if (viewController.presentedViewController) {
        return [UIViewController topViewControllerOfViewController:viewController.presentedViewController];
    }
    
    for (UIView *subView in viewController.view.subviews) {
        id childViewController = subView.nextResponder;
        if ([childViewController isKindOfClass:[UIViewController class]]) {
            return [UIViewController topViewControllerOfViewController:childViewController];
        }
    }
    
    return viewController;
}

/** 获取当前控制器*/
+ (UIViewController *)currentViewController
{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end
