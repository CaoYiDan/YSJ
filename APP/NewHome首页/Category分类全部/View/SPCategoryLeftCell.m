//
//  SPCategoryLeftCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCategoryLeftCell.h"
#import "SPKungFuModel.h"
@implementation SPCategoryLeftCell
{
    UIView *_leftLine;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self sUI];
    }
    return self;
}

-(void)sUI{
    _leftLine = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 4, 40)];
    _leftLine.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_leftLine];
    
    self.textLabel.font = font(14);
}

-(void)setModel:(SPKungFuModel *)model{
    _model = model;
    self.textLabel.text = model.value;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    _leftLine.backgroundColor  = selected?MyBlueColor : [UIColor whiteColor];
    self.textLabel.textColor = selected?MyBlueColor:[UIColor blackColor];
    self.backgroundColor = selected?CategoryBaseColor:[UIColor whiteColor];
}

@end
