//
//  SPAuthenticationView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPAuthenticationView.h"
@interface SPAuthenticationView ()
@property(nonatomic,strong)UIButton *authentication0;

@property(nonatomic,strong)UIButton *authentication1;
@property(nonatomic,strong)UIButton *authentication2;
@property(nonatomic,strong)UIButton *authentication3;

@end

@implementation SPAuthenticationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    //认证0
//    self.authentication0 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [self.authentication0 setImage:[UIImage imageNamed:@"sy_icon_sjw"] forState:0];
//    [self.authentication0 setImage:[UIImage imageNamed:@"sy_icon_sj"] forState:UIControlStateSelected];
//    [self addSubview:self.authentication0];
    
    //认证1
    self.authentication1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 20, 20)];
    [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_bzjw"] forState:0];
    [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_bzj"] forState:UIControlStateSelected];
    [self addSubview:self.authentication1];
    
    //认证2
    self.authentication2 = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 20, 20)];
    [self.authentication2 setImage:[UIImage imageNamed:@"sy_icon_sjw"] forState:0];
    [self.authentication2 setImage:[UIImage imageNamed:@"sy_icon_sj"] forState:UIControlStateSelected];
    [self addSubview:self.authentication2];
    
    //认证3
    self.authentication3 = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
    [self.authentication3 setImage:[UIImage imageNamed:@"sy_icon_smw"] forState:0];
    [self.authentication3 setImage:[UIImage imageNamed:@"sy_icon_sm"] forState:UIControlStateSelected];
    [self addSubview:self.authentication3];
    
}

-(void)setType:(NSInteger)type{
    _type = type;

    if (type == 3)
    {
        
        [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_cyjw"] forState:0];
        [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_cyj"] forState:UIControlStateSelected];
    }else if (type==4)
    {
        self.authentication1.hidden = YES;
    }
}

//赋值
-(void)setA0:(BOOL)a0 A1:(BOOL)a1 set2:(BOOL)a2 set3:(BOOL)a3{
    self.authentication0.selected = a0;
    self.authentication1.selected = a1;
    self.authentication2.selected = a2;
    self.authentication3.selected = a3;
}

@end
