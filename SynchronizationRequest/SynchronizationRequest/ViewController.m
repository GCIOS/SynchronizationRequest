//
//  ViewController.m
//  SynchronizationRequest
//
//  Created by 高崇 on 17/2/14.
//  Copyright © 2017年 LieLvWang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
{
    dispatch_semaphore_t _semaphore;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSLog(@"开始");
    
    _semaphore = dispatch_semaphore_create(0); //创建信号量
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"http://api.dangmeitoutiao.com/api/token/add"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"请求...");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"dict:%@",dict);
        dispatch_semaphore_signal(_semaphore);   //发送信号  +1
    }] resume];
    
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(2);
//            dispatch_semaphore_signal(_semaphore);   //发送信号
//        });
    
    dispatch_semaphore_wait(_semaphore,DISPATCH_TIME_FOREVER);  //等待  -1
    NSLog(@"数据加载完成！");
}

@end
