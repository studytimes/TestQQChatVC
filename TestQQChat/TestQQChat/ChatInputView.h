//
//  ChatInputView.h
//  TestQQChat
//
//  Created by aigegou on 2017/2/14.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^SendMessage)(NSString *message);

@protocol UserSenderInfoDelegate <NSObject>

-(void)sendMessage:(NSString *)message;

@end

@interface ChatInputView : UIView

@property (nonatomic, weak) id <UserSenderInfoDelegate> delegate;

//@property (nonatomic, copy) SendMessage message;

@end
