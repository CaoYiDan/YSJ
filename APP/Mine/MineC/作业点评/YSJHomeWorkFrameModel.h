//
//  YSJCommentFrameModel.h
//  SmallPig
//
//  Created by xujf on 2019/3/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSJCommentsModel;

@interface YSJHomeWorkFrameModel : NSObject

/**<##>模型*/
@property (nonatomic, strong) YSJCommentsModel *status;

/** 上部分View */
@property (nonatomic, assign) CGRect topViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;

/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 标签图标 */
@property (nonatomic, assign) CGRect tagImgF;

/** 标签 */
@property (nonatomic, assign) CGRect tagLabelF;

/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;

/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;

/** 时间 */
@property (nonatomic, assign) CGRect timeF;

/**评分*/
@property (nonatomic, assign) CGRect starF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
