//
//  YSJApplication_demoVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJApplication_demoVC.h"

@interface YSJApplication_demoVC ()

@end

@implementation YSJApplication_demoVC
{
    UIImageView *_img;
    UIScrollView  *_scrollView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"照片示例";
    
    [self setBase];
    
    UILabel *tip0 = [FactoryUI createLabelWithFrame:CGRectMake(kMargin, 34, 200, 20) text:@"身份证" textColor:KBlack333333 font:font(16)];
    tip0.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:tip0];
    
    UILabel *tip1 = [FactoryUI createLabelWithFrame:CGRectZero text:@"请参考样例，拍摄完整照片\n照片不可模糊\n照片不可反光" textColor:gray999999 font:font(14)];
    tip1.numberOfLines = 0;
    tip1.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.top.equalTo(tip0.mas_bottom).offset(20);
    }];
    
    UIImageView *topImg = [[UIImageView alloc]init];
    topImg.backgroundColor = [UIColor blueColor];
    topImg.image = [UIImage imageNamed:@"example2"];
    [_scrollView addSubview:topImg];
    [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(262);
        make.height.offset(173);
        make.top.equalTo(tip1.mas_bottom).offset(30);
    }];
    
    UIImageView *topImg1 = [[UIImageView alloc]init];
    topImg1.backgroundColor = [UIColor blueColor];
    topImg1.image = [UIImage imageNamed:@"example3"];
    [_scrollView addSubview:topImg1];
    [topImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(262);
        make.height.offset(173);
        make.top.equalTo(topImg.mas_bottom).offset(14);
    }];
    
    [self setBottomBtn];
}

#pragma mark baseScrollview
-(void)setBase{
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView = scrollView;
    _scrollView.backgroundColor = KWhiteColor;
    [self.view  addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kWindowW, 700);
}

-(void)setBottomBtn{
    
    UIButton *iKnowBtn = [[UIButton alloc]init];
    iKnowBtn.backgroundColor = KMainColor;
    [iKnowBtn setTitle:@"我已知晓,去提交照片" forState:0];
    iKnowBtn.layer.cornerRadius = 5;
    iKnowBtn.clipsToBounds = YES;
    [iKnowBtn addTarget:self action:@selector(applicationClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:iKnowBtn];
    [iKnowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-26);
    }];
}

-(void)applicationClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
