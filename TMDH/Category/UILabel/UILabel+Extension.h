//
//  UILabel+Extension.h
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
   改变行间距和部分文字加下划线
 */
+ (void)changeLineSpaceWidthUnderLineForLabel:(UILabel *)label WithSpace:(float)space withUnderLineRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
