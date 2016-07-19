//
//  NXBPopupWindow.h
//  ZFQHUD
//
//  Created by _ on 16/3/29.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NXBPopupWindow : UIWindow

@property (nonatomic, assign) BOOL touchWildToHide; // default is NO. When YES, popup views will be hidden when user touch the translucent background.

+ (NXBPopupWindow *)sharedWindow;

- (UIView *)attachView;

@end
