//
//  SPChooseHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChooseHeaderView.h"

@implementation SPChooseHeaderView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W-40)/2-20,10 , 40, 40)];
        closeBtn.tag = 0;
        [closeBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchDown];
        [closeBtn setImage: [UIImage imageNamed:@"grxx_r3_c1"] forState:0];
        [self addSubview:closeBtn];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_W-40)/2-60, 60, 120,30)];
        titleLab.text =title;
        
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = BoldFont(16);
        [self addSubview:titleLab];
    }
    return self;
}

-(void)action:(UIButton *)btn{
    !self.SPChooseHeaderViewBlock?:self.SPChooseHeaderViewBlock(btn.tag);
}


@end
