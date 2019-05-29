//
//  SPChooseCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChooseCell.h"
#import "SPKungFuModel.h"
@implementation SPChooseCell
{
    UIButton *_chooseBtn;
    UILabel *_titleLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUI{
    _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 5, 40, 40)];

    [_chooseBtn addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchDown];
    [_chooseBtn  setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"] forState:0];
    [_chooseBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"] forState:UIControlStateSelected];
    [self.contentView addSubview:_chooseBtn];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 200, 40)];
    _titleLabel.font = kFontNormal;
    [self.contentView addSubview:_titleLabel];
}

-(void)choose{
    
    _chooseBtn.selected = !_chooseBtn.isSelected;
    if (_chooseBtn.isSelected) {
        self.model.flag = @"YES";
    }else{
        self.model.flag = @"NO";
    }
}

-(void)setModel:(SPKungFuModel *)model{
    _model = model;
    _titleLabel.text = model.value;

    if ([model.flag isEqualToString:@"YES"]) {
        _chooseBtn.selected = YES;
    }else{
        _chooseBtn.selected = NO;
    }
}

@end
