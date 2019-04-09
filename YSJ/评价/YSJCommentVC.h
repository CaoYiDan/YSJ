//
//  YSJCommentVC.h
//  SmallPig
//
//  Created by xujf on 2019/4/2.
//  Copyright © 2019年 lisen. All rights reserved.
//


#import "BaseViewController.h"

@class MenuInfo;
@interface YSJCommentVC : BaseViewController
/**<##><#Name#>*/
@property(nonatomic,copy)NSString*code;

/**是否有底部控件*/
@property(nonatomic,assign)BOOL dontNeedBottom;


@property (nonatomic,strong) MenuInfo *menuInfo;
@end
