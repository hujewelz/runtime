//
//  NSObject+methodswizzling.m
//  MethodSwizzling
//
//  Created by mac on 16/4/8.
//  Copyright (c) 2016年 hujewelz. All rights reserved.
//

#import "NSObject+methodswizzling.h"
#import <objc/runtime.h>

@implementation NSObject (methodswizzling)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    //若原来的方法不存在，则添加
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
