//
//  SPPayTypeCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPPayTypeCellTapDelegate <NSObject>
-(void)SPPayTypeCellSelectedIndex:(NSIndexPath*)selectedIndexPath;
@end
static NSString *SPPayTypeCellID = @"SPPayTypeCellID";

@interface SPPayTypeCell : UICollectionViewCell
/***/
@property(nonatomic,strong)NSIndexPath *indexPath;
/**<##>代理*/
@property(nonatomic,weak) id<SPPayTypeCellTapDelegate> delegate;

-(void)setCellSelected:(BOOL)selectedCell;


@end
