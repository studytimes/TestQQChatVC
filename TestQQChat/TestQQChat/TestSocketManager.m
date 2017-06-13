//
//  TestSocketManager.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/18.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "TestSocketManager.h"
#import <sys/socket.h>
#import <sys/types.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//客户端调用 socket(...) 创建socket；
//客户端调用 connect(...) 向服务器发起连接请求以建立连接；
//客户端与服务器建立连接之后，就可以通过send(...)/receive(...)向客户端发送或从客户端接收数据；
//客户端调用 close 关闭 socket；

@interface TestSocketManager ()

@property (nonatomic, assign) int clientSocket;

@end

@implementation TestSocketManager


+ (instancetype)shareInstance{
    static TestSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TestSocketManager alloc] init];
        [manager initSocket];
        [manager pullMsg];
    });
    return manager;
}


//初始化链接
- (void)initSocket {
 //每次链接前 先断开链接
    if (self.clientSocket != 0) {
        [self disconnect];
        self.clientSocket = 0;
    }
    //创建客户端socket;
    self.clientSocket = CreateClientSocket();
    //服务端Ip
    const char *sever_ip = "127.0.0.1";
    //服务器端口
    short server = 7070;
    //等于0说明链接失败
    if (ConnectionToServer(self.clientSocket, sever_ip, server) == 0) {
        printf("链接聊天服务器失败");
    } else {
        printf("链接聊天服务器成功");
    }
    
}

static int CreateClientSocket (){

    int clientSocket = 0;
    //创建一个socket,返回值为Int。（注scoket其实就是Int类型）
    //第一个参数addressFamily IPv4(AF_INET) 或 IPv6(AF_INET6)。
    //第二个参数 type 表示 socket 的类型，通常是流stream(SOCK_STREAM) 或数据报文datagram(SOCK_DGRAM)
    //第三个参数 protocol 参数通常设置为0，以便让系统自动为选择我们合适的协议，对于 stream socket 来说会是 TCP 协议(IPPROTO_TCP)，而对于 datagram来说会是 UDP 协议(IPPROTO_UDP)。
    clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    return clientSocket;

}

static int ConnectionToServer(int client_socket,const char * server_ip,unsigned short port)
{
    
    //生成一个sockaddr_in类型结构体
    struct sockaddr_in sAddr={0};
    sAddr.sin_len=sizeof(sAddr);
    //设置IPv4
    sAddr.sin_family=AF_INET;
    
    //inet_aton是一个改进的方法来将一个字符串IP地址转换为一个32位的网络序列IP地址
    //如果这个函数成功，函数的返回值非零，如果输入地址不正确则会返回零。
    inet_aton(server_ip, &sAddr.sin_addr);
    
    //htons是将整型变量从主机字节顺序转变成网络字节顺序，赋值端口号
    sAddr.sin_port=htons(port);
    
    //用scoket和服务端地址，发起连接。
    //客户端向特定网络地址的服务器发送连接请求，连接成功返回0，失败返回 -1。
    //注意：该接口调用会阻塞当前线程，直到服务器返回。
    if (connect(client_socket, (struct sockaddr *)&sAddr, sizeof(sAddr))==0) {
        return client_socket;
    }
    return 0;
}
#pragma mark - 新线程来接收消息

- (void)pullMsg
{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(recieveAction) object:nil];
    [thread start];
}

#pragma mark - 对外逻辑

- (void)connect
{
    [self initSocket];
}
- (void)disconnect
{
    //关闭连接
    close(self.clientSocket);
}

//发送消息
- (void)sendMessage:(NSString *)msg
{
    
    const char *send_Message = [msg UTF8String];
    send(self.clientSocket,send_Message,strlen(send_Message)+1,0);
    
}

//收取服务端发送的消息
- (void)recieveAction{
    while (1) {
        char recv_Message[1024] = {0};
        recv(self.clientSocket, recv_Message, sizeof(recv_Message), 0);
        printf("%s\n",recv_Message);
    }
}

@end
