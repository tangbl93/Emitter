//
//  Emitter+RM.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Emitter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Emitter (RM)

/// 移除指定事件的监听
/// @param eventName 事件名
- (void)removeAll:(NSString *)eventName;

/// 移除指定监听者的监听
/// @param subscriber 监听者
- (void)removeSubscriber:(id)subscriber;

/// 移除指定监听者上指定事件的监听
/// @param eventName 事件名
/// @param subscriber 监听者
- (void)remove:(NSString *)eventName subscriber:(id)subscriber;

@end

NS_ASSUME_NONNULL_END
