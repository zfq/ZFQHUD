//
//  TestFileManager.m
//  ZFQHUD
//
//  Created by _ on 16/7/13.
//  Copyright © 2016年 zfq. All rights reserved.
//

#import "TestFileManager.h"

@implementation TestFileManager

+ (void)readFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bbb" ofType:@"docx"];
    processContentsOfFile([filePath UTF8String]);
}

bool MyProcessFileData(char *buffer,ssize_t actual)
{
    return false;
}

dispatch_source_t processContentsOfFile(const char *fileName)
{
    //准备读取文件
    int fd = open(fileName, O_RDONLY);
    if (fd == -1) {
        return NULL;
    }
    fcntl(fd, F_SETFL,O_NONBLOCK);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t readSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, fd, 0, queue);
    if (!readSource) {
        close(fd);
        return NULL;
    }
    
    //添加事件处理回调
    
    dispatch_source_set_event_handler(readSource, ^{
        size_t estimated = dispatch_source_get_data(readSource) + 1;
        //将data读入到缓冲区中
        char *buffer = (char *)malloc(estimated * sizeof(char));
        if (buffer) {
            ssize_t actual = read(fd, buffer, estimated);
            if (actual == -1) {
                NSLog(@"读取出错");
            } else if (actual == 0) {
                NSLog(@"到达文件结尾");
            }
            if (actual < estimated) {
                NSLog(@"读取文件完成");
            }
            bool done = MyProcessFileData(buffer,actual);
            printf("%s +++++++++++++++\n",buffer);
            //数据处理完成后释放
            free(buffer);
            if (done) {
                dispatch_source_cancel(readSource);
            }
        }
    });
    
    dispatch_source_set_cancel_handler(readSource, ^{
        //取消时就关闭文件的读取
        close(fd);
    });
    
    //开始读文件
    dispatch_resume(readSource);
    
    return readSource;
}
@end
