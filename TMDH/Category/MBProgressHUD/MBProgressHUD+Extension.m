//
//  MBProgressHUD+Extension.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

static MBProgressHUD *HUD;

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon
{
    UIView  *view = ![self getCurrentVC].view? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentVC].view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
//    hud.color = [UIColor blackColor];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark 显示信息 图层最上方
+ (void)showTopWithView:(NSString *)text icon:(NSString *)icon
{
    UIView  *view = (UIView*)[UIApplication sharedApplication].delegate.window;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
//    hud.color = [UIColor blackColor];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

#pragma mark 显示错误、成功信息
+ (void)showError:(NSString *)error
{
    [self show:error icon:[NSString stringWithFormat:@"MBProgress_error.png"]];
}

+ (void)showSuccess:(NSString *)success
{
    [self show:success icon:[NSString stringWithFormat:@"MBProgress_success.png"]];
}
/** 返回上一级还存在 */
+ (void)showSuccessWithTop:(NSString *)success
{
    [self showTopWithView:success icon:[NSString stringWithFormat:@"MBProgress_success.png"]];
}

+ (void)showMessage:(NSString *)message icon:(NSString *)icon
{
    [self show:message icon:icon];
}

+ (void)showMessage:(NSString *)message
{
    
    UIView  *view = ![self getCurrentVC].view? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentVC].view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1];
}

+ (void)showActivityIndicatorForType:(NSInteger)type {
    
    [self showActivityIndicatorWithMessage:@"" type:type];
}

+ (void)showActivityIndicatorWithUserInteractionEnabled:(BOOL)enabled
{
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    UIView *bgView = [self getBackgroundViewForType:0];
    [bgView addSubview:HUD];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.userInteractionEnabled = enabled;
    [HUD showAnimated:YES];
}

+ (void)showActivityIndicatorWithMessage:(NSString *)message type:(NSInteger)type
{
    UIView *view = ![self getCurrentVC].view? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentVC].view;
    HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    UIView *bgView = [self getBackgroundViewForType:type];
    [bgView addSubview:HUD];
    [view addSubview:bgView];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.userInteractionEnabled = NO;
    if (message) {
         HUD.detailsLabel.text = message;
    }
   
    [HUD showAnimated:YES];
}

+ (void)hideActivityIndicator
{
    [HUD hideAnimated:YES];
    UIView *view = [HUD superview];
    [view removeFromSuperview];
}


+ (UIViewController*)getCurrentVC
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];

}



+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
        
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    } else {
        
        return rootViewController;
        
    }
}


+ (void)showHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.removeFromSuperViewOnHide = YES;
}

// 在指定的view上隐藏HUD
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    [self hideHUDForView:view animated:YES];
}

// 显示HUD
+ (void)showHUD
{
    [self showHUDForView:nil];
}

// 隐藏HUD
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (UIView *)getBackgroundViewForType:(NSInteger)type
{
    UIView *bgView;
    if (type == 0) {//全屏view
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }else if (type == 1) {//除去tabbar
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight)];
    }else if (type == 2){//除去导航栏
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
    }else {//除去导航栏和tabbar
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabbarHeight)];
    }
    bgView.backgroundColor = [UIColor clearColor];
    return bgView;
}

@end
