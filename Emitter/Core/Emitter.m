//
//  Emitter.m
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Emitter.h"

#import "Subscriber.h"
#import "Emitter+Private.h"

#pragma mark - Emitter

@interface Emitter ()

@property(nonatomic,copy) NSString *channel;

// 监听者数组
@property(nonatomic,strong) NSMutableArray<Subscriber *> *subscribers;

@end

@implementation Emitter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.subscribers = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)shared {
    static Emitter *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [Emitter emitterWithChannel:@"shared"];
    });
    return _shared;
}

+ (instancetype)emitterWithChannel:(NSString *)channel {
    Emitter *emitter = [[Emitter alloc] init];
    emitter.channel = channel;
    return emitter;
}

- (void)on:(NSString *)eventName subscriber:(id)subscriber block:(void (^)(id))block {
    [self on:eventName subscriber:subscriber queue:nil block:block];
}

- (void)on:(NSString *)eventName subscriber:(id)subscriber queue:(dispatch_queue_t)queue block:(void (^)(id _Nonnull))block {
    NSParameterAssert(eventName.length > 0 && subscriber);
    
    __weak Emitter *weakSelf = self;
    [self async:^{
        Emitter *strongSelf = weakSelf;
        if (strongSelf) {} else {
            return;
        }
        
        Subscriber *item = [[Subscriber alloc] init];
        
        item.eventName = eventName;
        item.subscriber = subscriber;
        item.queue = queue;
        item.block = block;
        
        [strongSelf.subscribers addObject:item];
    }];
}

- (void)emit:(NSString *)eventName object:(nullable id)object {
    [self traversal:^(Subscriber * _Nonnull item) {
        if (item && item.block) {
            dispatch_async(item.queue, ^{
                item.block(object);
            });
        }
    }];
}

@end

#pragma mark - Emitter+Private

@interface Emitter (Private)

@property(nonatomic, copy, class,readonly) dispatch_queue_t emitterQueue;

@end

@implementation Emitter (Private)

static dispatch_queue_t _emitterQueue;

+ (dispatch_queue_t)emitterQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @synchronized ([NSUserDefaults standardUserDefaults]) {
            if (_emitterQueue == nil) {
                _emitterQueue = dispatch_queue_create("com.tangbl93.Emitter", DISPATCH_QUEUE_SERIAL);
            }
        }
    });
    return _emitterQueue;
}

- (void)async:(void (^)(void))block {
    dispatch_async(Emitter.emitterQueue, ^{
        if (block) block();
    });
}

- (void)traversal:(void (^)(Subscriber *item))block {
    dispatch_async(Emitter.emitterQueue, ^{
        NSArray *subscribers = [self.subscribers copy];
        for (Subscriber *item in subscribers) {
            
            if (item.subscriber == nil) {
                [self.subscribers removeObject:item];
                continue;
            }
            
            block(item);
        }
    });
}

@end


#pragma mark - Emitter+RM

@implementation Emitter (RM)

/// 移除指定事件的监听
/// @param eventName 事件名
- (void)removeAll:(NSString *)eventName {
    NSParameterAssert(eventName.length > 0);
    
    if (eventName.length <= 0) {
        return;
    }
    
    __weak Emitter *weakSelf = self;
    [self traversal:^(Subscriber * _Nonnull item) {
        Emitter *strongSelf = weakSelf;
        if (strongSelf) {} else {
            return;
        }
        
        if ([item.eventName isEqualToString:eventName]) {
            [strongSelf.subscribers removeObject:item];
        }
    }];
}

/// 移除指定监听者的监听
/// @param subscriber 监听者
- (void)removeSubscriber:(id)subscriber {
    NSParameterAssert(subscriber);
    
    if (subscriber == nil) {
        return;
    }
    
    __weak Emitter *weakSelf = self;
    [self traversal:^(Subscriber * _Nonnull item) {
        Emitter *strongSelf = weakSelf;
        if (strongSelf) {} else {
            return;
        }
        
        if ([item.subscriber isEqual:subscriber]) {
            [strongSelf.subscribers removeObject:item];
        }
    }];
}

/// 移除指定监听者上指定事件的监听
/// @param eventName 事件名
/// @param subscriber 监听者
- (void)remove:(NSString *)eventName subscriber:(id)subscriber {
    NSParameterAssert(subscriber && eventName.length > 0);
    
    if (subscriber == nil || eventName.length <= 0) {
        return;
    }
    
    __weak Emitter *weakSelf = self;
    [self traversal:^(Subscriber * _Nonnull item) {
        Emitter *strongSelf = weakSelf;
        if (strongSelf) {} else {
            return;
        }
        
        if ([item.subscriber isEqual:subscriber] && [item.eventName isEqualToString:eventName]) {
            [strongSelf.subscribers removeObject:item];
        }
    }];
}

@end
