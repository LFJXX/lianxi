//
//  FriendSTrendModel.h
//  OTO
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "Comments.h"
@interface FriendSTrends : NSObject
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,strong) FriendSTrends *trend;
@property (nonatomic,copy) NSString *sourse;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,strong) NSArray *picArray;
@property (nonatomic,strong) NSArray *favious;
@property (nonatomic,strong) NSArray *comments;


@end
