//
//  LFImageSelectButton.h
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 选择图像按钮
@interface LFImageSelectButton : UIButton
- (instancetype)initWithImageName:(NSString *)imageName selectedName:(NSString *)selectedName;
@end
