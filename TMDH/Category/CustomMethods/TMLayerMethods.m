//
//  TMLayerMethods.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "TMLayerMethods.h"

@implementation TMLayerMethods

/** 创建label*/
+ (UILabel *)getLabelForTitle:(NSString *)title Font:(UIFont *)font TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}

/** 创建button*/
+ (UIButton *)getClipButtonForTitle:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font BackgroundColor:(UIColor *)backgroundColor MasksToBounds:(BOOL)masksToBounds CornerRadius:(CGFloat)cornerRadius
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.backgroundColor = backgroundColor;
    button.layer.masksToBounds = masksToBounds;
    button.layer.cornerRadius = cornerRadius;
    
    return button;
}

@end
