//
//  ZFQDuckType.h
//  ZFQHUD
//
//  Created by _ on 16/7/14.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DuckEntity : NSProxy
- (instancetype)initWithJSONString:(NSString *)json;
@end


@protocol UserEntity <NSObject>

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, assign) NSInteger *age;

@end

@protocol StudentEntity <UserEntity>

@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *teacher;

@end
