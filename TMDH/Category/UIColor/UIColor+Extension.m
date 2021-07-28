//
//  UIColor+TMCategory.m
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import "UIColor+Extension.h"

/** 十六进制字符串转数字 */
NSUInteger TM_HexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

/** 提取十六进制字符串中的色值 */
BOOL TM_HexStrToRGBA(NSString *str,
                     NSInteger *r, NSInteger *g, NSInteger *b, NSInteger *a) {
    str = [str uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = TM_HexStrToInt([str substringWithRange:NSMakeRange(0, 1)]);
        *g = TM_HexStrToInt([str substringWithRange:NSMakeRange(1, 1)]);
        *b = TM_HexStrToInt([str substringWithRange:NSMakeRange(2, 1)]);
        if (length == 4){
            *a = TM_HexStrToInt([str substringWithRange:NSMakeRange(3, 1)]);
        } else {
            *a = 255;
        }
    } else {
        *r = TM_HexStrToInt([str substringWithRange:NSMakeRange(0, 2)]);
        *g = TM_HexStrToInt([str substringWithRange:NSMakeRange(2, 2)]);
        *b = TM_HexStrToInt([str substringWithRange:NSMakeRange(4, 2)]);
        if (length == 8) {
            *a = TM_HexStrToInt([str substringWithRange:NSMakeRange(6, 2)]);
        } else {
            *a = 255;
        }
    }
    return YES;
}

@implementation UIColor (Extension)

- (UIImage *)color2Image
{
    return [self color2ImageSized:CGSizeMake(1.0f, 1.0f)];
}
- (UIImage *)color2ImageSized:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)color2CircleImage:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [self CGColor]);
    CGContextFillEllipseInRect(ctx, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)tm_transitionColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor andCoe:(double)coe {
    // 获取开始位置颜色的 R、G、B、A值
    CGFloat startR, startG, startB, startA;
    if (![startColor getRed:&startR green: &startG blue:&startB alpha:&startA]) {
        return nil;
    }
    // 获取结束位置颜色的 R、G、B、A值
    CGFloat endR, endG, endB, endA;
    if (![endColor getRed:&endR green: &endG blue:&endB alpha:&endA]) {
        return nil;
    }
    return [self tm_transitionColorWithStartValue:TM_ColorValueMake(startR * 255, startG * 255, startB * 255, startA * 255)
                                      endValue:TM_ColorValueMake(endR * 255, endG * 255, endB * 255, endA * 255)
                                        andCoe:coe];
}

+ (instancetype)tm_transitionColorWithStartHex:(NSString *)startHex endHex:(NSString *)endColorHex andCoe:(double)coe {
    // 获取开始位置颜色的 R、G、B、A值
    NSInteger startR, startG, startB, startA;
    if (!TM_HexStrToRGBA(startHex, &startR, &startG, &startB, &startA)) {
        return nil;
    }
    // 获取结束位置颜色的 R、G、B、A值
    NSInteger endR, endG, endB, endA;
    if (!TM_HexStrToRGBA(endColorHex, &endR, &endG, &endB, &endA)) {
        return nil;
    }
    return [self tm_transitionColorWithStartValue:TM_ColorValueMake(startR, startG, startB, startA)
                                      endValue:TM_ColorValueMake(endR, endG, endB, endA)
                                        andCoe:coe];
}

+ (instancetype)tm_transitionColorWithStartValue:(TM_ColorValue)startValue endValue:(TM_ColorValue)endValue andCoe:(double)coe {
    // 开始颜色与结束的色值差
    NSInteger R_D_value = endValue.r - startValue.r;
    NSInteger G_D_value = endValue.g - startValue.g;
    NSInteger B_D_value = endValue.b - startValue.b;
    NSInteger A_D_value = endValue.a - startValue.a;
    // (开始值 + 差值*coe)/255.0 = 最终色值
    CGFloat R = (startValue.r + (R_D_value * coe))/255.0;
    CGFloat G = (startValue.g + (G_D_value * coe))/255.0;
    CGFloat B = (startValue.b + (B_D_value * coe))/255.0;
    CGFloat A = (startValue.a + (A_D_value * coe))/255.0;
    return [UIColor colorWithRed:R green:G blue:B alpha:A];
}


@end
