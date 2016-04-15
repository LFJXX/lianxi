//
//  LFTabBarButton.m
//  XinYongZhangZhongBao
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//

#import "FdButton.h"

@implementation FdButton

- (void)layoutSubviews{

    [super layoutSubviews];
    CGFloat W = self.currentImage.size.width;
    CGFloat H = self.currentImage.size.height;
    CGFloat X = (self.width - W)/2;
    CGFloat Y = 0;
    self.imageView.frame = CGRectMake(X, Y, W, H);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.width, self.height - H - Y);
    

    
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
