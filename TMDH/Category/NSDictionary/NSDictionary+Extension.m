//
//  NSDictionary+Extension.m
//  TMDH
//
//  Created by apple on 2021/7/26.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [NSString stringWithFormat:@"%@", [self objectForKey:key]];
}

- (NSString *)safeStringForKey:(NSString *)key
{
    return [self getStringValueForKey:key defaultValue:@""];
}


- (NSArray *)safeArrayForKey:(NSString *)key
{
    if (key == nil || [key isEqualToString:@""]) {
    }
    id data = [self objectForKey:key];
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    } else {
        return @[];
    }
}

- (NSDictionary *)safeDictionaryForKey:(NSString *)key
{
    id data = [self objectForKey:key];
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    } else {
        return @{};
    }
}

@end
