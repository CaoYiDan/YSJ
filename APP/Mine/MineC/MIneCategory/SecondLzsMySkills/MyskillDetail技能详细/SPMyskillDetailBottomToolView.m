//
//  SPMyskillDetailBottomToolView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyskillDetailBottomToolView.h"

@implementation SPMyskillDetailBottomToolView
{
    UIButton *_firstBtn;
    UIButton *_thirdBtn;
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
    NSArray *arr = @[@"暂不赚钱",@"修改",@"删除"];
    for (int i=0; i<arr.count; i++) {
        CGFloat edgeMargin = 30;
        CGFloat middleMargin = 15;
        CGFloat btnW = (SCREEN_W-edgeMargin*2-middleMargin*2)/3;
        UIButton *toolBtn = [[UIButton alloc]initWithFrame:CGRectMake(edgeMargin +i*(btnW +middleMargin), 7.5, btnW, 35)];
        toolBtn.backgroundColor = [UIColor redColor];
        [toolBtn setTitle:arr[i] forState:0];
        toolBtn.titleLabel.font = font(14);
        toolBtn.layer.cornerRadius = 17.5;
        toolBtn.clipsToBounds = YES;
        toolBtn.tag=i;
        [toolBtn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:toolBtn];
        if (i==0) {
            _firstBtn = toolBtn;
        }else if (i==2){
            _thirdBtn = toolBtn;
        }
    }
}

-(void)toolClick:(UIButton *)btn{
    [self.delegate SPMyskillDetailBottomToolViewDidSelectedTag:btn.tag];
}

-(void)initWithStatus:(NSString *)status{
   
    if ([status isEqualToString:@"NORMAL"]) {
        [_firstBtn setTitle:@"暂不赚钱" forState:0];
    }else if ([status isEqualToString:@"STOP"]){
        [_firstBtn setTitle:@"发布赚钱" forState:0];
    }else if ([status isEqualToString:@"STOP"]){
        _thirdBtn.hidden = YES;
    }
}
@end
