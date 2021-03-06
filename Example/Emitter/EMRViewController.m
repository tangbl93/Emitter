//
//  EMRViewController.m
//  Emitter
//
//  Created by tangbl93 on 07/16/2021.
//  Copyright (c) 2021 tangbl93. All rights reserved.
//

#import "EMRViewController.h"

#import <Emitter/Emitter.h>

@interface EMRViewController ()

@end

@implementation EMRViewController

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
