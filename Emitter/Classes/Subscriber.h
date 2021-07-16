//
//  Subscriber.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Subscriber : NSObject

@property(nonatomic,weak) id subscriber;            // 订阅者/subscriber
@property(nonatomic,copy) NSString *eventName;      // 事件名/event
@property(nonatomic,copy) void (^block)(id object); // 事件回调/callback

- (instancetype)initWithSubscriber:(id)subscriber eventName:(NSString *)eventName block:(void (^)(id object))block;

@end

NS_ASSUME_NONNULL_END
