//
//  SPApplicationVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPApplicationVC.h"

@interface SPApplicationVC ()

@end

@implementation SPApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    
    [self sUI];
}

-(void)sUI{
    
    UIView *base = [[UIView alloc]initWithFrame:self.view.bounds];
    base.backgroundColor = [UIColor whiteColor];
    base.alpha = 0.9;
    [self.view insertSubview:base atIndex:1];
    
    //大标题
    UILabel *navigationTitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-75, 80, 150, 30)];
    navigationTitle .text = @"申请说明";
    navigationTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:navigationTitle];
    
    //小标题
    UILabel *subTitle = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-75, 80+30, 150, 20)];
    subTitle.font= kFontNormal;
    subTitle.textAlignment = NSTextAlignmentCenter;
    subTitle .text = @"新技能申请说明";
    [self.view addSubview:subTitle];
    
    //内容
    UITextView *content = [[UITextView alloc]initWithFrame:CGRectMake(10, 140, SCREEN_W-20, SCREEN_H2-150)];
    content.text = @"fjdkadsjk新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明新武功申请说明l";
    [base addSubview:content];
    //设置textView 是不能编辑的
    content.userInteractionEnabled = NO;
}
@end
