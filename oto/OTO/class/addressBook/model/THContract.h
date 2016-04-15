//
//  THContract.h
//  OTO
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THContract : NSObject

@property (nonatomic, assign) NSInteger recordId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, assign) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *dateUpdated;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
- (NSString *)fullName;
@end
