//
//  SPHomeFrame.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  SPDynamicModel;

@interface SPProfileDynamicFrame : NSObject
/**<##>模型*/
@property (nonatomic, strong) SPDynamicModel *status;

/** 上部分View */
@property (nonatomic, assign) CGRect topViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeAndAreaLabelF;
/** 发布地点 */
@property (nonatomic, assign) CGRect areaLabelF;
/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
