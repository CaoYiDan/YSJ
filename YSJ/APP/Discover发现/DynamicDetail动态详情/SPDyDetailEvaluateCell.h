//
//  SPDyDetailEvaluateCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SPCommentModel;

static NSString *SPDyDetailEvaluateCellID = @"SPDyDetailEvaluateCellID";

@interface SPDyDetailEvaluateCell : UICollectionViewCell
/**模型*/
@property (nonatomic, strong)SPCommentModel *model;

/**<##><#Name#>*/
@property (nonatomic, strong)NSDictionary *dict;

-(void)setDic:(NSDictionary *)dict andHeight:(CGFloat)h;
@end
