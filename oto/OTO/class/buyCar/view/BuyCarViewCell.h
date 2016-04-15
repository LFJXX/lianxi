//
//  BuyCarViewCell.h
//  OTO
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyCarViewCell;
@protocol BuyCarViewDelegate <NSObject>

- (void)seletedDidClick:(UIButton *)sender event:(id)event;

@end
@interface BuyCarViewCell : UITableViewCell
@property (nonatomic,weak) UIView        *upView;
@property (nonatomic,weak) UIButton      *selectedBtn;
@property (nonatomic,weak) UIImageView   *iconView;
@property (nonatomic,strong) UILabel       *nameLable;
@property (nonatomic,strong) UILabel       *pricelable;
@property (nonatomic,weak) UIButton      *cutBtn;
@property (nonatomic,weak) UIButton      *plusBtn;
@property (nonatomic,strong) UILabel       *countLable;
@property (nonatomic,weak) UIView        *downView;
@property (nonatomic,weak) UIView        *linview;
@property (nonatomic,strong) UILabel       *rateLable; // 优惠
@property (nonatomic,assign) NSInteger   count;

@property (nonatomic,weak) id<BuyCarViewDelegate>delegate;
- (void)addData;
@end
