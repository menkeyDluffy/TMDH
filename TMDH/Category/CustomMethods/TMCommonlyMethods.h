//
//  TMCommonlyMethods.h
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMCommonlyMethods : NSObject

/**使用 UserDefaults 存储*/
+ (void)userDefaultsKey:(NSString *)key Obj:(id)obj;
/**读取 UserDefaults 值*/
+ (id)loadUserDefaultsObjKey:(NSString *)key;

/** 计算字体长度*/
+ (CGSize)calculateLengthOfText:(NSString *)text font:(UIFont *)font;

/**
 * 获取当前时间
 * 0 ：精确到秒
 * 1 ：精确到日
 */
+ (NSString *)getCurrentTime:(NSInteger)type;

/** 通过当前视图获取父视图的控制器*/
+ (UIViewController *)getSuperViewController:(UIView *)view;

/** 类型识别:将所有的NSNull类型转化成@""*/
+ (id)changeType:(id)myObj;

/** 判断字符串是否为空*/
+ (BOOL)isEmPty:(NSString *)string;

/** 根据正则，过滤特殊字符*/
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr;

/** 设置颜色文本*/
+ (NSAttributedString *)setRichText:(NSString *)string beginLocation:(NSUInteger)begin endLocation:(NSInteger)end color:(UIColor *)color;

/** 设置渐变色*/
+ (void)addTransitionColor:(UIColor *)startColor startPoint:(CGPoint)startPoint endColor:(UIColor *)endColor endPoint:(CGPoint)endPoint view:(UIView *)view;

/** UIView圆角 上下左右*/
+ (void)makeRoundedCorners:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius;

/** view转成image*/
+ (UIImage *)convertViewToImage:(UIView *)view;

/** 与当前时间差(朋友圈)*/
+ (NSString *)pleaseInsertStarTimeo:(NSString *)time;

/**
 校验身份证号码是否正确 返回BOOL值

 @param idCardString 身份证号码
 @return 返回BOOL值 YES or NO
 */
+ (BOOL)verifyIDCardString:(NSString *)idCardString;

/** 手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)cellNum;

/** 是否有非法字符*/
+ (BOOL)isContainsEmoji:(NSString *)string;

/** 获取两个字符之间的字符串*/
+ (NSString *)getString:(NSString *)string OneChat:(NSString *)chat_1 TwoChat:(NSString *)chat_2;

/** 查看大图*/
+ (void)lookBigImage:(UIImageView *)avatarImageView;

/** 加阴影*/
+ (void)addShadowToLayer:(CALayer *)theLayer withColor:(UIColor *)theColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius;

/** 返回该年月包含的天数*/
+ (NSArray *)getDayForYear:(NSInteger)year Month:(NSInteger)month;

/** 模拟系统动画*/
+ (void)animationAlert:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
