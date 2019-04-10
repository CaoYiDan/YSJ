//
//  SPDynamicSectionView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/17.
//  Copyright © 2017年 李智帅. All rights reserved.

#import "SPHomeSifingVC.h"
#import "SPHomeSectionView.h"

@implementation SPHomeSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self sUI];
    }
    return self;
}

-(void)sUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *siftingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, SCREEN_W/2, 40)];
    [siftingBtn setImage:[UIImage imageNamed:@"sx_"] forState:0];
    [siftingBtn setTitle:@"筛选" forState:0];
    [siftingBtn addTarget:self action:@selector(sifting) forControlEvents:UIControlEventTouchDown];
    siftingBtn.titleLabel.font = font(15);
    [siftingBtn setTitleColor:[UIColor blackColor] forState:0];
    siftingBtn.imageEdgeInsets = UIEdgeInsetsMake(0,60, 0, 0);
    siftingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-40, 0, 0);
    [self addSubview:siftingBtn];
    
    //竖分割线
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor = HomeBaseColor;
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(1, 40));
        make.top.equalTo(self).offset(0);
        make.left.offset(SCREEN_W/2);
    }];
    
    UIButton *rangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2, 0, SCREEN_W/2, 40)];
    [rangeBtn setImage:[UIImage imageNamed:@"sx_"] forState:0];
    [rangeBtn setTitle:@"排序" forState:0];
    rangeBtn.titleLabel.font = font(15);
    [rangeBtn addTarget:self action:@selector(range) forControlEvents:UIControlEventTouchDown];
    rangeBtn.imageEdgeInsets = UIEdgeInsetsMake(0,60, 0, 0);
    rangeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [rangeBtn setTitleColor:[UIColor blackColor] forState:0];
    [self addSubview:rangeBtn];
    
    //底部分割线
    UIView *line1  = [[UIView alloc]init];
    line1.backgroundColor = HomeBaseColor;
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W, 0.6));
        make.bottom.equalTo(self).offset(0);
        make.left.offset(0);
    }];
}

-(void)sifting
{
    self.block(@"筛选");
}

-(void)range
{
    self.block(@"排序");
}

@end

