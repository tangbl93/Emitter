//
//  Subscriber.m
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Subscriber.h"

@implementation Subscriber

- (instancetype)initWithSubscriber:(id)subscriber eventName:(NSString *)eventName block:(void (^)(id _Nonnull))block {
    self = [super init];
    if (self) {
        self.subscriber = subscriber;
        self.eventName = eventName;
        self.block = block;
    }
    return self;
}

@end
