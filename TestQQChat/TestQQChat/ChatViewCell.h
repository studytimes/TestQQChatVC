//
//  ChatViewCell.h
//  TestQQChat
//
//  Created by aigegou on 2017/2/9.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatInfoModel.h"

@interface ChatViewCell : UITableViewCell {

    /**
     *  用户头像
     */
    UIImageView *mHead;
    
    /**
     *  气泡
     */
    UIImageView *mBubbleImageView;
    
    /**
     * 消息是否是本人发送
     */
    BOOL isSender;
    
    /** 
     * 聊天文本
     */
    UILabel *chatLabel;
}

@property (nonatomic, strong) ChatInfoModel *chatModel;


@end
