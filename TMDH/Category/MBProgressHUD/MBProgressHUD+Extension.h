//
//  MBProgressHUD+Extension.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Extension)

/***成功提示*/
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccessWithTop:(NSString *)success;
/***错误提示*/
+ (void)showError:(NSString *)error;
/***自定义按钮提示*/
+ (void)showMessage:(NSString *)message icon:(NSString *)icon;
/***消息提示*/
+ (void)showMessage:(NSString *)message;
/** 显示进度指示器 type:(0:全屏，1:除去tabbar，2:除去导航栏，3:除去导航栏和tabbar)*/
+ (void)showActivityIndicatorForType:(NSInteger)type;
/** 显示进度指示器(带文字) type:(0:全屏，1:除去tabbar，2:除去导航栏，3:除去导航栏和tabbar)*/
+ (void)showActivityIndicatorWithMessage:(NSString *)message type:(NSInteger)type;
/** 隐藏进度指示器 */
+ (void)hideActivityIndicator;
/** 显示加载动画，控制可否点击背景 */
+ (void)showActivityIndicatorWithUserInteractionEnabled:(BOOL)enabled;

+(void)showHUD;
+(void)hideHUD;

@end

NS_ASSUME_NONNULL_END
