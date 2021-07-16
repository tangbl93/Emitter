//
//  EMRAppDelegate.m
//  Emitter
//
//  Created by tangbl93 on 07/16/2021.
//  Copyright (c) 2021 tangbl93. All rights reserved.
//

#import "EMRAppDelegate.h"

#import <Emitter/Emitter.h>

@implementation EMRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[Emitter shared] on:@"lazy" subscriber:self block:^(id  _Nonnull object) {
        NSLog(@"lazy at %s, object=%@",__FUNCTION__, object);
    }];
    
    return YES;
}

@end
