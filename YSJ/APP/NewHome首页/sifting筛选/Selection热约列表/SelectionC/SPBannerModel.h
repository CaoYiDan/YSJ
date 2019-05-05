//
//  SPBannerModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPBannerModel : NSObject
//@property (nonatomic, assign) int id;

@property (nonatomic, copy) NSString *updatedAt;

@property (nonatomic, assign) int clickRate;

@property (nonatomic, copy) NSString *urlAddress;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *positionCode;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) int listOrder;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *createdAt;

@property (nonatomic, copy) NSString *status;
@end
