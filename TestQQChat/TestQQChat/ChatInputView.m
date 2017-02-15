//
//  ChatInputView.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/14.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "ChatInputView.h"
#import "Masonry.h"

@interface ChatInputView () <UITextViewDelegate>

@property (nonatomic ,strong) UITextView *inputTextView;


@end

@implementation ChatInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{

    self = [super init];
    if (self) {
        
        [self addSubview:self.inputTextView];
        [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(5);
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.height.equalTo(@30);
        }];
        
        /**
         *    监听键盘显示、隐藏变化，让自己伴随键盘移动
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];

        
    }
    return self;
}

-(void)keyboardChange:(NSNotification *)notification
{
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (notification.name == UIKeyboardWillShowNotification) {
        
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-keyboardEndFrame.size.height-5);
        }];
        
    } else{
        [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5);
        }];

    }
    
    [self.superview layoutIfNeeded];
    [UIView commitAnimations];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    //是否点击了发送按钮
    if ([text isEqualToString:@"\n"]) {
        if (![textView.text isEqualToString:@""]){
            if ([self.delegate respondsToSelector:@selector(sendMessage:)]) {
                [self.delegate sendMessage:textView.text];
            }
            textView.text = @"";
            [self textViewDidChange:textView];

        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{

    CGSize size = [textView sizeThatFits:CGSizeMake(textView.contentSize.width, 0)];
    
//    NSLog(@"%@", NSStringFromCGSize(size));
    
    float contentHeight ;
    if (size.height >=80) {
        textView.scrollEnabled = YES;
        contentHeight = 80;
    } else {
        textView.scrollEnabled = NO;
        contentHeight = size.height;
    }
    
    if (contentHeight != textView.frame.size.height ) {
        [textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentHeight);
        }];
    }
    
    [self layoutIfNeeded];
    
}



-(UITextView *)inputTextView{

    if (_inputTextView) {
        return _inputTextView;
    }
    _inputTextView = [[UITextView alloc] init];
    _inputTextView.delegate = self;
    _inputTextView.font = [UIFont systemFontOfSize:14.0];
    _inputTextView.returnKeyType = UIReturnKeySend;
    _inputTextView.layer.cornerRadius = 4;
    
    return _inputTextView;
}

//-(CGSize)intrinsicContentSize{
//
//}

@end
