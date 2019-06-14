//
//  YSJCommentCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSJCommentsModel,YSJCommentFrameModel,YSJOrderModel;
@interface YSJCommentCell : UITableViewCell
@property (nonatomic,strong) YSJCommentFrameModel *statusFrame;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) YSJCommentsModel *statue;

@property (nonatomic,strong) YSJOrderModel *orderModel;

@end
