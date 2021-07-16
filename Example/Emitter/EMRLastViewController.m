//
//  EMRLastViewController.m
//  Emitter_Example
//
//  Created by tangbl93 on 2021/7/16.
//  Copyright © 2021 tangbl93. All rights reserved.
//

#import "EMRLastViewController.h"

#import <Emitter/Emitter.h>
#import <Emitter/Emitter+RM.h>

@interface EMRLastViewController ()

@end

@implementation EMRLastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Emitter shared] on:@"lazy" subscriber:self block:^(id  _Nonnull object) {
        NSLog(@"lazy at %s, object=%@",__FUNCTION__, object);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[Emitter shared] emit:@"lazy" object:self];
}

@end
