//
//  HomeViewController.m
//  OTO
//
//  Created by apple on 15/12/29.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "HomeViewController.h"
#import "PurchaseViewCell.h"
#import "CommendViewCell.h"
#import "GoodsDetailListViewController.h"


@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) DCPicScrollView *picView;
@property (nonatomic,weak) UICollectionView *collectView;
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self prepareTableView];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载 scrollView
- (void)prepareTableView{
    UITableView *tableV = [[UITableView alloc] init];
    self.tableView = tableV;
    [self.view addSubview:tableV];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.height-100));
        
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;

}


#pragma mark UICollectionView degegate和dataSource 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PurchaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"purchase" forIndexPath:indexPath];

    [cell confignData];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RushedPurViewController *rushVc = [[RushedPurViewController alloc] init];
    [self.navigationController pushViewController:rushVc animated:YES];


}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
    CGFloat x = 110*20 - point.x;
    if (x < self.view.width) {
        RushedPurViewController *rushVc = [[RushedPurViewController alloc] init];
        [self.navigationController pushViewController:rushVc animated:YES];

    }
}
#pragma mark  UITableView degegate和dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 2) {
        return 20;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picView"];
        NSMutableArray *imageNameArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *imageTitleArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 1; i < 8; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i];
            [imageNameArr addObject:imageName];
            NSString *imageTitle = [NSString stringWithFormat:@"我是第%d张图片",i];
            [imageTitleArr addObject:imageTitle];
        }
      
        DCPicScrollView *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.width, 150) WithImageUrls:imageNameArr];
        self.picView = picView;
//        picView.placeImage = [UIImage imageNamed:@"place.png"];
        picView.titleData = imageTitleArr;
        [picView setImageViewDidTapAtIndex:^(NSInteger index) {
            
            LFLOG(@"点击了第%zd张图片",index);
        }];
        [cell.contentView addSubview:_picView];
        
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"collectView"];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
        [cell.contentView addSubview:bgView];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake(100, 150);
        
        UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:bgView.bounds collectionViewLayout:layout];
        self.collectView = collectView;
        collectView.delegate = self;
        collectView.dataSource = self;
        collectView.backgroundColor = LFLightGrayColor;
        collectView.showsHorizontalScrollIndicator = NO;
        [bgView addSubview:collectView];
        [self.collectView  registerNib:[UINib nibWithNibName:@"PurchaseViewCell" bundle:nil] forCellWithReuseIdentifier:@"purchase"];
       return cell;
        
    }else{
        
        CommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commend"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CommendViewCell" owner:nil options:nil] lastObject];
        }
        [cell confignData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        return 150;
    }else if (indexPath.section == 1){
    
        return 155;
    }else{
    
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        GoodsDetailListViewController *goodVc = [[GoodsDetailListViewController alloc] init];
        [self.navigationController pushViewController:goodVc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *headView = [[UILabel alloc] init];
    headView.backgroundColor = LFLightGrayColor;
    headView.font = [UIFont systemFontOfSize:13];
    if (section == 2) {
        headView.text = @"   今日推荐";
        return headView;
    }else if(section == 1){
        headView.text = @"   限时秒杀  02:15:18";
        return headView;
    }else{
        return nil;
    
        
    }
}



#pragma mark 懒加载

@end
