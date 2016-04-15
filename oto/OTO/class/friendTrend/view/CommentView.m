//
//  CommentView.m
//  OTO
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "CommentView.h"
#import "FaviousView.h"
#import "ReviewView.h"

@interface CommentView ()
@property (nonatomic,strong) FaviousView *faviousView;
@property (nonatomic,strong) ReviewView *reviewView;
@end
@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
      
//        self.backgroundColor = [UIColor greenColor];
        [self setUI];
    }
    return self;
}
- (void)setTrendsFrame:(FriendTrendsFrame *)trendsFrame{

    _trendsFrame = trendsFrame;
    self.faviousView.trends = trendsFrame.trends;
    self.faviousView.frame = trendsFrame.faviousViewF;
    
    self.reviewView.trends = trendsFrame.trends;
    self.reviewView.frame = trendsFrame.reviewViewF;
}

- (void)setUI{

    self.faviousView = [[FaviousView alloc] init];
    [self addSubview:self.faviousView];
    
    self.reviewView = [[ReviewView alloc] init];
    [self addSubview:self.reviewView];
    
    
}
@end
