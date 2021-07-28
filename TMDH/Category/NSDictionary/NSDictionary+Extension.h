//
//  NSDictionary+Extension.h
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Extension)

/**
 调用getStringValueForKey获取，默认值为@""
 
 @param key key
 @return 获取成功返回成功值，失败就返回@""
 */
- (NSString *)safeStringForKey:(NSString *)key;

/**
 获取array，默认值为@[]
 
 @param key key
 @return 获取成功返回成功值，失败就返回@[]
 */
- (NSArray *)safeArrayForKey:(NSString *)key;


/**
 在dic中获取bool
 
 @param key key
 @return 获取成功返回成功值，失败就返回默认值
 */
- (NSDictionary *)safeDictionaryForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
