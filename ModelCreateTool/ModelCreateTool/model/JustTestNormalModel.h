//
//  JustTestNormalModel.h
//  MoelToolDemo
//
//  Created by haozp on 2018/8/16.
//  Copyright © 2018年 haozp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeedictModel : NSObject
@property (strong,nonatomic) NSString *year;
@property (strong,nonatomic) NSString *name;
@end

@interface OwnerModel : NSObject
@property (strong,nonatomic) NSNumber *old;
@property (assign,nonatomic) BOOL isChinese;
@property (strong,nonatomic) NSString *name;
@end

@interface CararryModel : NSObject
@property (strong,nonatomic) NSDate *time;
@property (strong,nonatomic) NSString *carName;
@property (assign,nonatomic) BOOL isNew;
@property (assign,nonatomic) NSData *age;
@property (strong,nonatomic) OwnerModel *owner;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSNumber *id;
@end

@interface JustTestNormalModel : NSObject
@property (strong,nonatomic) NSArray <CararryModel *> *carArry;
@property (strong,nonatomic) NSString *promin;
@property (strong,nonatomic) TeedictModel *teeDict;
@property (strong,nonatomic) NSString *conrry;
@end

