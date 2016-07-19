//
//  NXBPopupWindow.m
//  ZFQHUD
//
//  Created by _ on 16/3/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "NXBPopupWindow.h"
#import "NXBPopupView.h"

@interface NXBPopupWindow()<UIGestureRecognizerDelegate>

@end

@implementation NXBPopupWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.windowLevel = UIWindowLevelStatusBar+1;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        gesture.cancelsTouchesInView = NO;
        gesture.delegate = self;
        [self addGestureRecognizer:gesture];
        self.touchWildToHide = YES;
    }
    return self;
}

+ (NXBPopupWindow *)sharedWindow
{
    static NXBPopupWindow *window;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        window = [[NXBPopupWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.rootViewController = [UIViewController new];
    });
    
    return window;
}


- (void)actionTap:(UITapGestureRecognizer*)gesture
{
    if ( self.touchWildToHide )
    {
        for ( UIView *v in [self attachView].subviews )
        {
            if ( [v isKindOfClass:[NXBPopupView class]] )
            {
                NXBPopupView *pv = (NXBPopupView *)v;
                [pv hide];
                pv = nil;
            }
        }
    }
}

- (UIView *)attachView
{
    return self.rootViewController.view;
}

@end
