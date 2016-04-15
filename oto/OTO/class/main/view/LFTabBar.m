//
//  LFTabBar.m
//  XinYongZhangZhongBao
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//

#import "LFTabBar.h"
#import "FdButton.h"

@interface LFTabBar ()

@property (nonatomic,weak) UIButton *selectedBtn;

@end

@implementation LFTabBar

- (void)setItems:(NSArray *)items{
    _items = items;
    for (UIView *children in self.subviews) {
        [children removeFromSuperview];
    }
    for (UITabBarItem *item in _items) {
        FdButton *btn = [FdButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setImage:item.selectedImage forState:UIControlStateSelected];
        [btn setTitle:item.title forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:108/255.0 green:174/255.0 blue:284/255.0 alpha:1.0] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = self.subviews.count;
        [self addSubview:btn];
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
    }
    
}

- (void)btnClick:(UIButton *)sender{

    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    if ([self.delegate respondsToSelector:@selector(tabbarDidClick: WithIndex:)]) {
    
        [self.delegate tabbarDidClick:self WithIndex:(int)sender.tag];
    }
}

- (void)layoutSubviews{

    [super layoutSubviews];
    for (int i = 0; i<self.subviews.count; i++) {
        FdButton *btn = self.subviews[i];
        int count = (int)self.subviews.count;
        CGFloat W = self.width/count;
        CGFloat X = i*W;
        btn.frame = CGRectMake(X, 0,W , self.height);
    }
    
}

@end
