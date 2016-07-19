//
//  NXBPopupView.m
//  ZFQHUD
//
//  Created by _ on 16/3/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "NXBPopupView.h"
#import "NXBPopupWindow.h"

@implementation NXBPopupView

- (void)show
{
    NXBPopupWindow *window = [NXBPopupWindow sharedWindow];
    //1.显示window
    [window makeKeyAndVisible];
    
    if (self.showAnimation) {
        self.showAnimation(self);
    }
    
    //2.将self添加到window对应的rooterViewController的view上
    UIView *attachView = [window attachView];
    [attachView addSubview:self];
    
    [window attachView].backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
}

- (void)hide
{
    [self removeFromSuperview];
    [NXBPopupWindow sharedWindow].hidden = YES;
    [[[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
}

- (void)dealloc
{
    NSLog(@"释放popupView");
}
@end
