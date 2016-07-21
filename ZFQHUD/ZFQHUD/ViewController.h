//
//  ViewController.h
//  ZFQHUD
//
//  Created by _ on 16/2/28.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)showOnlyMsg:(UIButton *)sender;
- (IBAction)showOnlyWaiting:(UIButton *)sender;
- (IBAction)showWaitingAndShortMsg:(UIButton *)sender;
- (IBAction)showWaitingAndNormalMsg:(UIButton *)sender;
- (IBAction)showWaitingAndLongMsg:(UIButton *)sender;
- (IBAction)showOnlyLongMsg:(UIButton *)sender;

@end

