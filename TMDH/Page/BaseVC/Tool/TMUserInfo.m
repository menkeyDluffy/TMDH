//
//  TMUserInfo.m
//  TMDH
//
//  Created by apple on 2021/7/27.
//

#import "TMUserInfo.h"

@implementation TMUserInfo

+ (instancetype)sharedInstance
{
    static dispatch_once_t one;
    static TMUserInfo *userInfo;
    dispatch_once(&one, ^{
        
        userInfo = [[TMUserInfo alloc] init];
        [userInfo initialze];
    });
    
    return userInfo;
}

- (void)initialze
{
    
}

@end
