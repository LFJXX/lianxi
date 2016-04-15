//
//  LFImageGridViewController.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFAlbum.h"

/// 多图选择控制器
@interface LFImageGridViewController : UICollectionViewController
/// 构造函数
///
/// @param album          相册模型
/// @param selectedAssets 选中资源数组
/// @param maxPickerCount 最大选择数量
///
/// @return 多图选择控制器
- (instancetype)initWithAlbum:(LFAlbum *)album
               selectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets
               maxPickerCount:(NSInteger)maxPickerCount;
@end
