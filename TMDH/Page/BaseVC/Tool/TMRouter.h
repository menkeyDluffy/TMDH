//
//  TMRouter.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TMRouterInstance [TMRouter sharedInstance]

@interface TMRouter : NSObject

+ (instancetype)sharedInstance;

- (void)pushToVC:(NSString *)name;

- (void)pushToVC:(NSString *)name extraParams:(NSDictionary *)params;

- (void)pushtoVC:(NSString *)name checkLogin:(BOOL)checkLogin extraParams:(NSDictionary *)params;


/** 返回*/
- (void)popToViewModelAnimated:(BOOL)animated;
/** 返回到跟控制器*/
- (void)popToRootViewModelAnimated:(BOOL)animated;
/** 移除多少个控制器*/
- (void)popNumberOfStack:(NSInteger)number animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
