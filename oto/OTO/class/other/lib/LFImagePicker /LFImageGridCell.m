//
//  LFImageGridCell.m
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFImageGridCell.h"

@implementation LFImageGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.selectedButton];
    }
    return self;
}

#pragma mark - 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
    
    CGFloat offsetX = self.bounds.size.width - _selectedButton.bounds.size.width;
    _selectedButton.frame = CGRectOffset(_selectedButton.bounds, offsetX, 0);
}

#pragma mark - 监听方法
- (void)clickSelectedButton {
    [self.delegate imageGridCell:self didSelected:_selectedButton.selected];
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (LFImageSelectButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [[LFImageSelectButton alloc]
                           initWithImageName:@"check_box_default"
                           selectedName:@"check_box_right"];
        [_selectedButton addTarget:self action:@selector(clickSelectedButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

@end
