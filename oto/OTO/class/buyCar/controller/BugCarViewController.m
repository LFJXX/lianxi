//
//  BugCarViewController.m
//  OTO
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "BugCarViewController.h"
#import "BuyCarViewCell.h"
#import "LFBottomView.h"

@interface BugCarViewController ()<UITableViewDelegate,UITableViewDataSource,BuyCarViewDelegate,LFBottomViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) LFBottomView *bottomView;
@property (nonatomic,strong) NSMutableArray *buyCarArray;
@property (nonatomic,assign) NSInteger  *count;


@end

@implementation BugCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNav];
    [self prepareTableView];
    [self prepareTabbarForAccount];
}
- (void)setUpNav{

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 40)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.selected = NO;
    [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)prepareTableView{

    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableV];
    self.tableView = tableV;
    [tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 64, 0));
    }];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.backgroundColor = LFLightGrayColor;
    
}
- (void)prepareTabbarForAccount{

    LFBottomView *tabbar = [[LFBottomView alloc] init];
    tabbar.backgroundColor = [UIColor blackColor];
    tabbar.alpha = 0.85;
    tabbar.delegate = self;
    self.bottomView = tabbar;
    [self.view addSubview:tabbar];
    [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@(64));
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(0);
   
    }];
}
#pragma mark UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BuyCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lala"];
    if (cell == nil) {
        cell = [[BuyCarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lala"];
    }
    cell.delegate = self;
    cell.selectedBtn.tag = indexPath.section;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addData];

    [cell.selectedBtn setSelected:[self.buyCarArray indexOfObject:@(indexPath.section)] != NSNotFound];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

#pragma mark 点击右边按钮
- (void)rightClick:(UIButton *)sender{
    [self.buyCarArray removeAllObjects];
    [self.tableView reloadData];
    sender.selected = !sender.selected;
    self.bottomView.edit = sender.selected;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma  delegate
- (void)seletedDidClick:(UIButton *)sender event:(id)event{
    NSLog(@"-----");

    sender.selected = !sender.selected;
    NSSet *set = [event allTouches];
    UITouch *touch = [set anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSInteger section = indexPath.section;
    if (![self.buyCarArray containsObject:@(section)]) {
        [self.buyCarArray addObject:@(section)];
    }else{
    
        [self.buyCarArray removeObject:@(section)];
    }
    if (_buyCarArray.count == 10) {
        self.bottomView.selectedBtn.selected = YES;
    }else{
        self.bottomView.selectedBtn.selected = NO;
    }

}

- (void)seletedAllBuyCarGoods:(UIButton *)sender{

    [self.buyCarArray removeAllObjects];
    if (sender.selected == NO ) {
        
       [self.tableView reloadData];
        
    }else{
    
        for (int i = 0;i < 10 ; i++) {
            
            [self.buyCarArray addObject:@(i)];
        }
        [self.tableView reloadData];
    }
}

#pragma mark 懒加载
- (NSMutableArray *)buyCarArray{

    if (_buyCarArray == nil) {
        _buyCarArray = [NSMutableArray arrayWithCapacity:0];
    }
   
    return _buyCarArray;
}

@end
