//
//  shareView.m
//  OTO
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "ShareView.h"


@interface ShareView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@end
@implementation ShareView

- (void)awakeFromNib{

    [super awakeFromNib];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
       
        [self setUp];
        self.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9529 alpha:1.0];
    }
    return self;
}

- (void)setUp{
    UIImageView *iconv = [[UIImageView alloc] init];
    self.iconView = iconv;
    [self addSubview:iconv];
    
    UILabel *contentL = [[UILabel alloc] init];
    self.contentLable = contentL;
    contentL.font = [UIFont systemFontOfSize:14];
    contentL.numberOfLines = 2;
    [self addSubview:contentL];
}
- (void)setTrendsFrame:(FriendTrendsFrame *)trendsFrame{
    _trendsFrame = trendsFrame;
    
    self.iconView.frame = trendsFrame.shareIconViewF;
    self.contentLable.frame = trendsFrame.shareContentLableF;

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_trendsFrame.trends.trend.imageUrl]placeholderImage:[UIImage imageNamed:@"icon-avatar-60x60"]];
    self.contentLable.text = _trendsFrame.trends.trend.content;

    
}
//+ (instancetype)creatWithXib{
//
//    return [[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:nil options:nil].lastObject;
//}

@end
