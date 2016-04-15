//
//  LFPopView.m
//  OTO
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//



#import "LFPopView.h"
@interface LFPopView ()
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,weak)UIButton *cover;
@property (nonatomic,weak)UIImageView *container;
@end
@implementation LFPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加菜单内部的2个控件  遮盖+菜单menu
        UIButton *cover=[[UIButton alloc]init];
        //透明的,屏蔽点击事件
        cover.backgroundColor=[UIColor clearColor];
        
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.cover=cover;
        [self addSubview:cover];
        
        //
        UIImageView *titleMenu=[[UIImageView alloc]init];
        titleMenu.userInteractionEnabled=YES;
        titleMenu.image=[UIImage imageWithName:@"popover_background"];
//        titleMenu.backgroundColor = [UIColor grayColor];
        self.container=titleMenu;
        [self addSubview:titleMenu];
        
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self=[super init]) {
        self.contentView=contentView;
    }
    
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc]initWithContentView:contentView];
}

- (void)showInRect:(CGRect)rect;
{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    self.frame=window.bounds;
    [window addSubview:self];
    //设置容器的frame
    self.container.frame=rect;
    [self.container addSubview:self.contentView];
    
    //设置容器内部的frame
    // 设置容器里面内容的frame
    CGFloat topMargin = 13;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
  
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDismissed:)]) {
        [self.delegate popMenuDismissed:self];
    }
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

#pragma  mark
- (void)coverClick:(UIButton *)btn
{
    [self dismiss];
}

- (void)setBackground:(UIImage *)background
{
    self.container.image=background;
}

#pragma mark 重写set方法
- (void)setDimBackground:(BOOL )dimBackground
{
    _dimBackground=dimBackground;
    if (dimBackground) {
        self.cover.backgroundColor=[UIColor blackColor];
        self.cover.alpha=0.3;
    }else{
        self.cover.backgroundColor=[UIColor clearColor];
        self.cover.alpha=1.0;
    }
}

- (void)setArrowPostion:(LFPoPMenuArrowPosition)arrowPostion
{
    _arrowPostion = arrowPostion;// resizedImage
    switch (arrowPostion) {
        case LFPoPMenuArrowPositionCenter:
            self.container.image=[UIImage resizedImage:@"popover_background"];
            break;
        case LFPoPMenuArrowPositionLeft:
            self.container.image=[UIImage resizedImage:@"popover_background_left"];
            break;
        case LFPoPMenuArrowPositionRight:
            self.container.image=[UIImage resizedImage:@"popover_background_right"];
            break;
    }
}


@end
