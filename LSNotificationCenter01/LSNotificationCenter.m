//
//  LSNotificationCenter.m
//  LSNOtificationCenterTest
//
//  Created by 李山 on 16/8/4.
//  Copyright © 2016年 李山. All rights reserved.
//

#import "LSNotificationCenter.h"
#define UserInfo @"userInfo"

#define UserIDKey @"UserObject"
#define UserSelKey @"UserSelector"
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
static NSMutableDictionary * _newsListDict;

@implementation LSNotificationCenter

+ (void) notificationCenterAddObserver:(id)target NewsName:(NSString *)newsName Selector:(SEL)selector
{
    assert(target);
    assert(newsName);
    assert(selector);
    [self privateCreateNewsName:newsName withObserver:target Sel:selector];
}
+ (void) postNews:(NSDictionary *)newsDict NewsName:(NSString *)newsName
{
    assert(newsDict);
    assert(newsName);
    [self privatePostNews:newsDict NewsName:newsName];
}
+ (void) removeObserver:(id)target
{
    [self privateRemoveObserver:target];
}
#pragma mark - 私有化方法实现
+ (NSMutableDictionary *)getNewsListDict
{
    if (!_newsListDict) {
        _newsListDict = [NSMutableDictionary dictionary];
    }
    return _newsListDict;
}

+ (void) privatePostNews:(NSDictionary *)newsDict NewsName:(NSString *)newsName
{
    NSMutableDictionary *  userInfoDict= [self getNewsListDict];
    NSMutableSet * userSet = [userInfoDict objectForKey:newsName];
   
    for (NSDictionary *  userDict in userSet.allObjects) {
        id object = [userDict objectForKey:UserIDKey];
        NSString * selector = [userDict objectForKey:UserSelKey];
        LSNotification * notification = [[LSNotification alloc] init];
        notification.userInfoDict = newsDict;
        SuppressPerformSelectorLeakWarning(
                                           [object performSelector:NSSelectorFromString(selector)
                                                        withObject:notification];
                                           );
    }
}
+ (void)  privateRemoveObserver:(id)target
{
    for (NSString * key in [self getNewsListDict].allKeys) {
        NSMutableSet * userSet = [[self getNewsListDict] objectForKey:key];
        for (NSDictionary *  userDict in userSet.allObjects) {
            id object = [userDict objectForKey:UserIDKey];
            if ([object isEqual:target]) {
                [userSet removeObject:userDict];
                break;
            }
        }
    }
}
+ (void)  privateCreateNewsName:(NSString *)newNameStr withObserver:(id)target Sel:(SEL)selector
{
    NSMutableDictionary * userInfoDict = [self getNewsListDict];
    NSMutableSet * observerSet = [userInfoDict objectForKey:newNameStr]?[userInfoDict objectForKey:newNameStr]:[NSMutableSet set];
    NSDictionary * dict = @{UserIDKey:target,UserSelKey:NSStringFromSelector(selector)};
    [observerSet addObject:dict];
    [userInfoDict setObject:observerSet forKey:newNameStr];
}

@end
