//
//  PersonTrendViewController.m
//  OTO
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "PersonTrendViewController.h"
#import "PersonInfomationViewController.h"

@interface PersonTrendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *heardView;
@property (nonatomic,strong) UIImageView *photoView;
@property (nonatomic,strong) UIButton *iconBtn;
@property (nonatomic,strong) UITableView *myTableView;
@end

@implementation PersonTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.heardView;
}

#pragma mark action

- (void)changePhoto:(UIGestureRecognizer *)tap{
    // NSLocalizedString(@"Cancel", nil);
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更换相册封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ChangePhotoViewController *changePhoto = [[ChangePhotoViewController alloc] init];
        [self.navigationController pushViewController:changePhoto animated:YES];
        
    }];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    
    [okAction setValue:[UIColor blackColor] forKeyPath:@"titleTextColor"];
    [cancleAction setValue:[UIColor redColor] forKeyPath:@"titleTextColor"];
    [alter addAction:okAction];
    [alter addAction:cancleAction];
    [self presentViewController:alter animated:YES completion:nil];
    
}
- (void)checkInformation:(UIButton *)sender{

    PersonInfomationViewController *personInfo = [[PersonInfomationViewController alloc] init];
    [self.navigationController pushViewController:personInfo animated:YES];
}
#pragma mark UITableViewDelegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
#pragma mark 懒加载
- (UITableView *)myTableView{

    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
- (UIView *)heardView{
    
    if (_heardView == nil) {
        _heardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        //        _heardView.backgroundColor = [UIColor yellowColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 170)];
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.layer.masksToBounds = YES;
        self.photoView = imageV;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoto:)];
        [self.photoView addGestureRecognizer:tap];
        imageV.userInteractionEnabled = YES;
        imageV.image = [UIImage imageNamed:@"photo"];
        [_heardView addSubview:imageV];
        UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 80, CGRectGetMaxY(imageV.frame)-30, 60, 60)];
        self.iconBtn = iconBtn;
        _iconBtn.layer.cornerRadius = 10;
        _iconBtn.layer.masksToBounds = YES;
        [iconBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [iconBtn addTarget:self action:@selector(checkInformation:) forControlEvents:UIControlEventTouchUpInside];
        [_heardView addSubview:iconBtn];
        
    }
    return _heardView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
