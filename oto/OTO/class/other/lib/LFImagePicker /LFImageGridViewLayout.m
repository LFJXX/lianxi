//
//  LFImageGridViewLayout.m
//  LFImagePicker
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFImageGridViewLayout.h"

/// 最小 Cell 宽高
#define LFGridCellMinWH 104

@implementation LFImageGridViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat margin = 2;
    CGFloat itemWH = [self itemWHWithCount:3 margin:margin];
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    self.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
}

- (CGFloat)itemWHWithCount:(NSInteger)count margin:(CGFloat)margin {
    
    CGFloat itemWH = 0;
    CGSize size = self.collectionView.bounds.size;
    
    do {
        itemWH = floor((size.width - (count + 1) * margin) / count);
        count++;
    } while (itemWH > LFGridCellMinWH);
    
    
    return itemWH;
}

@end
