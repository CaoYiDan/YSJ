//
//  SPPayTypeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPayTypeCell.h"

@implementation SPPayTypeCell
{
    UIImageView *_icon;
    UILabel *_textLabel;
    UIButton *_selectedBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 15, 30, 30)];
    [self.contentView addSubview:_icon];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargin +30+10, 0, 150, 60)];
    _textLabel.font = font(14);
    _textLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_textLabel];
    
    _selectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-30, self.frameHeight/2-10, 20, 20)];
    _selectedBtn.backgroundColor = [UIColor whiteColor];
    [_selectedBtn setImage:[UIImage imageNamed:@"fa_xx_djw"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"fb_xx_dj"]forState:UIControlStateSelected];
    _selectedBtn.userInteractionEnabled =NO;
    [self.contentView addSubview:_selectedBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

-(void)tap:(UIGestureRecognizer *)gesture{
    [self.delegate SPPayTypeCellSelectedIndex:self.indexPath];
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    if (indexPath.row==0)
    {
        [_icon setImage:[UIImage imageNamed:@"wxPay"]];
        _textLabel.text = @"微信支付";
        
    }else
    {
        [_icon setImage:[UIImage imageNamed:@"wd_zfb"]];
        _textLabel.text = @"支付宝支付";
    }
}

-(void)setCellSelected:(BOOL)selectedCell{
    _selectedBtn.selected = selectedCell;
}

@end
