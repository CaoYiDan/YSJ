//
//  SPKungFuModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPKungFuModel : NSObject
@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *createBy;

@property (nonatomic, assign) int delFlag;

@property (nonatomic, assign) int isRoot;

@property (nonatomic, copy) NSString *updateBy;

@property (nonatomic, assign) int createDate;

@property (nonatomic, copy) NSString *parentCode;

@property (nonatomic, copy) NSString *value;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) int leafNum;

@property (nonatomic, assign) int updateDate;

@property (nonatomic, assign) int isLeaf;

@property (nonatomic , strong) NSArray *subProperties;

@property (nonatomic , strong) NSMutableArray *thirdLevelArr;

@property(nonatomic,copy)NSString*imgUrl;

@property(nonatomic,copy)NSString*tagImg;

@property(nonatomic,copy)NSString*hobbyImg;

@property(nonatomic,copy)NSString*color;

/**flag是否展开*/
@property(nonatomic,copy)NSString*flag;
/***/
@property(nonatomic,copy)NSString*rootType;

/***/
@property(nonatomic,copy)NSString*bgColor;

/***/
@property(nonatomic,copy)NSString*fontColor;
/**是否已经选择*/
@property(nonatomic,assign)int  selected;

/**自己自定义的字段*/
@property(nonatomic,assign)BOOL chosed;


@end
