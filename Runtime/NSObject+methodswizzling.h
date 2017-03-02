//
//  NSObject+methodswizzling.h
//  MethodSwizzling
//
//  Created by mac on 16/4/8.
//  Copyright (c) 2016年 hujewelz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (methodswizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;

@end
