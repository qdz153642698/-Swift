//
//  UIButton+Blocks.h
//  HahaManager
//
//  Created by fanpyi on 13-10-31.
//  Copyright (c) 2013年 Edit1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)();
@interface UIButton (Blocks)
-(void)handleWithBlock:(ActionBlock)action;
@end
