//
//  UIColor+Extension.h
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    NSInteger r;//0~255;
    NSInteger g;//0~255;
    NSInteger b;//0~255;
    NSInteger a;//0~255;
} TM_ColorValue;

CG_INLINE TM_ColorValue TM_ColorValueMake(NSInteger R, NSInteger G, NSInteger B, NSInteger A) {
    TM_ColorValue color;
    color.r = R;
    color.g = G;
    color.b = B;
    color.a = A;
    return color;
}

@interface UIColor (Extension)

// 生成纯色图片
- (UIImage *)color2Image;
- (UIImage *)color2ImageSized:(CGSize)size;
- (UIImage *)color2CircleImage:(CGSize)size;


/**
 * 两个颜色之间的过渡颜色
 * beginColor 开始颜色
 * endColor 结束颜色
 * coe 过渡的比例 （0~1）
 */
+ (instancetype)tm_transitionColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor andCoe:(double)coe;

/**
 * 取两个颜色的过渡颜色
 * beginColorHex 开始颜色的 十六进制值
 * endColorHex 结束颜色的 十六进制值
 * coe 过渡比例 （0~1）
 */
+ (instancetype)tm_transitionColorWithStartHex:(NSString *)startHex endHex:(NSString *)endColorHex andCoe:(double)coe;

/**
 * 两个色值之间的过渡颜色
 * beginValue 开始色值
 * endValue 结束色值
 * coe 过渡比例 （0~1）
 */
+ (instancetype)tm_transitionColorWithStartValue:(TM_ColorValue)startValue endValue:(TM_ColorValue)endValue andCoe:(double)coe;

@end

NS_ASSUME_NONNULL_END
