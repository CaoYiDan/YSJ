//
//  YSJCommentVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/2.
//  Copyright © 2019年 lisen. All rights reserved.
//


#import "BaseViewController.h"

@class MenuInfo,FFDifferentWidthTagModel;
@interface YSJCommentVC : BaseViewController
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*code;

/**是否有底部控件*/
@property(nonatomic,assign)BOOL dontNeedBottom;
@property (nonatomic,strong)  FFDifferentWidthTagModel*commentModel;
// 0:机构 教师 评价, 1:课程评价
@property (nonatomic,assign) int  type;

@property (nonatomic,strong) MenuInfo *menuInfo;
@end
