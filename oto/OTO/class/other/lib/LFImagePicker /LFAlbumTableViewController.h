//
//  LFAlbumTableViewController.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

/// 相册列表控制器
@interface LFAlbumTableViewController : UITableViewController
/// 构造函数
///
/// @param selectedAssets 选中素材数组
///
/// @return 相册列表控制器
- (_Nonnull instancetype)initWithSelectedAssets:(NSMutableArray <PHAsset *> * _Nullable)selectedAssets;
/// 最大选择图像数量，默认 9 张
@property (nonatomic) NSInteger maxPickerCount;
@end
