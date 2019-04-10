//
//  SPThirdLevelCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const SPThirdLevelCellID = @"SPThirdLevelCellID";

@interface SPThirdLevelCell : UICollectionViewCell
/**<##>字体背景颜色*/
@property (nonatomic, strong) UIColor *baseColor;
/**行号*/
@property(nonatomic,assign)NSInteger  indexRow;

-(void)setText:(NSString *)text;

@end
