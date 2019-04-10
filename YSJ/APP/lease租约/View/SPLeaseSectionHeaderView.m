//
//  SPLeaseSectionHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLeaseSectionHeaderView.h"

@implementation SPLeaseSectionHeaderView
{
    UIView *_sliderView;
   UIButton *_selectedButton;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = HomeBaseColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    NSArray *textArr = @[@"应邀广场",@"我的应邀",@"我的成交"];
    int i=0;
    for (NSString *str in textArr)
    {
        CGFloat btnW = SCREEN_W/2;
        UIButton *leaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*(btnW+1), 1, btnW, 39)];
        leaseBtn.tag = i;
        leaseBtn.backgroundColor = [UIColor whiteColor];
        [leaseBtn setTitle:str forState:0];
        [leaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leaseBtn setTitleColor:PrinkColor forState:UIControlStateSelected];
        leaseBtn.titleLabel.font = font(15);
        [leaseBtn addTarget:self action:@selector(leaseType:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:leaseBtn];
        i++;
    }
    
    UIView*sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, SCREEN_W/3, 2)];
    _sliderView = sliderView;
    sliderView.backgroundColor = PrinkColor;
    [self addSubview:sliderView];

    UIButton *siftingBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 41, SCREEN_W, 40)];
    siftingBtn.backgroundColor = [UIColor whiteColor];
    [siftingBtn setImage:[UIImage imageNamed:@"sx_"] forState:0];
    [siftingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    siftingBtn.imageEdgeInsets = UIEdgeInsetsMake(0,60, 0, 0);
    siftingBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [siftingBtn setTitle:@"筛选" forState:0];
    siftingBtn.titleLabel.font = font(15);
    [siftingBtn addTarget:self action:@selector(siftingClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:siftingBtn];
}

-(void)siftingClick
{
//    if ([_selectedButton.titleLabel.text isEqualToString:@"应邀广场"]) {
     [self.delegate SPLeaseSectionHeaderViewSelectedString:@"筛选"];
//    }else{
//        Toast(@"智能筛选应邀广场的数据");
//    }
   
}

-(void)leaseType:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    _selectedButton.selected = !_selectedButton.isSelected;
    _selectedButton =  btn;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView .centerX = btn.centerX;
    }];
    
    //代理回传
    [self.delegate SPLeaseSectionHeaderViewSelectedString:btn.titleLabel.text];
}

-(void)setSelected:(NSString *)type
{
    
    for (UIButton *btn in self.subviews)
    {
        if (![btn isKindOfClass:[UIButton class]])
        {
            return;
        }
        if ([btn.titleLabel.text isEqualToString:type])
        {
            [self leaseType:btn];
        }
    }
}

@end
