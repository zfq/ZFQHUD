//
//  ViewController.m
//  ZFQHUD
//
//  Created by _ on 16/2/28.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "ViewController.h"
#import "ZFQHUD.h"

@interface ViewController ()
{
}

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //设置hud
    [ZFQHUD setHUDMaskType:ZFQHUDAlertViewBlur];
    [ZFQHUD setTapClearDismiss:YES];
    ZFQHUDConfig *config = [ZFQHUDConfig globalConfig];
    config.alertViewTintColor = [UIColor orangeColor];
    config.alertViewBcgColor = [UIColor grayColor];
    config.alertViewMinWidth = 100;
}

- (IBAction)showOnlyMsg:(UIButton *)sender
{
    [[ZFQHUD sharedView] showWithMsg:@"这是提示语😁"];
}

- (IBAction)showOnlyWaiting:(UIButton *)sender
{
    [[ZFQHUD sharedView] showWithType:ZFQHUDTypeActivity msg:nil duration:0 completionBlk:nil];
}

- (IBAction)showWaitingAndShortMsg:(UIButton *)sender
{
    [[ZFQHUD sharedView] showWithType:ZFQHUDTypeActivity msg:@"简单" duration:0 completionBlk:^{
        NSLog(@"完成 showWaitingAndShortMsg");
    }];
}

- (IBAction)showWaitingAndNormalMsg:(UIButton *)sender
{
    NSString *str = @"这是一行较长的提示语haha hello world";
    [[ZFQHUD sharedView] showWithType:ZFQHUDTypeActivity msg:str duration:0 completionBlk:^{
        NSLog(@"完成 showWaitingAndNormalMsg");
    }];
}

- (IBAction)showWaitingAndLongMsg:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sss" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [[ZFQHUD sharedView] showWithType:ZFQHUDTypeActivity msg:str duration:0 completionBlk:^{
        NSLog(@"完成 showWaitingAndLongMsg");
    }];
}

- (IBAction)showOnlyLongMsg:(UIButton *)sender
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sss" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    [[ZFQHUD sharedView] showWithType:ZFQHUDTypeAlert msg:str duration:0 completionBlk:^{
        NSLog(@"完成 showOnlyLongMsg");
    }];
}
@end
