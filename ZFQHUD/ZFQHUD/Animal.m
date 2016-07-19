//
//  Animal.m
//  ZFQHUD
//
//  Created by _ on 16/6/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)init
{
    NSException *exception = [NSException exceptionWithName:@"aaa" reason:@"You must override" userInfo:nil];
    @throw exception;
}

- (instancetype)__init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)someMethod
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
@end
