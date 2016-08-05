//
//  LSNotificationCenter.h
//  LSNOtificationCenterTest
//
//  Created by 李山 on 16/8/4.
//  Copyright © 2016年 李山. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNotification.h"

@interface LSNotificationCenter : NSObject

/**
 *  注册通知
 *
 *  @param target   通知对象
 *  @param newsName 通知消息
 *  @param selector 处理方法
 */
+ (void) notificationCenterAddObserver:(id)target NewsName:(NSString *)newsName Selector:(SEL)selector;

/**
 *  发送通知
 *
 *  @param newsDict 通知的内容
 *  @param newsName 通知的名字
 */
+ (void) postNews:(NSDictionary *)newsDict NewsName:(NSString *)newsName;

/**
 *  移除观察者
 *
 *  @param target 观察者
 */
+ (void) removeObserver:(id)target;

@end
