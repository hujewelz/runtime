//
//  Person.h
//  Runtime
//
//  Created by mac on 16/4/9.
//  Copyright (c) 2016年 hujewelz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)dictFromModel;

@end
