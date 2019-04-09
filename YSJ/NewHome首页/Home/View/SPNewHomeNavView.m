//
//  SPNewHomeNavView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNewHomeNavView.h"

#import "SPUpDownButton.h"

@implementation SPNewHomeNavView
{
    UIButton *_leftItem;//定位按钮
    UIButton * _searchBtn;
    SPUpDownButton *_rightItem;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _leftItem = [[UIButton alloc]init];
    _leftItem.tag =0;
    
    [_leftItem addTarget:self action:@selector(homeNavClick:) forControlEvents:UIControlEventTouchDown];
    _leftItem.titleLabel.font = font(13);
    [_leftItem setImage:[UIImage imageNamed:@"dizhi"] forState:0];
    [_leftItem setTitle:[StorageUtil getCity] forState:0];
    [self addSubview:_leftItem];
    [_leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(44);
        make.top.offset(SafeAreaStateHeight);
    }];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-60, SafeAreaStateHeight, 60, 40)];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:0];
    searchBtn.tag = 2;
    [searchBtn addTarget:self action:@selector(homeNavClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:searchBtn];

}

-(void)homeNavClick:(UIButton *)btn
{
    [self.delegate homeNavViewSelectedIndex:btn.tag];
}

-(void)setTypeForLease
{
    
    [_leftItem setImage:[UIImage imageNamed:@"zy_dw"] forState:0];
    [_leftItem setTitleColor:[UIColor grayColor] forState:0];
    
    [_rightItem setImage:[UIImage imageNamed:@"zy_xx"] forState:0];
    [_rightItem setTitleColor:[UIColor grayColor] forState:0];
    
    [_searchBtn setBackgroundImage:nil forState:0];
    [_searchBtn setTitle:@"租约" forState:0];
    [_searchBtn setTitleColor:[UIColor blackColor] forState:0];
}

-(void)setLeftItemText:(NSString *)city
{
    [_leftItem setTitle:city forState:0];
    
}

//设置未读数目
-(void)setUReadCount:(NSInteger)uReadCount
{
    _uReadCount = uReadCount;
    _rightItem.uReadCount = uReadCount;
}
@end
