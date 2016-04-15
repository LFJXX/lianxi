//
//  RushViewCell.m
//  OTO
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "RushViewCell.h"

@interface RushViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *olePrice;
@property (weak, nonatomic) IBOutlet UILabel *soldOutCount;
@property (weak, nonatomic) IBOutlet UIProgressView *soldProgress;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;

@end
@implementation RushViewCell

- (void)awakeFromNib {
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

- (void)configData{

    self.iconView.image = [UIImage imageNamed:@"juzi"];
    self.nameLable.text = @"江南橘子10个 富含维生素C与柠檬酸 美容养颜 消除疲劳";
    self.nowPrice.text = @"8";
    
    self.soldOutCount.text = @"已售70份";
    self.soldProgress.progress = 0.70;
    self.purchaseBtn.enabled = YES;
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc] initWithString:@"15"];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attributedString.length)];
    self.olePrice.attributedText = attributedString;
}

@end
