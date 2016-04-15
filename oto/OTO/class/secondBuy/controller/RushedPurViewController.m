//
//  RushedPurViewController.m
//  OTO
//
//  Created by apple on 15/12/31.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "RushedPurViewController.h"
#import "RushViewCell.h"

@interface RushedPurViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UIView *menutabbar;
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) CGPoint beginPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *menuArr;
@property (nonatomic,assign) NSInteger  datacount;
@end

@implementation RushedPurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datacount = 2;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"秒杀";
    [self prepareForMenutabBar];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.selectedIndex = 0;
    [self prepareTableView];
}
- (void)prepareTableView{

    UITableView *tableView = [[UITableView alloc] init];
    self.myTableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menutabbar.mas_bottom);
        make.left.equalTo(self.view);
        make.height.equalTo(self.view).offset(-108);
        make.width.equalTo(self.view);
    }];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"RushViewCell" bundle:nil] forCellReuseIdentifier:@"Rush"];
}
- (void)prepareForMenutabBar{

    UIView *tabbar = [[UIView alloc] init];
    self.menutabbar = tabbar;
//    tabbar.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tabbar];
    
    [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width, 44));
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view.mas_left);
    }];
    [self prepareMenuChildView];
}

- (void)prepareMenuChildView{
    NSInteger count = self.menuArr.count;
    CGFloat W = self.view.width / count;
    for (int i = 0; i < count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.menuArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"red"] forState:UIControlStateHighlighted];
        [self.menutabbar addSubview:btn];
      
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.menutabbar.mas_top);
            make.left.equalTo(self.menutabbar).offset(i*W);
            make.width.mas_equalTo(@(W));
            make.height.equalTo(self.menutabbar.mas_height);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(menuTabbarDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i != 0) {
            UIView *linView = [[UIView alloc] init];
            [btn addSubview:linView];
            linView.backgroundColor = [UIColor lightGrayColor];
            [linView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.menutabbar.mas_top);
                make.left.equalTo(self.menutabbar).offset(i*W);
                make.width.mas_equalTo(@(1));
                make.height.equalTo(self.menutabbar.mas_height);
            }];

        }

    }
    
  
}


- (void)pan:(UIGestureRecognizer *)pan{
 
 
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _beginPoint = [pan locationInView:self.view];
            break;
        case UIGestureRecognizerStateEnded:
            _endPoint = [pan locationInView:self.view];
            CGFloat shortX = _endPoint.x - _beginPoint.x;
            if (shortX < -100) {
                if (self.selectedIndex < 3) {
                        self.selectedIndex++;

                    return;
                }
            }
            
            if (shortX > 100 ) {
                if (self.selectedIndex > 0) {
                        self.selectedIndex--;
                    return;
                }
            }
            NSLog(@"beginX:%f--endX:%f--shortX:%f",_beginPoint.x,_endPoint.x,shortX);
            self.beginPoint = CGPointMake(0, 0);
            self.endPoint = CGPointMake(0, 0);
            break;
        default:
            break;
    }

}
- (void)menuTabbarDidClick:(UIButton *)sender{
    self.selectedIndex = sender.tag;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{

    _selectedIndex = selectedIndex;
    NSMutableArray *btnArr = [NSMutableArray arrayWithCapacity:0];
    for (UIView *btn in self.menutabbar.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btnArr addObject:btn];
        }
    }
    
    UIButton *btn = btnArr[selectedIndex];
    [self changeTabbleViewDataSource:btn];
    switch (selectedIndex) {
        case 0:
            self.datacount = 4;
             [self.myTableView reloadData];
            break;
        case 1:
            self.datacount = 3;
             [self.myTableView reloadData];
            break;
        case 2:
            self.datacount = 2;
             [self.myTableView reloadData];
            break;
        case 3:
            self.datacount = 5;
             [self.myTableView reloadData];
            break;
            
        default:
            break;
           
    }
   


}

- (void)changeTabbleViewDataSource:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark UITableViewDelegate  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.datacount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RushViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rush"];
    if (cell == nil) {
        cell = [[RushViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rush"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击查看详情");
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 108;
}

#pragma mark 懒加载
- (NSMutableArray *)menuArr{

    if (_menuArr == nil) {
        _menuArr = [NSMutableArray arrayWithObjects:@"8:00",@"10:00",@"14:00",@"16:00",nil];
    }
    return _menuArr;
}

@end
