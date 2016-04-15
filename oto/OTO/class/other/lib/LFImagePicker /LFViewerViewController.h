//
//  LFViewerViewController.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

@interface LFViewerViewController : UIViewController
/// 图像索引
@property (nonatomic) NSUInteger index;
/// 图像资源
@property (nonatomic) PHAsset *asset;
@end
