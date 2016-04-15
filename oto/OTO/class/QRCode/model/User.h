//
//  User.h
//  OTO
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,copy) NSString *qrUrl;
@end
