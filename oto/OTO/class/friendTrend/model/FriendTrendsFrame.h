//
//  FriendTrendsFrame.h
//  OTO
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendTrendsFrame : NSObject
@property (nonatomic,strong) FriendSTrends *trends;

@property (nonatomic,assign) CGRect iconViewF;
@property (nonatomic,assign) CGRect nameLableF;
@property (nonatomic,assign) CGRect contentLableF;
@property (nonatomic,assign) CGRect shareViewF;
@property (nonatomic,assign) CGRect pickViewF;
@property (nonatomic,assign) CGRect locaBtnF;
@property (nonatomic,assign) CGRect resViewF;
@property (nonatomic,assign) CGRect timeLableF;
@property (nonatomic,assign) CGRect chatBtnF;
@property (nonatomic,assign) CGRect faviousViewF;
@property (nonatomic,assign) CGRect reviewViewF;
@property (nonatomic,assign) CGRect commentViewF;
@property (nonatomic,assign) CGRect shareIconViewF;
@property (nonatomic,assign) CGRect shareContentLableF;

@property (nonatomic,assign) CGFloat rowHeight;



@end
