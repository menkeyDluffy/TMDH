//
//  TMRouter.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "TMRouter.h"
#import "TMBaseVC.h"
#import "TMNavigationVC.h"

@interface TMRouter()

@end

@implementation TMRouter

+ (instancetype)sharedInstance
{
    static TMRouter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)pushToVC:(NSString *)name
{
    [self pushToVC:name extraParams:@{}];
}

- (void)pushToVC:(NSString *)name extraParams:(NSDictionary *)params
{
    [self pushtoVC:name checkLogin:NO extraParams:params];
}

- (void)pushtoVC:(NSString *)name checkLogin:(BOOL)checkLogin extraParams:(NSDictionary *)params
{
    if ([TMCommonlyMethods isEmPty:name]) {
        
        NSLog(@"控制器名称为空");
        return;
    }

    if (checkLogin) {//检查是否用户是否已经登录，未登录跳转到登录界面
        
        
    }
    
    TMBaseVC *vc = [self createVC:name extraParams:params];
    if (!vc) {
        
        return;
    }
    
    UINavigationController *navigationViewController = [UIViewController topViewController].navigationController;
    [navigationViewController pushViewController:vc animated:YES];
}


/** 根据名称生成控制器*/
- (TMBaseVC *)createVC:(NSString *)name extraParams:(NSDictionary *)params
{
    if ([TMCommonlyMethods isEmPty:name]) {
        
        return nil;
    }
    
    Class cls = NSClassFromString(name);
    if (!cls) {
        return nil;
    }
    
    NSParameterAssert([cls isSubclassOfClass:[TMBaseVC class]]);
    NSParameterAssert([cls instancesRespondToSelector:@selector(initWithParams:)]);
    TMBaseVC *vc = [[cls alloc] initWithParams:params];
    vc.hidesBottomBarWhenPushed = YES;
    
    return vc;
}


- (void)popToViewModelAnimated:(BOOL)animated
{
    UINavigationController *navigationViewController = [UIViewController topViewController].navigationController;
    if (navigationViewController) {
        
        NSLog(@"popToViewModelAnimated: navigationViewController为空");
        return;
    }
    
    [navigationViewController popViewControllerAnimated:animated];
}

- (void)popToRootViewModelAnimated:(BOOL)animated
{
    UINavigationController *navigationViewController = [UIViewController topViewController].navigationController;
    if (!navigationViewController) {
        
        NSLog(@"popToRootViewModelAnimated: navigationViewController为空");
        return;
    }
    
    [navigationViewController popToRootViewControllerAnimated:animated];
}

- (void)popNumberOfStack:(NSInteger)number animated:(BOOL)animated
{
    UINavigationController *navigationViewController = [UIViewController topViewController].navigationController;
    if (!navigationViewController) {
        
        NSLog(@"popToRootViewModelAnimated: navigationViewController为空");
        return;
    }
    
    if (number == 0) {
        
        [navigationViewController popViewControllerAnimated:animated];
        return;
    }
    
    if (number >= navigationViewController.viewControllers.count) {
        
        [navigationViewController popToRootViewControllerAnimated:animated];
        return;
    }
    
    [navigationViewController popToViewController:navigationViewController.viewControllers[navigationViewController.viewControllers.count - (number + 1)] animated:animated];
}

@end
