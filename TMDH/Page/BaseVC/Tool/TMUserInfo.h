//
//  TMUserInfo.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TMUserInfoInstance [TMUserInfo sharedInstance]

@interface TMUserInfo : NSObject

/**
 登录状态
 */
@property (nonatomic, assign, readonly) BOOL isLogined;

+ (instancetype)sharedInstance;


@end

NS_ASSUME_NONNULL_END
