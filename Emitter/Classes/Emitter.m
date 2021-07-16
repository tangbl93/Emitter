//
//  Emitter.m
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Emitter.h"
#import "Subscriber.h"

@interface Emitter ()

@property(nonatomic,copy) NSString *channel;

@property(nonatomic,strong) NSMutableArray<Subscriber *> *subscribers;

@end

@implementation Emitter

static dispatch_queue_t _emitterQueue;

- (instancetype)init {
    self = [super init];
    if (self) {
        _subscribers = [NSMutableArray array];
        
        @synchronized ([UIApplication sharedApplication]) {
            if (_emitterQueue == nil) {
                _emitterQueue = dispatch_queue_create("com.tangbl93.Emitter", DISPATCH_QUEUE_SERIAL);
            }
        }
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
    NSParameterAssert(eventName.length > 0 && subscriber);
    
    dispatch_async(_emitterQueue, ^{
        Subscriber *item = [[Subscriber alloc] initWithSubscriber:subscriber eventName:eventName block:block];
        [self.subscribers addObject:item];
    });
}

- (void)emit:(NSString *)eventName object:(nullable id)object {
    [self emit:eventName object:object queue:nil];
}

- (void)emit:(NSString *)eventName object:(nullable id)object queue:(dispatch_queue_t)queue {
    dispatch_queue_t _queue = queue ?: dispatch_get_main_queue();
    
    dispatch_async(_emitterQueue, ^{
        NSArray *subscribers = [self.subscribers copy];
        for (Subscriber *item in subscribers) {
            
            if (item.subscriber == nil) {
                [self.subscribers removeObject:item];
                continue;
            }
            
            if (item.block) {
                dispatch_async(_queue, ^{
                    item.block(object);
                });
            }
        }
    });
}

@end
