//
//  Subscriber.m
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Subscriber.h"

@implementation Subscriber

- (dispatch_queue_t)queue {
    return _queue ?: dispatch_get_main_queue();
}

@end
