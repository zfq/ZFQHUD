//
//  Test1ViewController.m
//  ZFQHUD
//
//  Created by _ on 16/7/14.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "Test1ViewController.h"
#import "ZFQTimerProxy.h"

@interface Test1ViewController ()
@property (nonatomic,strong) NSTimer *myTimer;
@property (nonatomic,assign) NSInteger num;
@end

@implementation Test1ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZFQTimerProxy *proxy = [ZFQTimerProxy testWithTarget:self];
    _myTimer = [NSTimer timerWithTimeInterval:0.1 target:proxy selector:@selector(fireTime:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_myTimer forMode:NSRunLoopCommonModes];
}

- (void)fireTime:(NSTimer *)timer
{
    self.num++;
    NSLog(@"%zi",self.num);
}

- (void)dealloc
{
    NSLog(@"释放VC");
    [_myTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
