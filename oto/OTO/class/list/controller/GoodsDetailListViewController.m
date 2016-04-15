//
//  GoodsListViewController.m
//  OTO
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "GoodsDetailListViewController.h"

@interface GoodsDetailListViewController ()

@property (nonatomic,strong) NSMutableArray *goodImageArray;
@property (nonatomic,strong) DCPicScrollView *picView;

@end

@implementation GoodsDetailListViewController

- (NSMutableArray *)goodImageArray{

    if (_goodImageArray == nil) {
        _goodImageArray = [NSMutableArray array];
    }
    return _goodImageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self makeUI];
}
- (void)makeUI{

    for (int i = 1; i < 8; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i];
        [self.goodImageArray addObject:imageName];
//        NSString *imageTitle = [NSString stringWithFormat:@"我是第%d张图片",i];
//        [imageTitleArr addObject:imageTitle];
    }
    
    DCPicScrollView *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 64, self.view.width, 150) WithImageUrls:_goodImageArray];
    self.picView = picView;
   
//    picView.titleData = imageTitleArr;
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {
        
        LFLOG(@"点击了第%zd张图片",index);
    }];
    [self.view addSubview:_picView];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
