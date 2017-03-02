//
//  main.m
//  Runtime
//
//  Created by mac on 16/4/9.
//  Copyright (c) 2016年 hujewelz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSDictionary *dict = @{@"name":@"hu", @"age":@12};
        Person *p = [[Person alloc] initWithDict:dict];
        
        NSDictionary *d = [p dictFromModel];
        NSLog(@"d: %@",d);
      
      Class meta_class = objc_getMetaClass(class_getName(p.class));
      NSLog(@"meta class: %@", meta_class);
      NSLog(@"=====================================");
      
      unsigned int count;
      objc_property_t *pro_l = class_copyPropertyList(p.class, &count);
      for (unsigned int i=0; i<count; i++) {
        NSLog(@"property: %s", pro_l[i]);
        NSLog(@"property name: %s", property_getName(pro_l[i]));
      }
      free(pro_l);
      NSLog(@"=====================================");
      //count = 0;
      Ivar *ivars = class_copyIvarList(p.class, &count);
      for (unsigned int i=0; i<count; i++) {
        NSLog(@"instance var: %s", ivar_getName(ivars[i]));
      }
      free(ivars);
      
      NSLog(@"=====================================");
      Method *methods = class_copyMethodList(p.class, &count);
      for (unsigned int i=0; i<count; i++) {
        NSLog(@"methods: %s", method_getName(methods[i]));
        
      }
      free(methods);
      

    }
    return 0;
}

void createClass(char *className) {
  Class cls = objc_allocateClassPair([NSObject class], className, 0);
  //class_addMethod(cls, @selector(method1), (IMP)imp_method1, "v@:")

  objc_registerClassPair(cls);
}


