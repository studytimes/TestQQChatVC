//
//  TestCocoAsyncSocket.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/18.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "TestCocoAsyncSocket.h"
#import "GCDAsyncSocket.h" //调用TCP链接

static NSString *ServerHost = @"127.0.0.1";
static const uint16_t ServerPort = 7070;

@interface TestCocoAsyncSocket ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *gcdsocket;

@end

@implementation TestCocoAsyncSocket

+(instancetype)shareInstance{

    static TestCocoAsyncSocket *socket = nil;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        socket = [[TestCocoAsyncSocket alloc] init];
    });
    return socket;
}

- (void) initSocket{

    self.gcdsocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

}

#pragma mark -- 对外接口
//建立链接
- (BOOL)connect{
    return [self.gcdsocket connectToHost:ServerHost onPort:ServerPort error:nil];
}

//断开链接
- (void)disconnect {

    [self.gcdsocket disconnect];
}

//发送消息
- (void)sendMessage:(NSString *)msg{

    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    //第二个参数 ， 请求超时时间
    [self.gcdsocket writeData:data withTimeout:-1 tag:110];
}

//监听最新的消息
- (void)pullMessage{

    //监听读数据的代理  -1永远监听，不超时，但是只收一次消息，
    //所以每次接受到消息还得调用一次
    [self.gcdsocket readDataWithTimeout:-1 tag:110];
}

#pragma mark -- GCDAsyncSocketDelegate
//链接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    NSLog(@"链接成功 host:%@ port:%d",host, port);
    [self pullMessage];
    //心跳机制
}

//断开链接
-(void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"链接成功 host:%@ port:%d",sock.localHost,sock.localPort);
   //断线重连
    
}

//写成功的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    //    NSLog(@"写的回调,tag:%ld",tag);
}

//收到消息的回调
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    [self pullMessage];
}


@end
