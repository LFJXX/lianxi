//
//  GoodsListCell.h
//  OTO
//
//  Created by apple on 16/1/5.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListCell;
@protocol GoodsListCellDelegate <NSObject>

- (void)buyButtonClick:(UIButton *)sender event:(id)event;

@end
@interface GoodsListCell : UITableViewCell
@property (nonatomic,weak) id<GoodsListCellDelegate>delegate;
- (void)confignData;
@end
