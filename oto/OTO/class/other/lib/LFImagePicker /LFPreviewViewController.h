//
//  LFPreviewViewController.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFAlbum.h"

/// 照片预览控制器代理
@protocol LFPreviewViewControllerDelegate;

/// 照片预览控制器
@interface LFPreviewViewController : UIViewController
/// 构造函数
///
/// @param album          相册模型
/// @param selectedAssets 选中资源数组
/// @param maxPickerCount 最大选择数量
/// @param indexPath      预览相册的索引，如果为 nil，预览选中照片
///
/// @return 多图选择控制器
- (instancetype)initWithAlbum:(LFAlbum *)album
               selectedAssets:(NSMutableArray <PHAsset *> *)selectedAssets
               maxPickerCount:(NSInteger)maxPickerCount
                    indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) id<LFPreviewViewControllerDelegate> delegate;
@end


@protocol LFPreviewViewControllerDelegate <NSObject>

/// 预览控制器修改资源选中状态
///
/// @param previewViewController 预览控制器
/// @param asset                 资源
/// @param selected              是否选中
///
/// @return 是否允许修改
- (BOOL)previewViewController:(LFPreviewViewController *)previewViewController didChangedAsset:(PHAsset *)asset selected:(BOOL)selected;

/// 选中资源数组
///
/// @return 选中资源数组
- (NSMutableArray <PHAsset *> *)previewViewControllerSelectedAssets;

@end