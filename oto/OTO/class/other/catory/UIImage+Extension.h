//
//  UIImage+Extension.h
//  weibo
//
//  Created by 厉芳 on 15/7/1.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  处理图片后缀
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  处理图片拉伸
 *
 *  @param name name description
 *
 *  @return <#return value description#>
 */
+ (UIImage *)resizedImage:(NSString *)name;

@end
