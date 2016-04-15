//
//  LFImagePickerController.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@protocol LFImagePickerControllerDelegate;

/// 图像选择控制器
@interface LFImagePickerController : UINavigationController
/// 构造函数
///
/// @param selectedAssets 选中素材数组，可以用于预览之前选中的照片集合
///
/// @return 图像选择控制器
- (_Nonnull instancetype)initWithSelectedAssets:(NSArray <PHAsset *> * _Nullable)selectedAssets;
/// 图像选择代理
@property (nonatomic, weak, nullable) id<LFImagePickerControllerDelegate> pickerDelegate;
/// 加载图像尺寸(以像素为单位，默认大小 600 * 600)
@property (nonatomic) CGSize targetSize;
/// 最大选择图像数量，默认 9 张
@property (nonatomic) NSInteger maxPickerCount;
@end

/// 图像选择控制器协议
@protocol LFImagePickerControllerDelegate <NSObject>
@optional
/// 图像选择完成代理方法
///
/// @param picker         图像选择控制器
/// @param images         用户选中图像数组
/// @param selectedAssets 选中素材数组，方便重新定位图像
- (void)imagePickerController:(LFImagePickerController * _Nonnull)picker
      didFinishSelectedImages:(NSArray <UIImage *> * _Nonnull)images
               selectedAssets:(NSArray <PHAsset *> * _Nullable)selectedAssets;
@end