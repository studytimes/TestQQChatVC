//
//  ViewController.m
//  TestQQChat
//
//  Created by aigegou on 2017/2/9.
//  Copyright © 2017年 aigegou. All rights reserved.
//

#import "ViewController.h"
#import "ChatInfoModel.h"
#import "ChatViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "ChatInputView.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArr;
}

@property (nonatomic, strong) ChatInputView *bottomInputView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mytable.dataSource = self;
    self.mytable.delegate = self;
//    self.mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dataArr = [NSMutableArray array];
    
    for (int i=0; i<5; i++) {
        ChatInfoModel *tmpModel = [[ChatInfoModel alloc] init];
        tmpModel.messageText = [NSString stringWithFormat:@"adosjfladsjfladjsfkladjsklfhjadsjkfhjkadshfkjadhfjkhajfhjhfajkhfjkahfjkh"];
        tmpModel.isMySender = i%2 == 0? YES :NO;
        [dataArr addObject:tmpModel];
    }
    [self.mytable registerClass:[ChatViewCell class] forCellReuseIdentifier:@"ChatViewCell"];
 
    [self.view addSubview:self.bottomInputView];
    [self.bottomInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(@40);
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatViewCell" forIndexPath:indexPath];
    [self configModelCell:cell atIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;

}

- (void)configModelCell:(ChatViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    cell.chatModel = dataArr[indexPath.row];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [tableView fd_heightForCellWithIdentifier:@"ChatViewCell" configuration:^(ChatViewCell *cell) {
        [self configModelCell:cell atIndexPath:indexPath];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [dataArr count];
}

-(ChatInputView *)bottomInputView {
    if (_bottomInputView) {
        return _bottomInputView;
    }
    _bottomInputView = [[ChatInputView alloc] init];
    _bottomInputView.backgroundColor = [UIColor redColor];
    return _bottomInputView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
