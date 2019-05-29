//
//  YSJCommentBaseVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/8.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "VTMagic.h"
@class FFDifferentWidthTagModel;
@interface YSJCommentBaseVC : VTMagicController

@property (nonatomic,copy) NSString *code;

@property (nonatomic,strong) NSDictionary *evaluateDic;

@property (nonatomic,assign) int  type;

@property (nonatomic,strong)  FFDifferentWidthTagModel*commentModel;

@end
