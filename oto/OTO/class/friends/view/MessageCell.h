//
//  messageCell.h
//  OTO
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *ContentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
