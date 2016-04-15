//
//  PurViewCell.m
//  OTO
//
//  Created by apple on 15/12/30.
//  Copyright © 2015年 xyb100. All rights reserved.
//

#import "PurchaseViewCell.h"

@interface PurchaseViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;

@end

@implementation PurchaseViewCell
- (void)awakeFromNib{

    [super awakeFromNib];
    
}
- (void)confignData{

    self.imageView.image = [UIImage imageNamed:@"pt"];
    self.nameLable.text = @"新疆大葡萄";
    self.nowPrice.text = @"123元";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"189元"];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attributedString.length)];
    self.oldPrice.attributedText = attributedString;
 
}
@end
