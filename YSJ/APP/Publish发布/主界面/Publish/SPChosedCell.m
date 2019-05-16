//
//  SPChosedCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChosedCell.h"

@implementation SPChosedCell
{
    UIImageView*_rightImg;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    SPChosedCell *cell = [tableView dequeueReusableCellWithIdentifier:SPChosedCellID];
    if (cell==nil) {
        cell = [[SPChosedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPChosedCellID];
        
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font= kFontNormal_14;
        // 初始化原创UI
        [self uI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)uI{
    _rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-35,8, 25, 25)];
    [_rightImg setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"]];
    [self.contentView addSubview:_rightImg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//
    if (selected) {
         [_rightImg setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"]];
    }else{
         [_rightImg setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"]];
    }
    
    // Configure the view for the selected state
}

-(void)setSelected{
     [_rightImg setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"]];
}
@end
