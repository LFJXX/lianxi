//
//  LFImageGridCell.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFImageSelectButton.h"

@protocol LFImageGridCellDelegate;

/// 多图选择视图 Cell
@interface LFImageGridCell : UICollectionViewCell
@property (nonatomic, weak) id<LFImageGridCellDelegate> delegate;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) LFImageSelectButton *selectedButton;
@end

@protocol LFImageGridCellDelegate <NSObject>
/// 图像 Cell 选中事件
///
/// @param cell     图像 cell
/// @param selected 是否选中
- (void)imageGridCell:(LFImageGridCell *)cell didSelected:(BOOL)selected;
@end