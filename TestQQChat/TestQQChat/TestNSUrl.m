//
//  TestNSUrl.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/15.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "TestNSUrl.h"

@implementation TestNSUrl

/** 
 *使用NSUrlSession分为两步：创建 task ，执行task
 */

-(void)testUrlSessionDataTask{
//   //简单的get请求
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    //通过url初始化task，在block内部可以直接对返回的数据进行处理
//    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        if (error) {
//            NSLog(@"%@",[error description]);
//        }else {
//            NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
//        }
//        
//    }];
//    //启动任务
//    [task resume];
    
    //简单的post请求
    /**
     *与get 请求的过程是一样的，区别在于对request的处理
     */
    NSURL *postUrl = [NSURL URLWithString:@"https://www.baidu.com/login"];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:postUrl];
    postRequest.HTTPMethod = @"POST";
    postRequest.HTTPBody =[@"name=你好&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //由于要先对request先行处理，我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:postRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"%@",[error description]);
        }else {
            NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
        }
        
    }];
    [task resume];
}

@end
