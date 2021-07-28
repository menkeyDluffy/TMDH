//
//  TMBaseVC.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMBaseVC : UIViewController


// 初始化方法
- (instancetype)initWithParams:(NSDictionary *)params;
// 数据处理方法，在viewdidload前执行
- (void)initialize __attribute__((objc_requires_super));

@end

NS_ASSUME_NONNULL_END
