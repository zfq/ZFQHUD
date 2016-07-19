//
//  ZFQTimerProxy.m
//  ZFQHUD
//
//  Created by _ on 16/7/15.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "ZFQTimerProxy.h"

@implementation ZFQTimerProxy

+ (ZFQTimerProxy *)testWithTarget:(id)target
{
    ZFQTimerProxy *timerProxy = [[ZFQTimerProxy alloc] initWithTimerTarget:target];
    return timerProxy;
}

- (instancetype)initWithTimerTarget:(id)target
{
    _timerTarget = target;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:_timerTarget];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    /**
     下面的这一行代码可以避免崩溃，但仍旧需要在VC的dealloc时暂停定时器。比如NSTimer释放时，但定时器没有停止，仍旧在尝试执行代码
     return [NSObject instanceMethodSignatureForSelector:@selector(init)];
     
     下面这行代码不能避免崩溃，但一旦崩溃 就说明计时器没有暂停！！
     */
    return [[self.timerTarget class] instanceMethodSignatureForSelector:sel];
}

- (void)dealloc
{
    NSLog(@"释放代理对象");
}
@end
