//
//  UIImage+Extension.m
//  weibo
//
//  Created by 厉芳 on 15/7/1.
//  Copyright (c) 2015年 lf. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name
{
    UIImage *image=nil;

    
    if (image ==nil) {
        image=[UIImage imageNamed:name];
    }

    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    UIImage *image=[UIImage imageNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
//    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 50) resizingMode:UIImageResizingModeTile];
}
@end
