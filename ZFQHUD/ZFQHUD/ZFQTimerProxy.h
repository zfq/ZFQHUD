//
//  ZFQTimerProxy.h
//  ZFQHUD
//
//  Created by _ on 16/7/15.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFQTimerProxy : NSProxy

@property (nonatomic,weak,readonly) id timerTarget;

+ (ZFQTimerProxy *)testWithTarget:(id)target;

@end
