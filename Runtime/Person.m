//
//  Person.m
//  Runtime
//
//  Created by mac on 16/4/9.
//  Copyright (c) 2016年 hujewelz. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Person

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        for (NSString *key in dict.allKeys) {
            id value = dict[key];
            SEL setter = [self propertyForSetterByKey:key];
            if (setter) {
                ((void (*)(id, SEL, id))objc_msgSend)(self,setter,value);
            }
        }
    }
    return self;
}

- (NSDictionary *)dictFromModel {
    unsigned int cout = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &cout);
    
    if (cout != 0) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (NSUInteger i=0; i<cout; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL getter = [self propertyForGetterByKey:name];
            if (getter) {
                id value = ((id (*)(id, SEL))objc_msgSend)(self, getter);
                if (value) {
                    dict[name] = value;
                }
                else {
                    dict[name] = @"";
                }
            }
        }
        free(properties);
        return dict;
    }
    
    free(properties);
    return nil;
}

- (SEL)propertyForSetterByKey:(NSString *)key {
    NSString *setterName = [NSString stringWithFormat:@"set%@:", key.capitalizedString];
    SEL setter = NSSelectorFromString(setterName);
    if (setter) {
        return setter;
    }
    return nil;
}

- (SEL)propertyForGetterByKey:(NSString *)key {
    SEL getter = NSSelectorFromString(key);
    if (getter) {
        return getter;
    }
    return nil;
}

@end
