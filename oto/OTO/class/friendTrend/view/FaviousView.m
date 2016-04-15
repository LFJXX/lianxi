//
//  FaviousView.m
//  OTO
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "FaviousView.h"
#import "TQRichTextView.h"
#import "Favious.h"
#import "YYText.h"
@interface FaviousView ()<TQRichTextViewDelegate>
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) YYLabel *textLable;
@property (nonatomic,strong) NSString *faviouString;
@property (nonatomic,strong) NSMutableArray *faviousArray;
@end

@implementation FaviousView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setUI];
        self.backgroundColor = LFLightGrayColor;
    }
    return self;
}

- (void)setTrends:(FriendSTrends *)trends{
    _trends = trends;
    NSMutableAttributedString *arrr = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i< trends.favious.count; i++) {
        Favious *f = trends.favious[i];
        NSString *text = f.name;

        [self setAttributedString:arrr text:text];

        [self.faviousArray addObject:f.name];
    }
    [arrr deleteCharactersInRange:NSMakeRange(arrr.length-2, 2)];
    self.faviouString = [self.faviousArray componentsJoinedByString:@", "];
    self.textLable.attributedText = arrr ;
    
    
}

- (void)setAttributedString:(NSMutableAttributedString *)mutStr text:(NSString *)text{
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:text];
    one.yy_font = [UIFont boldSystemFontOfSize:13];
    one.yy_color = LFLightBlueColor;
    YYTextBorder *border = [YYTextBorder new];
    border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
    border.strokeWidth = 0.5;
    border.strokeColor = [UIColor clearColor];
    border.lineStyle = YYTextLineStyleSingle;
    one.yy_textBackgroundBorder = border;
    
    YYTextBorder *highlightBorder = [YYTextBorder new];
    border.insets = UIEdgeInsetsMake(0, -10, 0, -10);
    highlightBorder.strokeWidth = 0;
    highlightBorder.strokeColor = [UIColor lightGrayColor];
    highlightBorder.fillColor = [UIColor lightGrayColor];


    
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];

    [highlight setBackgroundBorder:highlightBorder];
    [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
    
    [mutStr appendAttributedString:one];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@", "];
    
    [att addAttributes:@{NSForegroundColorAttributeName:LFLightBlueColor} range:NSMakeRange(0, att.length)];
    [mutStr appendAttributedString:att];

}
- (void)setUI{
    self.iconView = [[UIImageView alloc] init];
    [self addSubview:self.iconView];
    self.iconView.image = [UIImage imageNamed:@"20000132"];
   
    self.textLable = [[YYLabel alloc] init];
    self.textLable.numberOfLines = 1;
    self.textLable.font = [UIFont systemFontOfSize:13.0f];

    [self addSubview:self.textLable];
    __weak typeof(self) _self = self;
    self.textLable.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        NSLog(@"%@",[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]);
        NSString *str = [NSString stringWithFormat:@"%@",[text.string substringWithRange:range]];

        NSInteger index = [_self.faviousArray indexOfObject:str];
        NSLog(@"===index===%zd",index);
    };

  
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat marginX = 10;
    self.iconView.frame = CGRectMake(marginX, (self.height - marginX)/2, marginX, marginX);
  
    CGSize size = [self.faviouString boundingRectWithSize:CGSizeMake(self.width - CGRectGetMaxX(self.iconView.frame) - 1.5*marginX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:LFLightBlueColor} context:nil].size;
    self.textLable.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+marginX/2, 0, size.width, size.height);
    
}

- (NSMutableArray *)faviousArray{

    if (_faviousArray == nil) {
        _faviousArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _faviousArray;
}

@end
