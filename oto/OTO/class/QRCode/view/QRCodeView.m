//
//  QRCodeView.m
//  OTO
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "QRCodeView.h"
#import "QRCodeGenerator.h"
@interface QRCodeView ()
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *nameLable;
@property (nonatomic,weak) UIImageView *sexview;
@property (nonatomic,weak) UILabel *locaLable;
@property (nonatomic,weak) UIImageView *qrcodeView;
@property (nonatomic,weak) UILabel *tiplable;

@end
@implementation QRCodeView
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUp];
    }
    return self;
}

- (void)setUp{

    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    self.iconView.layer.cornerRadius = 5;
    self.iconView.layer.masksToBounds = YES;
    [self addSubview:iconView];
    
    UILabel *nameLable = [[UILabel alloc] init];
    self.nameLable = nameLable;
    nameLable.font = [UIFont systemFontOfSize:16];

    [self addSubview:nameLable];
    
    UIImageView *sexview = [[UIImageView alloc] init];
    self.sexview = sexview;
    [self addSubview:sexview];
    
    UILabel *locaLable = [[UILabel alloc] init];
    self.locaLable = locaLable;
    locaLable.font = [UIFont systemFontOfSize:14];
    locaLable.textColor = [UIColor lightGrayColor];
    [self addSubview:locaLable];
    
    UIImageView *qrcodeView = [[UIImageView alloc] init];
    self.qrcodeView = qrcodeView;
    [self addSubview:qrcodeView];
    
    UILabel *tiplable = [[UILabel alloc] init];
    tiplable.text = @"用欣来宝扫描二维码,加我好友";
    tiplable.textAlignment = NSTextAlignmentCenter;
    tiplable.font = [UIFont systemFontOfSize:13];
    tiplable.textColor = [UIColor lightGrayColor];
    self.tiplable = tiplable;
    [self addSubview:tiplable];
}
- (void)setUser:(User *)user{

    _user = user;
    self.nameLable.text = user.name;
    self.locaLable.text = user.location;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.iconUrl]];
    self.qrcodeView.image = [QRCodeGenerator qrImageForString:user.qrUrl imageSize:self.width - 60];
    if (user.sex == 0) {
        NSLog(@"男");
        self.sexview.image = [UIImage imageNamed:@"Contact_Male"];
    }else{
    
        NSLog(@"女");
        self.sexview.image = [UIImage imageNamed:@"Contact_Female"];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat iconViewWH = 50;
    CGFloat lableH = 20;
    self.iconView.frame = CGRectMake(marginX, marginY, iconViewWH, iconViewWH);
    CGSize nameSize = [self.nameLable.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.nameLable.font} context:nil].size;
    self.nameLable.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+marginX, marginY, nameSize.width, lableH);
    self.sexview.frame = CGRectMake(CGRectGetMaxX(self.nameLable.frame)+marginX, marginY, lableH, lableH);
    self.locaLable.frame = CGRectMake(self.nameLable.x,CGRectGetMaxY(self.nameLable.frame)+marginY, self.width, lableH);
    CGFloat qrcodeX = 30;
    CGFloat qrcodeWH = self.width - 2*qrcodeX;
    CGFloat qrcodeY = (self.height - qrcodeWH)*0.5;
    self.qrcodeView.frame = CGRectMake(qrcodeX, qrcodeY, qrcodeWH, qrcodeWH);
    self.tiplable.frame = CGRectMake(0, self.height - 2*lableH, self.width, lableH);
}

@end
