//
//  SPHomeSwitchHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/15.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeSwitchHeaderView.h"
#import "SPHomeLefeItem.h"
#define  itemWid  60

@interface SPHomeSwitchHeaderView ()

@property (nonatomic, strong) UIButton *rightBtnItem;

@property (nonatomic, strong) UIImageView *sliderImg;

@end

@implementation SPHomeSwitchHeaderView
{
    SPHomeLefeItem *_area;
     UILabel *_uReadLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(UIImageView *)sliderImg{
    if (!_sliderImg) {
        _sliderImg = [[UIImageView alloc]initWithFrame:CGRectMake(100,9,(SCREEN_W-2*itemWid)/2-10 ,26)];
        [_sliderImg setImage:[UIImage imageNamed:@"dh_r1_c2"]];
        _sliderImg.layer.cornerRadius = 5;
        _sliderImg.clipsToBounds = YES;
    }
    return _sliderImg;
}

-(void)sUI{
    [self setLeftItem];
    [self middleView];
    [self setRightItem];
}

-(void)middleView{
    
    CGFloat titleWid = SCREEN_W-2*itemWid;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(itemWid,0,titleWid,44)];
    [self addSubview:titleView];
    [titleView addSubview:self.sliderImg];
    NSInteger i = 0;
    
    CGFloat wid = titleWid/2-10;
    
    NSArray *titleArr = @[@"附近",@"动态"];
    
    for (NSString *titleText in titleArr) {
        
        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(5+i*(wid+5), 0, wid, 44)];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.font = font(15);
        
        [btn setTitle:titleText forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [titleView addSubview:btn];
        
        if (i==0) {
            
        }else{
            [self click:btn];
        }
        
        i++;
    }
    
}

-(void)setRightItem{
    
    _rightBtnItem= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-itemWid,0, itemWid, 44)];
    [_rightBtnItem addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchDown];

_rightBtnItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _rightBtnItem.titleLabel.font = font(14);
    //    [self.rightBtnItem setImage:[UIImage imageNamed:@"sy_xx"] forState:0];
    [_rightBtnItem setTitle:@"消息" forState:UIControlStateNormal];
    
    [_rightBtnItem setTitleColor:[UIColor blackColor] forState:0];
    
    //    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 1, 30)];
    //    line.backgroundColor = HomeLineColor;
    //    [_rightBtnItem addSubview:line];
    [self addSubview:_rightBtnItem];
    //设置未读消息数量
    [self setUnReadLabel];
}

-(void)setLeftItem{
    
    SPHomeLefeItem *area = [[SPHomeLefeItem alloc]initWithFrame:CGRectMake(0, 0, itemWid, 44)];
    _area = area;
    area.backgroundColor = [UIColor whiteColor];
    [area setImage:[UIImage imageNamed:@"p_location"] forState:0];
    [area addTarget:self action:@selector(area) forControlEvents:UIControlEventTouchDown];
    [area setTitle:@"位置" forState:0];
    [area setTitleColor:[UIColor grayColor] forState:0];
    [self addSubview:area];
}

-(void)rightItemClick:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"筛选"]) {
        [self.delegate homeSwitchHeaderViewSelectedIndex:100];
    }else if([btn.titleLabel.text isEqualToString:@"消息"]){
        [self.delegate homeSwitchHeaderViewSelectedIndex:10];
    }
}

-(void)area{
    [self.delegate homeSwitchHeaderViewSelectedIndex:0];
}

-(void)click:(UIButton *)btn{
    
    if (btn.tag==0) {
        //没有登录，就弹出登录界面
        if ([SPCommon gotoLogin]) return;
    }
    
    btn.selected = !btn.isSelected;
    self.selectedButton.selected = !self.selectedButton.isSelected;
    self.selectedButton =  btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.sliderImg .centerX = btn.centerX;
        
    }completion:^(BOOL finished) {
        if (btn.tag==0) {
            [_sliderImg setImage:[UIImage imageNamed:@"dh_r1_c2"]];
        }else{
            [_sliderImg setImage:[UIImage imageNamed:@"dh_r4_c1"]];
        }
    }];
    
    if (btn.tag==0) {
        [self.rightBtnItem setTitle:@"筛选" forState:0];
        _uReadLabel.hidden = YES;
    }else{
        //        [self.rightBtnItem setImage:[UIImage imageNamed:@"sy_xx"] forState:0];
        [self.rightBtnItem setTitle:@"消息" forState:0];
        _uReadLabel.hidden = NO;
        if (self.uReadCount==0)
        {
            _uReadLabel.hidden = YES;
        }
    }
    
    [self.delegate homeSwitchHeaderViewSelectedIndex:self.selectedButton.tag+1];
    
    
}

-(void)setLeftItemText:(NSString *)city{
    [_area setTitle:city forState:0];
}

-(void)setUnReadLabel
{
    _uReadLabel = [[UILabel alloc]init];
    _uReadLabel.font = kFontNormal;
    _uReadLabel.layer.cornerRadius = 7.5;
    _uReadLabel.clipsToBounds = YES;
    _uReadLabel.adjustsFontSizeToFitWidth = YES;
    _uReadLabel.textColor = [UIColor whiteColor];
    _uReadLabel.backgroundColor = [UIColor redColor];
    _uReadLabel.textAlignment = NSTextAlignmentCenter;
    [_rightBtnItem addSubview:_uReadLabel];
    [_uReadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.size.mas_offset(CGSizeMake(15, 15));
        make.top.offset(3);
    }];
    _uReadLabel.hidden = YES;
}

//设置未读数目
-(void)setUReadCount:(NSInteger)uReadCount{
    _uReadCount = uReadCount;
    if (uReadCount==0 || [_rightBtnItem.titleLabel.text isEqualToString:@"筛选"])
    {
        _uReadLabel.hidden = YES;
        return;
    }
    _uReadLabel.hidden = NO;
    _uReadLabel.text = [NSString stringWithFormat:@"%ld",(long)uReadCount];
    [_uReadLabel transformAnimation];
}@end

