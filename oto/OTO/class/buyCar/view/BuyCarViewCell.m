//
//  BuyCarViewCell.m
//  OTO
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "BuyCarViewCell.h"

@interface BuyCarViewCell ()

@end

@implementation BuyCarViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{


    UIView *upView = [[UIView alloc] init];
    self.upView = upView;
    [self.contentView addSubview:upView];
    
    UIButton *seleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectedBtn = seleteBtn;
    [seleteBtn setImage:[UIImage imageNamed:@"icon-checkbox-unselected-25x25"] forState:UIControlStateNormal];
    [seleteBtn setImage:[UIImage imageNamed:@"icon-checkbox-selected-green-25x25"] forState:UIControlStateSelected];
    [seleteBtn addTarget:self action:@selector(seletedBtnClick:event:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:seleteBtn];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    

    self.nameLable = [self creatLableWithFont:15 color:[UIColor blackColor]];
    self.nameLable.numberOfLines = 2;

    self.pricelable = [self creatLableWithFont:13 color:[UIColor grayColor]];
 
    
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.plusBtn = plusBtn;
    [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:plusBtn];

    self.countLable = [self creatLableWithFont:13 color:[UIColor redColor]];
    self.countLable.textAlignment = NSTextAlignmentCenter;

    
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];;
    self.cutBtn = cutBtn;
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cutBtn];
    
    UIView *downView = [[UIView alloc] init];
    self.downView = downView;
    [self.contentView addSubview:downView];
    
    UIView *linview = [[UIView alloc] init];
    linview.backgroundColor = LFLightGrayColor;
    self.linview = linview;
    [self.downView addSubview:linview];
    
    UILabel *rateLable = [[UILabel alloc] init];
    rateLable.font = [UIFont systemFontOfSize:14];
    rateLable.textColor = [UIColor redColor];
    self.rateLable = rateLable;
    [self.downView addSubview:rateLable];
}

- (void)setCount:(NSInteger)count{
    _count = count;
    self.countLable.text = [NSString stringWithFormat:@"%zd",count];
}
- (UILabel *)creatLableWithFont:(CGFloat)font color:(UIColor *)color{

    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont systemFontOfSize:font];
    lable.textColor = color;
    [self.contentView addSubview:lable];
    return lable;
}
- (void)addData{

    self.iconView.image = [UIImage imageNamed:@"chengzi"];
    self.nameLable.text = @"四五句欧迪芬那才叫饿死了都卡了我每次";
    self.pricelable.text = @"67元";
//    self.countLable.text  = @"12";
    self.rateLable.text = @"满100元包邮";
    self.count = 12;
  
}

- (void)cutBtnClick:(UIButton *)sender{
    NSLog(@"减少");
    if (self.count > 1) {
        
        self.count--;
    }
}
- (void)plusBtnClick:(UIButton *)sender{
    NSLog(@"增加");
    self.count++;
}
- (void)seletedBtnClick:(UIButton *)sender event:(id)event{
    NSLog(@"选中");
    
    if ([self.delegate respondsToSelector:@selector(seletedDidClick:event:)]) {
        [self.delegate seletedDidClick:sender event:event];
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 10;
    CGFloat upViewH = 80;
    CGFloat seleBtnW = 20;
    CGFloat lableH = 15;
    CGFloat iconViewW = upViewH - 2*marginX;
    [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, upViewH));
        make.top.equalTo(self);
        make.left.equalTo(self);
                              
    }];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(seleBtnW, seleBtnW));
        make.left.equalTo(self).offset(marginX);
        make.centerY.equalTo(self.upView);
        
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconViewW, iconViewW));
        make.top.equalTo(self).offset(marginX);
        make.left.equalTo(self.selectedBtn.mas_right).offset(marginX);
    }];
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(marginX);
        make.right.equalTo(self).offset(-marginX);
    }];
    [self.pricelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.size.mas_equalTo(CGSizeMake(upViewH, lableH));
        make.bottom.equalTo(self.iconView);
    }];
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(lableH, lableH));
        make.top.equalTo(self.pricelable);
    }];
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.plusBtn.mas_left).offset(-5);
        make.size.mas_equalTo(CGSizeMake(40, lableH));
        make.top.equalTo(self.plusBtn);
    }];
    [self.cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countLable.mas_left).offset(-5);
        make.size.equalTo(self.plusBtn);
        make.top.equalTo(self.plusBtn);
    }];
    [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upView.mas_bottom);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(width, 30));
    }];
    [self.linview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width-2*marginX, 1));
        make.left.equalTo(self).offset(marginX);
        make.top.equalTo(self.downView);
    }];
    [self.rateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.downView).with.insets(UIEdgeInsetsMake(0, marginX, 0, marginX));

    }];
}

@end
