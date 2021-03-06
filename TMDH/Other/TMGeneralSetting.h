//
//  TMGeneral.h
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#ifndef TMGeneral_h
#define TMGeneral_h

// 屏幕尺寸相关
#define SCREEN_WIDTH              ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT             ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define SCREEN_NAVBAR_HEIGHT (SCREEN_STATUSBAR_HEIGHT + SYSTEM_NAV_BAR_HEIGHT)
#define SYSTEM_NAV_BAR_HEIGHT 44.f
#define isIPhoneX                 (SCREEN_HEIGHT >= 812 ? YES:NO)

#define SCRXFromX(x) ( SCREEN_WIDTH / 375.0f * (x))
#define SCRXFromY(y) (SCREEN_HEIGHT / 667.0 * (y))
#define UIImageName(name) [UIImage imageNamed:name]

#define StatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define NavBarHeight (isIPhoneX ? 88.f : 64.f)
#define TabbarHeight (isIPhoneX ? (49.0 + 34.0):49.0)
#define StatesHeight (isIPhoneX ? 34.f : 20.f)
#define BottomHeight (isIPhoneX ? 34.f : 0.f)
#define WS(weakSelf) __weak __typeof(&*self)weakself = self
#define SS(strongSelf) __strong __typeof(&*self)strongself = self

//弹出键盘高度
#define KeyboardHeight (isIPhoneX ? 331 : 256)
#define NumberKeyboardHeight (isIPhoneX ? 291 : 216)


// RGB颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGBColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/// 字符串颜色
#define HexColor(color) [UIColor colorWithHexString:color]

//字体
#define SystemFont(size) [UIFont systemFontOfSize:(size)]


#endif /* TMGeneral_h */
