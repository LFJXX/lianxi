//
//  LFBottomView.h
//  OTO
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFBottomView;
@protocol LFBottomViewDelegate <NSObject>

- (void)seletedAllBuyCarGoods:(UIButton *)sender;

@end
@interface LFBottomView : UIView
@property (nonatomic,weak) UIButton *selectedBtn;
@property (nonatomic,weak) UIButton *accountBtn;
@property (nonatomic,weak) UIButton *deletedBtn;
@property (nonatomic,weak) UILabel  *seletedLable;
@property (nonatomic,weak) UILabel  *sumMoneyLable;
@property (nonatomic,weak) UILabel *totalMoneyLable;
@property (nonatomic,weak) UIView  *countView;
@property (nonatomic,assign,getter=isEdit) BOOL edit;

@property (nonatomic,weak) id<LFBottomViewDelegate>delegate;

- (void)changeData;
@end
