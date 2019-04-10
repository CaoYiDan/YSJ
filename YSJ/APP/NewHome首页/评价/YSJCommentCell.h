//
//  YSJCommentCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSJCommentsModel,YSJCommentFrameModel;
@interface YSJCommentCell : UITableViewCell
@property (nonatomic,strong) YSJCommentFrameModel *statusFrame;
@property (nonatomic,strong) YSJCommentsModel *statue;
@end
