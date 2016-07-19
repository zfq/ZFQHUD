//
//  Persion.h
//  ZFQHUD
//
//  Created by _ on 16/7/4.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Persion : NSObject

@property (nonatomic,assign) NSInteger total;

@property (nonatomic,copy) NSString *MyStr;

@property (nonatomic,assign) NSString *tt;

- (Persion *(^)())study;

- (Persion *(^)(NSInteger num))eat;

@end
