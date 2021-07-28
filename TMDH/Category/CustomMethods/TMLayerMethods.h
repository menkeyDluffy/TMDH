//
//  TMLayerMethods.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMLayerMethods : NSObject

/** 创建label*/
+ (UILabel *)getLabelForTitle:(NSString *)title Font:(UIFont *)font TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment;

/** 创建button*/
+ (UIButton *)getClipButtonForTitle:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor MasksToBounds:(BOOL)masksToBounds CornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
