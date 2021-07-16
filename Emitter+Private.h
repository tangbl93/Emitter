//
//  Emitter+Private.h
//  Emitter
//
//  Created by tangbl93 on 2021/7/16.
//

#import "Emitter.h"

NS_ASSUME_NONNULL_BEGIN

@interface Emitter (Private)

- (void)async:(void (^)(void))block;

- (void)traversal:(void (^)(Subscriber *item))block;

@end

NS_ASSUME_NONNULL_END
