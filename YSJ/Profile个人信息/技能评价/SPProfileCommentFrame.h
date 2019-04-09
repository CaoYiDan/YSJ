//
//  LGEvaluateStatusFrame.h
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//
//  一个LGEvaluateStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus
#import "SPProfileCommentFrame.h"

// 昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
//#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
//#define HWStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14]


//#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell之间的间距
#define HWStatusCellMargin 10

// cell的边框宽度
#define HWStatusCellBorderW 10

@class SPCommentModel;

#import <Foundation/Foundation.h>

@interface SPProfileCommentFrame : NSObject
/**<##>模型*/
@property (nonatomic, strong) SPCommentModel *status;

/** 上部分View */
@property (nonatomic, assign) CGRect topViewF;
/** 评分 */
@property (nonatomic, assign) CGRect scoreViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** 评分View*/
@property (nonatomic, assign) CGRect starF;
/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;
/** 中间View */
@property (nonatomic, assign) CGRect middleViewF;
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** cell的类型 */
//@property (nonatomic, assign) EvaluateCellType type;
@end

