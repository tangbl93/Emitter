//
//  Emitter+Private.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Emitter.h"

NS_ASSUME_NONNULL_BEGIN
@class Subscriber;
@interface Emitter (Private)

/// 在队列中异步执行
- (void)async:(void (^)(void))block;

/// 遍历监听者数组，移除其中不活跃的
- (void)traversal:(void (^)(Subscriber *item))block;

@end

NS_ASSUME_NONNULL_END
