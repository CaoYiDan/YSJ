//
//  SPVisterForHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPVisterForHeaderView.h"
#import "SPVisterModel.h"

#import "SPProfileVC.h"
@implementation SPVisterForHeaderView
{
    UILabel *_visterNumber;
    NSArray *_arrModel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

-(void)setUI{
   
    _visterNumber = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 150, 30)];
    _visterNumber.font = kFontNormal;
    [self addSubview:_visterNumber];
}

-(void)setVisterImage:(NSArray *)imgs andPraisedNumber:(NSInteger)praisedNumber andTotalVisterNumber:(NSInteger)totalNumber{
    _arrModel = imgs;
    _visterNumber.text = [NSString stringWithFormat:@"最新访客 %lu人",totalNumber];
    
    CGFloat margin = 10;
    CGFloat iconW = 40;
    for (int i=0; i<imgs.count; i++) {
        if (i>=6) {
            return;
        }
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin+i%7*(iconW + margin),30, iconW, iconW)];
        SPVisterModel *visterM = imgs[i];
        icon.backgroundColor = [UIColor whiteColor];
        icon.layer.cornerRadius = iconW/2;
        icon.clipsToBounds = YES;
        icon.tag = i;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        icon.userInteractionEnabled = YES;
        [icon sd_setImageWithURL:[NSURL URLWithString:visterM.visitAvatar] placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
        [self addSubview:icon];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap:)];
        tap.numberOfTapsRequired = 1;
        [icon addGestureRecognizer:tap];
    }
}

//点击访客头像事件
-(void)iconTap:(UITapGestureRecognizer *)gesture{
    UIView *vie = gesture.view;
    SPVisterModel *visterM = _arrModel[vie.tag];
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code = visterM.visitCode;
    vc.titleName = visterM.visitNickName;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}
@end
