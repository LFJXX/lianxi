//
//  PersonTrendCell.m
//  OTO
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "PersonTrendCell.h"

@interface PersonTrendCell ()

@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,strong) UILabel *counltLable;


@end

@implementation PersonTrendCell

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       
        [self creatUI];
    }
    return self;
}
- (void)creatUI{

    
}

@end
