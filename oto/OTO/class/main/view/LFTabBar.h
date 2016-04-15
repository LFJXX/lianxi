//
//  LFTabBar.h
//  XinYongZhangZhongBao
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFTabBar;
@protocol LFTabBarDelegate <NSObject>

- (void)tabbarDidClick:(LFTabBar *)tabBar WithIndex:(int)index;

@end
@interface LFTabBar : UIView

@property (nonatomic,weak) id<LFTabBarDelegate>delegate;
@property (nonatomic,strong) NSArray *items;

@end
