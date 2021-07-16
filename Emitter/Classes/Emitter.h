//
//  Emitter.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Emitter: 事件触发器
@interface Emitter : NSObject

/// 全局的事件触发器
+ (instancetype)shared;

/// 专用的事件触发器
+ (instancetype)emitterWithChannel:(nullable NSString *)channel;

/// 注册事件监听器
/// @param eventName 事件名
/// @param subscriber 监听者
/// @param block 事件触发回调
- (void)on:(NSString *)eventName subscriber:(id)subscriber block:(void (^)(id object))block;

/// 注册事件监听器
/// @param eventName 事件名
/// @param subscriber 监听者
/// @param queue 事件触发队列
/// @param block 事件触发回调
- (void)on:(NSString *)eventName subscriber:(id)subscriber queue:(nullable dispatch_queue_t)queue block:(void (^)(id object))block;

/// 发送事件
/// @param eventName 事件名
/// @param object 事件参数
- (void)emit:(NSString *)eventName object:(nullable id)object;

@end

NS_ASSUME_NONNULL_END
