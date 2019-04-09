//
//  SPLucCommentModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPPublishModel;
@interface SPLucCommentModel : NSObject
/**<##>评论数组*/
@property (nonatomic, strong)NSMutableArray *commentListVOList;
/**<##>评论Frame数组*/
@property (nonatomic, strong)NSMutableArray *commentListVOFrameList;

/**总共技能评价*/
@property(nonatomic,assign)NSInteger  totalCommentNum;

/**技能描述*/
@property(nonatomic,strong)SPPublishModel *lucrativetDto;

@end
