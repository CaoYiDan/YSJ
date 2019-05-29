//
//  SPsiftingCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPsiftingCell.h"

@implementation SPsiftingCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.detailLabel = [[UILabel alloc]init];
    self.detailLabel.font = font(14);
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.detailLabel];
    self.detailLabel.textColor = MyBlueColor;
    self.detailLabel.numberOfLines  = 0;
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(10);
        make.right.offset(-30);
        make.height.equalTo(self);
        make.top.offset(0);
    }];
}
@end
