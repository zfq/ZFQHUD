//
//  NXBPopupView.h
//  ZFQHUD
//
//  Created by _ on 16/3/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NXBPopupView;
typedef void(^NXBPopupBlock)(NXBPopupView *);
typedef void(^NXBPopupLayoutBlock)()
@interface NXBPopupView : UIView

@property (nonatomic, copy) NXBPopupBlock   showAnimation;       // custom show animation block.
@property (nonatomic, copy) NXBPopupBlock   hideAnimation;       // custom hide animation block.

- (void)show;

- (void)hide;

@end
