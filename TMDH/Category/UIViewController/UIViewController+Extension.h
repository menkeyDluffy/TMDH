//
//  UIViewController+Extension.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)

/** 获取当前程序的最顶层ViewController */
+ (UIViewController *)topViewController;

/** 获取当前控制器*/
+ (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
