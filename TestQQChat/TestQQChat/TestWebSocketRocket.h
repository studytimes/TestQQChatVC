//
//  TestWebSocketRocket.h
//  TestQQChat
//
//  Created by aigegou on 2017/2/25.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum :NSUInteger {
    disConnectByUser,
    disConnectByServer,
} DisConnectType;



@interface TestWebSocketRocket : NSObject

+ (instancetype)shareManager;

- (void)connect;
- (void)disConnect;

- (void)sendMsg:(NSString *)msg;

- (void)ping;

@end
