//
//  FriendTrendsFrame.m
//  OTO
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "FriendTrendsFrame.h"
#import "Comments.h"

@implementation FriendTrendsFrame

- (void)setTrends:(FriendSTrends *)trends{

    _trends = trends;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    CGFloat iconWH = 40;
    CGFloat lableH = 20;
    CGFloat shareH = 60;
    CGFloat contentW = width - 3*marginX - iconWH;
    self.iconViewF = CGRectMake(marginX, marginY, iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF)+marginX;
    self.nameLableF = CGRectMake(nameX, self.iconViewF.origin.y, width , lableH);

    CGSize ContSize = [trends.content boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.contentLableF = CGRectMake(nameX, CGRectGetMaxY(self.nameLableF)+marginX/2, ContSize.width, ContSize.height);
    
    self.shareIconViewF = CGRectMake(marginX/2,marginX/2, shareH-marginX, shareH-marginX);
    self.shareContentLableF = CGRectMake(CGRectGetMaxX(self.shareIconViewF)+marginX, marginX/2, contentW-self.shareIconViewF.size.width - 2*marginX, shareH-marginX);
    
    self.shareViewF = CGRectMake(nameX,CGRectGetMaxY(self.contentLableF)+marginX, contentW, shareH);
    
    CGFloat photosX = nameX;
    CGFloat photosY = CGRectGetMaxY(self.shareViewF)+marginX;
    if (_trends.picArray.count) {
        CGSize  photosSize = [self photosSizeWithCount:_trends.picArray.count];
        self.pickViewF = (CGRect){{photosX,photosY},photosSize};
        
    }else{
    
        self.pickViewF = (CGRect){{photosX,photosY},CGSizeZero};
    }

    CGSize locaSize = [trends.location boundingRectWithSize:CGSizeMake(contentW, lableH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.locaBtnF= CGRectMake(nameX, CGRectGetMaxY(self.pickViewF) +marginX, locaSize.width, lableH);
    
    self.timeLableF = CGRectMake(nameX, CGRectGetMaxY(self.locaBtnF)+ marginX, width, lableH);
    
    self.resViewF = CGRectMake(CGRectGetMaxX(self.timeLableF) + marginX, CGRectGetMaxY(self.locaBtnF)+ marginX, width, lableH);
    
    self.chatBtnF = CGRectMake(width - marginX-lableH, self.timeLableF.origin.y, lableH, lableH);
    
    self.faviousViewF = CGRectMake(0, 0, contentW, 30);
    CGFloat height = [self reviewSizeWithArray:_trends.comments width:contentW];
    self.reviewViewF = CGRectMake(0, CGRectGetMaxY(self.faviousViewF)+marginX, contentW, height+marginX);
    self.commentViewF = CGRectMake(nameX, CGRectGetMaxY(self.timeLableF)+marginX, contentW, height + 30 +2*marginX);
    
    self.rowHeight = CGRectGetMaxY(self.commentViewF)+10;
}

- (CGFloat)reviewSizeWithArray:(NSArray *)array width:(CGFloat)width{

    CGFloat height;
    for (int i = 0; i< array.count; i++) {
        Comments *c = array[i];
        NSString *title = [NSString stringWithFormat:@"%@ : %@",c.name,c.content];
        CGFloat h = [title boundingRectWithSize:CGSizeMake(width-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        height += h;
    }
    return height;
}

- (CGSize)photosSizeWithCount:(NSUInteger)count
{
    NSUInteger cols = (count == 4?2:3);
    NSUInteger rows = (count - 1)/cols + 1;
    CGFloat photosW = cols * 75 + (cols - 1)* 10;
    CGFloat photosH = rows *75  + (rows - 1)*10;
    return CGSizeMake(photosW, photosH);
}
@end
