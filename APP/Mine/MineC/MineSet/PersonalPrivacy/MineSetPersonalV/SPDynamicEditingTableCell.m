//
//  SPDynamicEditingTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicEditingTableCell.h"

@implementation SPDynamicEditingTableCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    
    
    
}

- (void)initWithModel:(HomeModel *)model AndCount:(NSInteger)number{
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    //头像
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 40, 40)];
    
    //self.headIV.layer.cornerRadius = 10;
    //self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    self.nickLab = [[UILabel alloc]initWithFrame:CGRectMake(50, self.contentView.centerY-15, self.contentView.frame.size.width-60,30)];
    
    self.nickLab.textColor = [UIColor blackColor];
    self.nickLab.textAlignment = NSTextAlignmentLeft;
    
    self.nickLab.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview: self.nickLab];
    
    NSLog(@"%@%@",model.avatar,model.nickName);
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"imagePlaceHold"]];
        self.nickLab.text = model.nickName;
    
}


@end
