//
//  LFPopView.h
//  OTO
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LFPoPMenuArrowPositionCenter = 0,
    LFPoPMenuArrowPositionLeft = 1,
    LFPoPMenuArrowPositionRight = 2
}LFPoPMenuArrowPosition;

@class LFPopView;
@protocol LFPopViewDelegate <NSObject>

@optional
- (void)popMenuDismissed:(LFPopView *)menu;

@end

@interface LFPopView : UIView
@property (nonatomic,weak)id<LFPopViewDelegate> delegate;
@property (nonatomic,assign,getter=isDimBackground)BOOL dimBackground;

@property (nonatomic,assign)LFPoPMenuArrowPosition arrowPostion;

+ (instancetype)popMenuWithContentView:(UIView *)contentView;
- (instancetype)initWithContentView:(UIView *)contentView;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;
/**
 *  关闭菜单
 */
- (void)dismiss;

/**
 *  替换菜单图片
 *
 *  @param background
 */
- (void)setBackground:(UIImage *)background;

@end
