//
//  TMCommonlyMethods.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "TMCommonlyMethods.h"

static CGRect oldframe;
@implementation TMCommonlyMethods

+ (void)userDefaultsKey:(NSString *)key Obj:(id)obj
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
}

+ (id)loadUserDefaultsObjKey:(NSString *)key
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

/** 计算Label文字长度*/
+ (CGSize)calculateLengthOfText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = [text sizeWithAttributes:attrs];
    
    return size;
}

/** 获取当前时间*/
+ (NSString *)getCurrentTime:(NSInteger)type
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (type) {
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else {
        
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

/** 通过当前视图获取父视图的控制器*/
+ (UIViewController *)getSuperViewController:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/** 类型识别:将所有的NSNull类型转化成@""*/
+ (id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]]) {
        
        return [self nullDic:myObj];
    }
    else if ([myObj isKindOfClass:[NSArray class]]) {
        
        return [self nullArr:myObj];
    }
    else if ([myObj isKindOfClass:[NSString class]]) {
        
        return [self stringToString:myObj];
    }
    else if ([myObj isKindOfClass:[NSNull class]]) {
        
        return [self nullToString];
    }
    return myObj;
}

//将NSDictionary中的Null类型的项目转化成@""
+ (NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray * keyArr = [myDic allKeys];
    NSMutableDictionary * resDic = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < keyArr.count; i ++) {
        
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}
 
//将NSDictionary中的Null类型的项目转化成@""
+ (NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray * resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++) {
        
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+ (NSString *)stringToString:(NSString *)string
{
    return string;
}
 
//将Null类型的项目转化成@""
+ (NSString *)nullToString
{
    return @"";
}

/** 判断字符串是否为空*/
+ (BOOL)isEmPty:(NSString *)string
{
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        
        return YES;
    }else {
        
        return NO;
    }
}

/** 根据正则，过滤特殊字符*/
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr
{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}

/** 设置颜色文本*/
+ (NSAttributedString *)setRichText:(NSString *)string beginLocation:(NSUInteger)begin endLocation:(NSInteger)end color:(UIColor *)color
{
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange(begin,end);
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:redRange];
    
    return noteStr;
}

/** 设置渐变色*/
+ (void)addTransitionColor:(UIColor *)startColor startPoint:(CGPoint)startPoint endColor:(UIColor *)endColor endPoint:(CGPoint)endPoint view:(UIView *)view
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0, @1];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = view.bounds;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

/** UIView圆角 上下左右*/
+ (void)makeRoundedCorners:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius
{
    if (tl || tr || bl || br) {
        
        UIRectCorner corner = 0;//holds the corner
        //Determine which corner(s) should be changed
        if (tl) {
            corner = corner | UIRectCornerTopLeft;
        }
        if (tr) {
            corner = corner | UIRectCornerTopRight;
        }
        if (bl) {
            corner = corner | UIRectCornerBottomLeft;
        }
        if (br) {
            corner = corner | UIRectCornerBottomRight;
        }
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        
    }
}

/** view转成image*/
+ (UIImage *)convertViewToImage:(UIView *)view
{
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

/** 与当前时间差*/
+ (NSString *)pleaseInsertStarTimeo:(NSString *)time
{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time];
    NSDate *date2 = [formatter dateFromString:[TMCommonlyMethods getCurrentTime:0]];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    // 4.输出结果
    NSLog(@"---------%ld",(long)cmps.year);
    if (cmps.year >0) {
        
        return [NSString stringWithFormat:@"%ld年前",(long)cmps.year];
    }
    
    if (cmps.month >0) {
        
        return [NSString stringWithFormat:@"%ld月前",(long)cmps.month];
    }
    
    if (cmps.day >0) {
        
        return [NSString stringWithFormat:@"%ld天前",(long)cmps.day];
    }
    
    if (cmps.hour >0) {
        
        return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
    }
    
    if (cmps.minute >0) {
        
        return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
    }
    
    return @"刚刚";
}

/**
 校验身份证号码是否正确 返回BOOL值

 @param idCardString 身份证号码
 @return 返回BOOL值 YES or NO
 */
+ (BOOL)verifyIDCardString:(NSString *)idCardString
{
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
         //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL)isValidateMobile:(NSString *)cellNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-25-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[356]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:cellNum] == YES)
       || ([regextestcm evaluateWithObject:cellNum] == YES)
       || ([regextestct evaluateWithObject:cellNum] == YES)
       || ([regextestcu evaluateWithObject:cellNum] == YES)){
        return YES;
    }else{
        return NO;
    }
}

/** 是否有非法字符*/
+ (BOOL)isContainsEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange,BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    
                    isEomji = YES;
                }
            }
        } else if (substring.length > 1) {
            
            const unichar ls = [substring characterAtIndex:1];
            
            if (ls == 0x20e3) {
                
                isEomji = YES;
            }
        } else {
            
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030|| hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs ==0x231a ) {
                
                isEomji = YES;
            }
        }
    }];
    return isEomji;
}

/** 获取两个字符之间的字符串*/
+ (NSString *)getString:(NSString *)string OneChat:(NSString *)chat_1 TwoChat:(NSString *)chat_2
{    
    NSString *result;
    NSRange startRange = [string rangeOfString:chat_1];
    if ([TMCommonlyMethods isEmPty:chat_2]) { // 如果没有第二个字符，则获取到最后
        
        NSRange range = NSMakeRange(startRange.location + startRange.length, string.length - (startRange.location + startRange.length) );
        result = [string substringWithRange:range];
        
    } else {
        
        NSRange endRange = [string rangeOfString:chat_2];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        result = [string substringWithRange:range];
    }
    
    return result;
}

/** 查看大图*/
+ (void)lookBigImage:(UIImageView *)avatarImageView
{
    UIImage *image = avatarImageView.image;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];

    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];

    [UIView animateWithDuration:0.25 animations:^{
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) / 2, [UIScreen mainScreen].bounds.size.width, image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width);
        backgroundView.alpha = 1;

    } completion:^(BOOL finished) {

    }];
}

// 点击 隐藏
+ (void)hideImage:(UITapGestureRecognizer *)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

/** 添加阴影*/
+ (void)addShadowToLayer:(CALayer *)theLayer withColor:(UIColor *)theColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius
{
    // 阴影颜色
    theLayer.shadowColor = RGBColor(136, 136, 136).CGColor;
    theLayer.backgroundColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theLayer.shadowOffset = shadowOffset;
    // 阴影透明度，默认0
    theLayer.shadowOpacity = shadowOpacity;
    theLayer.cornerRadius = cornerRadius;
    // 阴影半径，默认3
    theLayer.shadowRadius = shadowRadius;
}

/** 返回该年月包含的天数*/
+ (NSArray *)getDayForYear:(NSInteger)year Month:(NSInteger)month
{
    
    NSMutableArray *array = [NSMutableArray array];
    int dayNum = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        
        dayNum = 31;
    }else if (month == 2) {
        
        NSInteger index = fmod(year, 4);
        if (index == 0) {
            
            dayNum = 29;
        }else {
            
            dayNum = 28;
        }
    }else {
        
        dayNum = 30;
    }
    
    for (int i = 1; i < dayNum +1; i ++) {
        
        [array addObject:@(i)];
    }
    
    return [NSArray arrayWithArray:array];
}

/** 模拟系统动画*/
+ (void)animationAlert:(UIView *)view
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]
                            ];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

@end
