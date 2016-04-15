//
//  FriendViewController.m
//  OTO
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "ChatViewController.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mytableView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,weak) UIImageView *unImageView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mytableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

#pragma mark UITableViewDelegate UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }else{
    
        return 20;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hello"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hello"];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.headerView];
        return cell;
        
        
    }else{
    
        
        static NSString *identifer = @"message";
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconView.image = [UIImage imageNamed:@"10000009"];
        cell.nameLable.text = @"张小三";
        cell.timeLable.text = @"8:30";
        cell.ContentLable.text = @"今天吃饭了吗";
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        FriendsTrendsViewController *trendsVC = [[FriendsTrendsViewController alloc] init];
        [self.navigationController pushViewController:trendsVC animated:YES];
        
    }else{
    
        
        ChatViewController *chatVc = [[ChatViewController alloc] initWithConversationChatter:@"15038046154" conversationType:EMConversationTypeGroupChat];
        [self.navigationController pushViewController:chatVc animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}


#pragma mark  初始化
- (UITableView *)mytableView{

    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 40) style:UITableViewStylePlain];
        _mytableView.delegate = self;
        _mytableView.dataSource = self;
        [_mytableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"message"];
    }
    return _mytableView;
}

-(UIView *)headerView{

    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35 ,35)];
        imageV.image = [UIImage imageNamed:@"10000014"];
        [_headerView addSubview:imageV];
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageV.frame)+10, imageV.y, 100, 35)];
        nameLable.text = @"朋友圈";
        [_headerView addSubview:nameLable];
        
        UIImageView *underedImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width- 45, imageV.y, 35, 35)];
        underedImage.image = [UIImage imageNamed:@"09999988"];
        self.unImageView = underedImage;
        [_headerView addSubview:underedImage];
    }
    return _headerView;
    
    
}

@end
