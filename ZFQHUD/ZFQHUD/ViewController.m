//
//  ViewController.m
//  ZFQHUD
//
//  Created by _ on 16/2/28.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "ViewController.h"
#import "ZFQHUD.h"
#import "Animal.h"
#import "Sheep.h"
#import "Persion.h"
#import <sys/sysctl.h>
#import <mach/mach.h>
#import "TestFileManager.h"
#import "Test1ViewController.h"
#import "ZFQDuckType.h"

@interface ViewController ()
{
    CAShapeLayer *_redCircleLayer;
}
@property (nonatomic,assign) NSUInteger ABC;
@property (nonatomic,strong) dispatch_queue_t isolationQueue;
@property (nonatomic,strong) dispatch_source_t source;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.isolationQueue = dispatch_queue_create("com.zfq.test", 0);
         NSLog(@"22222222");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 60, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    
    v.userInteractionEnabled = NO;
    [self.view addSubview:v];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    CGRect btnFrame = CGRectMake(0, 0, 40, 40);
    CGRect vFrame = [v convertRect:btnFrame toView:self.view];
    btn.frame = vFrame;
    [self.view addSubview:btn];
//    [v addSubview:btn];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UINavigationController *nav;
    
}

- (void)test8
{
    Persion *p = [[Persion alloc] init];
    //    p.runBlock().studyBlock();   //[[p runBlock]() studyBlock]();
    NSInteger a = p.eat(34).eat(48).total;
    NSLog(@"结果为:%zi",a);
}

- (void)tapBtnAction
{
//    Test1ViewController *t = [[Test1ViewController alloc] init];
//    [self.navigationController pushViewController:t animated:YES];
    [ZFQHUD setHUDType:ZFQHUDBlur];
    [ZFQHUD setTapClearDismiss:YES];
    ZFQHUDConfig *config = [ZFQHUDConfig globalConfig];// [[ZFQHUDConfig alloc] init];
    config.alertViewTintColor = [UIColor orangeColor];
    config.alertViewBcgColor = [UIColor grayColor];
    config.alertViewMinWidth = 100;
    [[ZFQHUD sharedView] showWithMsg:@"ssss" duration:2 completionBlk:^{
        NSLog(@"完成");
    }];
}

- (NSString *)myStr
{
//    return nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sss" ofType:@"txt"];
    
    NSString *aa = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return aa;
}

- (void)testGCDTimer
{
}

- (void)requestFinished:(DuckEntity<StudentEntity> *)student
{
    student.Name = @"xxxxx";
    NSLog(@"name:%@,school:%@",student.Name,student.school);
}

- (void)test22
{
    //测试定时功能 比如定时器到今天下午6点整
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    NSDate *date = [formatter dateFromString:@"2016-7-13 12:03"];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = date;
    notification.alertBody = @"时间到啦";
    notification.alertTitle = @"闹钟";
    notification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    dispatch_time_t milestone = getDispatchTimeByDate(date);
    dispatch_after(milestone, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"时间到");
    });
}

dispatch_time_t getDispatchTimeByDate(NSDate * date) {
    NSTimeInterval interval;
    double second,
    subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime( & time, 0);
    return milestone;
}
- (void)test14
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return;
    }
    NSInteger vm = ((vm_page_size * vmStats.free_count) / 1024.0) / 1024.0;
    NSLog(@"%zi",vm);
}

- (void)test15
{
    double dddd = [self usedMemory];
    NSLog(@"%lf",dddd);
}

// 获取当前设备可用内存(单位：MB）
- (double)availableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

- (void)test9
{
    //创建两个串行队列
    dispatch_queue_t queueAA = dispatch_queue_create("com.zfq.AAA", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queueBB = dispatch_queue_create("com.zfq.BBB", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_set_target_queue(queueAA, queueBB);
    
    dispatch_async(queueAA, ^{
        for (NSInteger i = 1; i <= 10; i++) {
            NSLog(@"第一个queue:%@,%ld",[NSThread currentThread],i);
            [NSThread sleepForTimeInterval:1];
            NSLog(@"%ld睡眠结束",i);
            if (i == 5) {
                dispatch_suspend(queueBB);
                NSLog(@"追加结束");
            }
            
        }
    });
    
}

- (void)test10
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, globalQueue);
    dispatch_source_set_event_handler(source, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            //更新UI
            NSLog(@"更新UI");
        });
        NSLog(@"开始处理:%@",[NSThread currentThread]);
    });
    
    //启动source
    dispatch_resume(source);
//    dispatch_source_get_data(source);
    //往source里面添加任务
    dispatch_async(globalQueue, ^{
        //
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"开始发送%@",[NSThread currentThread]);
            dispatch_source_merge_data(source, 1);
        });
//        NSLog(@"开始发送%@",[NSThread currentThread]);
//        dispatch_source_merge_data(source, 1);
    });
}

- (void)test11
{
    //
    dispatch_async(dispatch_get_main_queue(), ^{      //
        NSLog(@"AAAAAA");
        
        //dispatch_sync会等到block完成时才会返回
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"aaaaa");
        });
        /*输出结果为 
         AAAAAA
         aaaaa
         */
    });
    
//    NSMapTable *mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSMapTableStrongMemory];
//    mapTable = [NSMapTable strongToStrongObjectsMapTable];
//    [mapTable setObject:@"aaa" forKey:@"key"];
    
}

- (void)test12
{
    /*
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group,globalQueue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"1结束");
    });
    dispatch_group_async(group,globalQueue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"2结束");
    });
    
//    dispatch_notify(group, dispatch_get_main_queue(), ^(){
//        NSLog(@"全部执行结束");
//    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"全部执行结束");
     */
    
    /*
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:2.5];
    });
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:3.5];
    });
    dispatch_barrier_async(globalQueue, ^{
        NSLog(@"开始写");
        [NSThread sleepForTimeInterval:20];
        NSLog(@"完成写");
    });
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:4];
    });
    dispatch_async(globalQueue, ^{
        [NSThread sleepForTimeInterval:1];
    });
    NSLog(@"完成");
     */
    
    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispathc_sync会将block同步追加到queue中执行，等到block执行完成后返回，记住是同步追加，
    dispatch_sync(queue, ^{
        NSLog(@"在执行:%zi",[NSThread isMainThread]); //是在主线程中执行
        [NSThread sleepForTimeInterval:2];
    });
    NSLog(@"结束");
     */
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        //因为这个async中的block本身是放在main_queue中执行的，而其实在主线程中正在执行这些源代码，所以无法执行追加到main_queue中的blk
        dispatch_sync(mainQueue, ^{
            NSLog(@"在执行:%zi",[NSThread isMainThread]); //是在主线程中执行
            [NSThread sleepForTimeInterval:2];
        });
        NSLog(@"aaa");
    });
    NSLog(@"结束");
    
}
/*
//根据date获取dispatch_time_t
dispatch_time_t getDispatchTimeByDate(NSDate *date)
{
    NSTimeInterval interval;
    double second,subsecond;
    struct timespec time;
    dispatch_time_t milestone;  //milestone 里程碑，转折点
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);    //modf：将一个数的整数部分和小数部分分割出来 subsecond是小数部分，second是整数部分
    
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    
    //创建一个dispatch_time_t
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
}
*/
- (void)setABC:(NSUInteger)abc forKey:(NSString *)key
{
    key = [key copy];
    dispatch_async(self.isolationQueue, ^{
        
    });
}

- (NSUInteger)countForKey:(NSString *)key
{
    __block NSUInteger count;
    dispatch_sync(self.isolationQueue, ^{
        NSLog(@"ok");
    });
    return count;
}

- (void)test20
{
    //获取document文件夹
    NSString *documentURLStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSLog(@"%@",documentURLStr);
    
    int const fd = open(documentURLStr.UTF8String, O_EVTONLY);
    if (fd < 0) {
        char buffer[80];
        int errorNum = 1111;
        strerror_r(errorNum, buffer, sizeof(buffer));
        NSLog(@"不能打开路径%s",buffer);
        return;
    }
    
    dispatch_queue_t myQueue = dispatch_queue_create("com.zfqtest.test", DISPATCH_QUEUE_SERIAL);
    unsigned long mask = DISPATCH_VNODE_WRITE|DISPATCH_VNODE_DELETE|DISPATCH_VNODE_EXTEND|DISPATCH_VNODE_ATTRIB|DISPATCH_VNODE_LINK|DISPATCH_VNODE_RENAME;
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd, mask, myQueue);
    dispatch_source_set_event_handler(source, ^{
        unsigned long const data = dispatch_source_get_data(source);
        if (data & DISPATCH_VNODE_WRITE) {
            NSLog(@"文件夹写入了");
        }
        if (data & DISPATCH_VNODE_DELETE) {
            NSLog(@"删除了");
        }
        if (data & DISPATCH_VNODE_EXTEND) {
            NSLog(@"文件夹大小发生改变");
        }
        if (data & DISPATCH_VNODE_ATTRIB) {
            NSLog(@"文件夹属性发生改变");
        }
        if (data & DISPATCH_VNODE_LINK) {
            NSLog(@"文件夹相关的文件数量发生改变");
        }
        if (data & DISPATCH_VNODE_RENAME) {
            NSLog(@"文件夹被重命名");
        }
    });
    dispatch_source_set_cancel_handler(source, ^{
        close(fd);
    });
    self.source = source;
    dispatch_resume(self.source);
}

- (void)test21
{
    //获取document文件夹
    NSString *documentURLStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentURLStr stringByAppendingPathComponent:@"test.json"];
    NSLog(@"%@",documentURLStr);
    
    int const fd = open(filePath.UTF8String, O_EVTONLY);
    if (fd < 0) {
        char buffer[80];
        int errorNum = 1111;
        strerror_r(errorNum, buffer, sizeof(buffer));
        NSLog(@"不能打开路径%s",buffer);
        return;
    }
    
    dispatch_queue_t myQueue = dispatch_queue_create("com.zfqtest.test", DISPATCH_QUEUE_SERIAL);
    unsigned long mask = DISPATCH_VNODE_WRITE|DISPATCH_VNODE_DELETE|DISPATCH_VNODE_EXTEND|DISPATCH_VNODE_ATTRIB|DISPATCH_VNODE_LINK|DISPATCH_VNODE_RENAME;
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd, mask, myQueue);
    dispatch_source_set_event_handler(source, ^{
        unsigned long const data = dispatch_source_get_data(source);
        if (data & DISPATCH_VNODE_WRITE) {
            NSLog(@"文件夹写入了");
        }
        if (data & DISPATCH_VNODE_DELETE) {
            NSLog(@"删除了");
        }
        if (data & DISPATCH_VNODE_EXTEND) {
            NSLog(@"文件夹大小发生改变");
        }
        if (data & DISPATCH_VNODE_ATTRIB) {
            NSLog(@"文件夹属性发生改变");
        }
        if (data & DISPATCH_VNODE_LINK) {
            NSLog(@"文件夹相关的文件数量发生改变");
        }
        if (data & DISPATCH_VNODE_RENAME) {
            NSLog(@"文件夹被重命名");
        }
    });
    dispatch_source_set_cancel_handler(source, ^{
        close(fd);
    });
    self.source = source;
    dispatch_resume(self.source);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myTest:(UIButton *)sender
{
    
//    [ZFQHUD setHUDType:ZFQHUDBlur];
//    [ZFQHUD show];
//    Animal *a = [[Animal alloc] init];
    
//    NXBPopupView *pv = [[NXBPopupView alloc] init];
//    [pv show];
    
//    CGFloat x = 100;
//    CGFloat y = 200;
//    if (!_redCircleLayer) {
//        _redCircleLayer = [CAShapeLayer layer];
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGFloat radius = 5;
//        CGFloat marginRight= 8;
//        CGPathAddArc(path, NULL, x, y, radius, 0, 2 * M_PI, YES);
//        _redCircleLayer.path = path;
//        _redCircleLayer.fillColor = [UIColor redColor].CGColor;
//    }
//    if (_redCircleLayer.superlayer == nil) {
//        [self.view.layer addSublayer:_redCircleLayer];
//        _redCircleLayer.position = CGPointMake(x, y);
//    }
}
@end
