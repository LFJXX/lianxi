//
//  LFTextView.m
//  OTO
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFTextView.h"

@interface LFTextView ()
@property (nonatomic,weak)UILabel *placehoderLabel;
@end
@implementation LFTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor clearColor];
        //textview 上 加 label
        UILabel *placehoderLabel=[[UILabel alloc]init];
        placehoderLabel.backgroundColor =[UIColor clearColor];
        placehoderLabel.numberOfLines = 0;
        [self addSubview:placehoderLabel];
        self.placehoderLabel=placehoderLabel;
        
        self.placehoderColor =[UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:15];
        //添加通知 self textView有输入内容时隐藏label
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}
#pragma mark 通知  的销毁 以及事件
- (void)textDidChange
{
    //    self.placehoderLabel.hidden = (self.text.length != 0);
    if(self.text.length > 0){
        self.placehoderLabel.hidden = YES;
    }else{
        self.placehoderLabel.hidden = NO;
    }
}
/**
 *  从通知中心移除
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


/**
 *  给添加新的控件的时候  添加后不显示的话,则是缺少布局的设置
 *   设置frame则在layoutsubviews中进行
 */
- (void)layoutSubviews
{
    /**
     *  重写父类的方法不可缺失
     */
    [super layoutSubviews];
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
    self.placehoderLabel.width = self.width- 2 * self.placehoderLabel.x;
    /**
     *  对于高度依据输入的内容而定
     */
    CGSize size= CGSizeMake(self.placehoderLabel.width, MAXFLOAT);
    self.placehoderLabel.height = [self.placehoder boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placehoderLabel.font} context:nil].size.height;
    
   
    
}

#pragma matk 重写set方法
- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
    self.placehoderLabel.textColor = [UIColor lightGrayColor];
    [self setNeedsDisplay];
}

- (void)setPlacehoderColor:(UIColor *)placehoderColor
{
    _placehoderColor = placehoderColor;
    self.placehoderLabel.textColor = placehoderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placehoderLabel.font=font;
    
    //重新布局
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}


@end
