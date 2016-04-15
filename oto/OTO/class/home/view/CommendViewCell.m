//
//  CommendViewCell.m
//  OTO
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "CommendViewCell.h"

@interface CommendViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *nowCount;
@property (weak, nonatomic) IBOutlet UILabel *pastCount;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation CommendViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)confignData{

    self.iconView.image = [UIImage imageNamed:@"xia"];
    self.nameLable.text = @"山东大龙虾";
    self.priceLable.text = @"78元/只 (每人限购3只)";
    self.nowCount.text = @"剩余:13只";
    self.pastCount.text = @"已售:108只";
}

@end
