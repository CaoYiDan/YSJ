//
//  YSJCommentCell.h
//  SmallPig
//
//  Created by xujf on 2019/3/26.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSJOrderModel,YSJHomeWorkFrameModel;

@interface YSJHomeWorkCell : UITableViewCell

@property (nonatomic,strong) YSJHomeWorkFrameModel *statusFrame;

@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) YSJOrderModel *statue;

@end
