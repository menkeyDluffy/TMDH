//
//  TMNavigationVC.h
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMNavigationVC : UINavigationController

@property (nonatomic, copy) void (^pushBlock)(void);
@property (nonatomic, copy) void (^popBlock)(void);


@end

NS_ASSUME_NONNULL_END
