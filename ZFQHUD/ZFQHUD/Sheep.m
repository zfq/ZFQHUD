//
//  Sheep.m
//  ZFQHUD
//
//  Created by _ on 16/6/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "Sheep.h"

@implementation Sheep

- (instancetype)init
{
    self = [super __init];
    if (self) {
        NSLog(@"创建sheep");
    }
    return self;
}

//- (NSString *)description
//{
//    return @"This is a sheep";
//}

- (void)dealloc
{
    NSLog(@"释放");
}
@end
