//
//  ChatViewCell.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/9.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "ChatViewCell.h"
#import "Masonry.h"

@implementation ChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        mHead = [[UIImageView alloc] init];
        mHead.image = [UIImage imageNamed:@"user_avatar_default"];
        [self.contentView addSubview:mHead];

        mBubbleImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:mBubbleImageView];
        
        chatLabel = [[UILabel alloc] init];
        chatLabel.numberOfLines = 0;
        chatLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:chatLabel];
    
    }
    
    return self;
}

- (void)setChatModel:(ChatInfoModel *)chatModel{

    chatLabel.text = chatModel.messageText;
    //判断是不是自己发送的
    if (chatModel.isMySender) {//chat_send_imagemask
        mBubbleImageView.image = [[UIImage imageNamed:@"chat_send_nor"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];

        [mHead mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.top.equalTo(self.contentView.mas_top);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        [chatLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(65);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.right.equalTo(self.contentView.mas_right).offset(-60);
        }];

        [mBubbleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.top.equalTo(self.contentView.mas_top).offset(2);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
        }];

        
    } else {
    
        mBubbleImageView.image = [[UIImage imageNamed:@"chat_recive_nor"] stretchableImageWithLeftCapWidth:30 topCapHeight:30];

        [mHead mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.contentView.mas_top);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];

        [chatLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(65);
            make.top.equalTo(self.contentView.mas_top).offset(12);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
            make.right.equalTo(self.contentView.mas_right).offset(-65);
        }];
        
        [mBubbleImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.top.equalTo(self.contentView.mas_top).offset(2);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
            make.right.equalTo(self.contentView.mas_right).offset(-50);
        }];

    }
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
