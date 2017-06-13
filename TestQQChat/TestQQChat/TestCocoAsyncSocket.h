//
//  TestCocoAsyncSocket.h
//  TestQQChat
//
//  Created by aigegou on 2017/2/18.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestCocoAsyncSocket : NSObject

+ (instancetype)shareInstance;

- (BOOL)connect;

- (void)disconnect;

- (void)sendMessage:(NSString *)msg;

- (void)pullMessage;

@end
