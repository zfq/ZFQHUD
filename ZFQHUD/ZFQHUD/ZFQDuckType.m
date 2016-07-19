//
//  ZFQDuckType.m
//  ZFQHUD
//
//  Created by _ on 16/7/14.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "ZFQDuckType.h"
#import <objc/runtime.h>

@interface DuckEntity()
@property (nonatomic,strong,nullable) NSMutableDictionary *innerDictionary;

@end

@implementation DuckEntity

- (instancetype)initWithJSONString:(NSString *)json
{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        self.innerDictionary = [jsonObject mutableCopy];
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    SEL changedSelector = sel;
    
    if ([self propertyNameScanFromGetterSelector:sel]) {
        changedSelector = @selector(objectForKey:);
    } else if ([self propertyNameScanFromSetterSelector:sel]) {
        changedSelector = @selector(setObject:forKey:);
    }
    return [[self.innerDictionary class] instanceMethodSignatureForSelector:changedSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation setTarget:self.innerDictionary];
    
    NSString *setter = [self propertyNameScanFromSetterSelector:invocation.selector];
    if (setter != nil) {
        invocation.selector = @selector(setObject:forKey:);
        
        //会发现anArray就是setObject:forKey:中的第一个参数，而且已经默认传入进去了
        NSArray *anArray;
        [invocation getArgument:&anArray atIndex:2];
        [invocation setArgument:&setter atIndex:3];    //self _cmd object key
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    } else {
        NSString *getter = [self propertyNameScanFromGetterSelector:invocation.selector];
        if (getter != nil) {
            invocation.selector = @selector(objectForKey:);
            [invocation setArgument:&getter atIndex:2];    //self _cmd key
            [invocation invokeWithTarget:self.innerDictionary]; //注意invokeWithTarget和invoke这两个方法是一样的，只是多了个参数而已
            return;
        }
    }
    
    [super forwardInvocation:invocation];
}

//从getter方法中获取属性名称
- (NSString *)propertyNameScanFromGetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    //要注意 我们假定selector不一定是getter方法，所以为了靠谱，就只取前面一部分,其实这种方法也不可靠
    if ([selectorName componentsSeparatedByString:@":"].count == 1) {
        return selectorName;
    }
    return nil;
}

- (NSString *)propertyNameScanFromSetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    NSArray *array = [selectorName componentsSeparatedByString:@":"];
    if (array.count == 0) {
        return nil;
    }
    NSString *preStr = array.firstObject;
    if ([preStr hasPrefix:@"set"]) {
        NSString *subStr = [preStr substringFromIndex:3];
        return subStr.lowercaseString;
    } else {
        return nil;
    }
    
}
@end