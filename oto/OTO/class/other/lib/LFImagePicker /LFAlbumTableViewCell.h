//
//  LFAlbumTableViewCell.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFAlbum;

/// 相册列表单元格
@interface LFAlbumTableViewCell : UITableViewCell
/// 相册模型
@property (nonatomic) LFAlbum *album;
@end
