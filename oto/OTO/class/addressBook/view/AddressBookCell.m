//
//  AddressBookCell.m
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "AddressBookCell.h"

@interface AddressBookCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *seletedView;
@end
@implementation AddressBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContact:(THContract *)contact{

    _contact = contact;
    self.iconView.image = contact.image;
    self.nameLable.text = contact.fullName;
    self.seletedView.image = contact.selected?[UIImage imageNamed:@"icon-checkbox-selected-green-25x25"]:[UIImage imageNamed:@"icon-checkbox-unselected-25x25"];
    
}

@end
