//
//  PhotoView.m
//  OTO
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "PhotoView.h"

@interface PhotoView ()
@property (nonatomic, weak) UIImageView *gifV;
@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置imageV内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪:把超出控件的部分裁剪
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        // 添加gif
        UIImageView *gifV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:gifV];
        _gifV = gifV;
    }
    return self;
}

- (void)setPhoto:(Photo *)photo{

    _photo = photo;
    
    // .gif
    NSString *urlStr = photo.imageUrl;
    if ([urlStr hasSuffix:@".gif"]) {
        _gifV.hidden = NO;
    }else{
        _gifV.hidden = YES;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:photo.imageUrl]];
//    [self sd_setImageWithURL:[NSURL URLWithString:photo.imageUrl] placeholderImage:[UIImage imageNamed:@"icon-avatar-60x60"]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _gifV.x = self.width - _gifV.width;
    _gifV.y = self.height - _gifV.height;
}
@end
