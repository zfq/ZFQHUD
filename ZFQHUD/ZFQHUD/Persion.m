//
//  Persion.m
//  ZFQHUD
//
//  Created by _ on 16/7/4.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "Persion.h"

@implementation Persion
@synthesize MyStr = _MyStr;

- (void)setMyStr:(NSString *)MyStr
{
    @synchronized (self) {
        _MyStr = MyStr;
    }
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (Persion *(^)())study
{
    return ^(){
        NSLog(@"study");
        return self;
    };
}

- (Persion *(^)(NSInteger num))eat
{
    return ^(NSInteger num){
        NSLog(@"eat%zi",num);
        self.total += num;
        return self;
    };
}

@end
