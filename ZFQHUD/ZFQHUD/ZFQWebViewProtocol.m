//
//  ZFQWebViewProtocol.m
//  ZFQHUD
//
//  Created by _ on 16/7/7.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "ZFQWebViewProtocol.h"

@implementation ZFQWebViewProtocol

//以下的5个方法是子类必须实现的

//表示这个子类能否处理request请求
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    return YES;
}

//返回规范形式的请求
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading
{
    
}

- (void)stopLoading
{
    
}

@end
