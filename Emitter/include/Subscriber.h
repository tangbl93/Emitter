//
//  Subscriber.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Subscriber : NSObject

@property(nonatomic,weak) id subscriber;            // 订阅者
@property(nonatomic,copy) NSString *eventName;      // 事件名
@property(nonatomic,copy) dispatch_queue_t queue;   // 事件触发队列
@property(nonatomic,copy) void (^block)(id object); // 事件回调

@end

NS_ASSUME_NONNULL_END
