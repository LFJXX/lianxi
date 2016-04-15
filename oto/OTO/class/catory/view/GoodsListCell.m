//
//  GoodsListCell.m
//  OTO
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "GoodsListCell.h"

@interface GoodsListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *coverLable;
@property (weak, nonatomic) IBOutlet UILabel *commendLable;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;


@end
@implementation GoodsListCell

- (void)awakeFromNib {
    // Initialization code
    UIButton *btn = self.buyButton;
    [btn addTarget:self action:@selector(buyButtonClick:event:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)confignData{

    self.iconView.image = [UIImage imageNamed:@"chengzi"];
    self.nameLable.text = @"赣南脐橙4个";
    self.coverLable.text = @"新鲜实惠,好吃不贵,你的放心选择";
    self.commendLable.text = @"五星";
    self.buyCountLable.text = @"103人已购买";
    self.priceLable.text = @"9元";
}

- (void)buyButtonClick:(UIButton *)sender event:(id)event{

    if ([self.delegate respondsToSelector:@selector(buyButtonClick:event:)]) {
        [self.delegate buyButtonClick:self.buyButton event:event];
    }
    NSLog(@"被点击啦");
    
}
@end
