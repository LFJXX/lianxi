//
//  PhotoView.m
//  OTO
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "PhotosView.h"
#import "PhotoView.h"

@implementation PhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //        self.backgroundColor = [UIColor redColor];
        
        // 添加所有的子控件
        [self setUpAllChildView];
    }
    return self;
    
}

- (void)setUpAllChildView
{
    for (int i = 0; i < 9; ++i) {
        PhotoView *imageV = [[PhotoView alloc] init];
        
        imageV.tag = self.subviews.count;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}
- (void)tap:(UITapGestureRecognizer *)tap{
}
- (void)setTrendsFrame:(FriendTrendsFrame *)trendsFrame{

    for (PhotoView *imageV in self.subviews) {
        imageV.image = nil;
    }
    _trendsFrame = trendsFrame;
    NSArray *imageArr = _trendsFrame.trends.picArray;
    NSInteger count = imageArr.count;
    for (NSInteger i = 0; i < count; ++i) {
        PhotoView *imageV = self.subviews[i];
        Photo *p = imageArr[i];
        imageV.photo = p;
        
    }


    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat photoX = 0;
    CGFloat photoY = 0;
    int col = 0;
    int row = 0;
    int count =  (int)self.trendsFrame.trends.picArray.count;
    int cols = count == 4? 2: 3;
    
    // 遍历模型数组,取出对应UIImageView,计算位置
    for (int i = 0; i < count; i++) {
        col = i % cols;
        row = i / cols;
        photoX = col * (75 + 10);
        photoY = row * (75 + 10);
        
        UIImageView *imageV = self.subviews[i];
        imageV.frame = CGRectMake(photoX, photoY, 75, 75);
    }
    
}
@end
