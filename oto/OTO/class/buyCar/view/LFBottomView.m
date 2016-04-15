//
//  LFBottomView.m
//  OTO
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFBottomView.h"

@interface LFBottomView ()
@end

@implementation LFBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self makeUI];
    }
    return self;

}

- (void)makeUI{

    UIButton *selectedBtn = [[UIButton alloc] init];
    self.selectedBtn = selectedBtn;
//    selectedBtn.backgroundColor = [UIColor greenColor];
    [selectedBtn setImage:[UIImage imageNamed:@"pic_unchecked_icon"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"pic_checked_icon"] forState:UIControlStateSelected];
     [selectedBtn addTarget:self action:@selector(seletedAllGood:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectedBtn];
    
    UIButton *accountBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [accountBtn setTitle:@"结算 (3)" forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(payMoney:) forControlEvents:UIControlEventTouchUpInside];
    accountBtn.backgroundColor = [UIColor redColor];
    [accountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.accountBtn = accountBtn;
    [self addSubview:accountBtn];
    
    UIButton *deletedBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.deletedBtn = deletedBtn;
    [deletedBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deletedBtn addTarget:self action:@selector(deleteSeletedGood:) forControlEvents:UIControlEventTouchUpInside];
    [deletedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deletedBtn.backgroundColor = [UIColor redColor];
    self.deletedBtn.hidden = YES;
    [self addSubview:deletedBtn];
    
    UILabel *seletedLable = [[UILabel alloc] init];
    seletedLable.text = @"全选";
    seletedLable.font = [UIFont systemFontOfSize:15];
    seletedLable.textColor = [UIColor whiteColor];
    self.seletedLable = seletedLable;
    [self addSubview:seletedLable];
    
    UIView *countView = [[UIView alloc] init];
    self.countView = countView;
//    countView.backgroundColor = [UIColor yellowColor];
    [self addSubview:countView];
    
    UILabel *sumlable = [[UILabel alloc] init];
    sumlable.textColor = [UIColor redColor];
    sumlable.font = [UIFont systemFontOfSize:14];
    self.sumMoneyLable = sumlable;
    [self.countView addSubview:sumlable];
    
    UILabel *totalLable = [[UILabel alloc] init];
    totalLable.textColor = [UIColor redColor];
    totalLable.font = [UIFont systemFontOfSize:14];
    self.totalMoneyLable = totalLable;
    [self.countView addSubview:totalLable];
    [self changeData];
}
- (void)changeData{

    self.sumMoneyLable.text = @"合计 : 1280元";
    self.totalMoneyLable.text = @"总计 : 1285元,包含运费: 5元";

}
- (void)setEdit:(BOOL)edit{

    _edit = edit;
    self.selectedBtn.selected = NO;
    if (edit == YES) {
        
        self.countView.hidden = YES;
        self.deletedBtn.hidden = NO;
        self.accountBtn.hidden = YES;
    }else{
        self.countView.hidden = NO;
        self.deletedBtn.hidden = YES;
        self.accountBtn.hidden = NO;
    }
}

- (void)payMoney:(UIButton *)sender{
    NSLog(@"结算");
}
- (void)deleteSeletedGood:(UIButton *)sender{
    NSLog(@"删除选中商品");
}
- (void)seletedAllGood:(UIButton *)sender{
    NSLog(@"选中全部商品");
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(seletedAllBuyCarGoods:)]) {
        [self.delegate seletedAllBuyCarGoods:self.selectedBtn];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.accountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.selectedBtn);
        make.size.mas_equalTo(CGSizeMake(80, 40));
        
    }];
    [self.deletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.accountBtn);
    }];
    [self.seletedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectedBtn.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.selectedBtn);
    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.seletedLable.mas_right);
        make.right.equalTo(self.accountBtn.mas_left).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    [self.sumMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countView);
        make.width.equalTo(self.countView);
        make.left.equalTo(self.countView);
        make.height.mas_equalTo(@(20));
    }];
    [self.totalMoneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.countView);
        make.right.equalTo(self.countView);
        make.bottom.equalTo(self.countView);
        make.height.equalTo(self.sumMoneyLable);
    }];
    
}
@end
