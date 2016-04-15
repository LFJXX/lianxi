//
//  FriendsTrendsCell.m
//  OTO
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "FriendsTrendsCell.h"

@interface FriendsTrendsCell ()
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,weak) PhotosView *picView;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,weak) UIButton *chatBtn;
@property (nonatomic,weak) UIButton *locaBtn;
@property (nonatomic,strong) UILabel *resourceLable;
@property (nonatomic,weak) ShareView *shareView;
@property (nonatomic,weak) CommentView *commentView;

@end
@implementation FriendsTrendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setTrendsFrame:(FriendTrendsFrame *)trendsFrame{
    _trendsFrame = trendsFrame;
    self.picView.trendsFrame = trendsFrame;
    self.picView.frame = trendsFrame.pickViewF;
    
    
    self.shareView.trendsFrame = trendsFrame;
    self.shareView.frame = trendsFrame.shareViewF;
    
    self.commentView.trendsFrame = trendsFrame;
    self.commentView.frame = trendsFrame.commentViewF;
    
    self.iconView.frame = trendsFrame.iconViewF;
    self.nameLable.frame = trendsFrame.nameLableF;
    self.contentLable.frame = trendsFrame.contentLableF;
    self.locaBtn.frame = trendsFrame.locaBtnF;
    self.resourceLable.frame = trendsFrame.resViewF;
    self.timeLable.frame = trendsFrame.timeLableF;
    self.chatBtn.frame = trendsFrame.chatBtnF;
    [self addData];
}

- (void)addData{

    FriendSTrends *trend = self.trendsFrame.trends;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:trend.imageUrl]];
    self.nameLable.text = trend.name;
    self.contentLable.text = trend.content;
    [self.locaBtn setTitle:trend.location forState:UIControlStateNormal];
    self.resourceLable.text = trend.sourse;
    self.timeLable.text = trend.time;
    
}
- (void)setUpUI{

    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.contentView addSubview:iconView];
    
    self.nameLable = [self creatLableWithColor:[UIColor blueColor] font:16];
//    self.nameLable.backgroundColor = [UIColor redColor];
    self.contentLable = [self creatLableWithColor:[UIColor blackColor] font:15];
    self.contentLable.numberOfLines = 0;
    
    ShareView *shareView = [[ShareView alloc] init];
    self.shareView = shareView;
    [self.contentView addSubview:shareView];
    
    PhotosView *picView = [[PhotosView alloc] init];
    self.picView = picView;
    [self.contentView addSubview:picView];
    
    self.timeLable = [self creatLableWithColor:[UIColor grayColor] font:13];
    
    self.resourceLable = [self creatLableWithColor:[UIColor grayColor] font:13];

    UIButton *locaBtn = [[UIButton alloc] init];
    self.locaBtn = locaBtn;
    
    [locaBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [locaBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [locaBtn addTarget:self action:@selector(locaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:locaBtn];
    
    UIButton *chatBtn = [[UIButton alloc] init];
    self.chatBtn = chatBtn;
    [self.chatBtn setImage:[UIImage imageNamed:@"icon_message_review"] forState:UIControlStateNormal];
     [chatBtn addTarget:self action:@selector(chatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chatBtn];
    
    CommentView *commentV = [[CommentView alloc] init];
    self.commentView = commentV;
    [self.contentView addSubview:commentV];
}

- (UILabel *)creatLableWithColor:(UIColor *)color font:(NSInteger)font{
    UILabel *lable = [[UILabel alloc] init];
    lable.textColor = color;
    lable.font = [UIFont systemFontOfSize:font];
    [self.contentView addSubview:lable];
    return lable;

}


- (void)locaBtnClick:(UIButton *)sender{

}
- (void)chatBtnClick:(UIButton *)sender{

}
@end
