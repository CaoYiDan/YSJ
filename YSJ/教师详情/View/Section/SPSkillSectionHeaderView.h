//
//  SPSkillSectionHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPSkillSectionHeaderViewDelegate <NSObject>
-(void)SPSkillSectionHeaderViewDidSelectedIndex:(NSInteger)indexRow;
@end

@interface SPSkillSectionHeaderView : UIView
//技能数组
@property(nonatomic,strong)NSMutableArray *categoryArr;

/**代理*/
@property(nonatomic,weak)id <SPSkillSectionHeaderViewDelegate>  delegate;

/***/
@property(nonatomic,assign)NSInteger  selectedIndex;

-(void)setSelectedCell;
@end
