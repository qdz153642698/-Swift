//
//  UIButton+Blocks.m
//  HahaManager
//
//  Created by fanpyi on 13-10-31.
//  Copyright (c) 2013年 Edit1. All rights reserved.
//

#import "UIButton+Blocks.h"
#import <objc/runtime.h>
@implementation UIButton (Blocks)
static char key;
-(void)handleWithBlock:(ActionBlock)action{
    objc_setAssociatedObject(self, &key, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)callActionBlock:(id)sender{
    ActionBlock block=(ActionBlock)objc_getAssociatedObject(self, &key);
    if (block) {
        block();
    }
}
@end
