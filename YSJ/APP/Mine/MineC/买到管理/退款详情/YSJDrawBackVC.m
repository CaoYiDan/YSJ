//
//  YSJDrawBackVC.m
//  SmallPig
//
//  Created by xujf on 2019/5/14.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJOrderCourseView.h"
#import "YSJDrawBackVC.h"
#import "YSJOrderModel.h"
#import "LGTextView.h"
#import "YSJDrawBackCellView.h"
@interface YSJDrawBackVC ()
//退款原因
@property (nonatomic,strong) YSJDrawBackCellView *caurseCell;
//退款金额
@property (nonatomic,strong) UILabel  *backPrice;
@property (nonatomic,strong) LGTextView *textView;
@end

@implementation YSJDrawBackVC
{
    UIScrollView *_scroll;
    UIView *_tag;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"申请退款";
    [self initUI];
}

#pragma mark - UI

-(void)initUI{
    
    [self setBaseView];
    [self setUI];
    [self setBottomView];
}


-(void)setBaseView{
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scroll.backgroundColor = KWhiteColor;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
    [self.view addSubview:_scroll];
}

-(void)setUI{
    
    YSJOrderCourseView *orderView = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 102)];
    orderView.backgroundColor = KWhiteColor;
    orderView.model = self.model;
    [_scroll addSubview:orderView];
    
    [self setCaurseView];
    
    [self setBackMoneyView];
//
    [self setTextView];
}

-(void)setCaurseView{
    
    YSJDrawBackCellView *cell = [[YSJDrawBackCellView alloc]initWithFrame:CGRectMake(0, 102, kWindowW,normalCellH
                                                                                     ) withTitle:@"退款原因" subTitle:@""];
    self.caurseCell = cell;
    [_scroll addSubview:cell];
    
}

-(void)setBackMoneyView{
    
    YSJRightYellowCell *backMoney = [[YSJRightYellowCell alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 74) cellH:74 title:@"退款金额" rightText:[NSString stringWithFormat:@"¥%.2f",self.model.real_amount]];
    [_scroll addSubview:backMoney];
    [backMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        
        make.height.offset(74);
        make.width.offset(kWindowW); make.top.equalTo(self.caurseCell.mas_bottom).offset(0);
    }];
    _tag = backMoney;
}

-(void)setTextView{
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"退课描述";
    xuTextTitle.textColor = KBlack333333;
    [_scroll addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.equalTo(_tag.mas_bottom).offset(25);
    }];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 102+76*2+60, SCREEN_W-2*kMargin, 104)];
    self.textView = textView;
    [_scroll addSubview:textView];
    textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
    textView.textColor = black666666;
    textView.delegate = self;
    textView.font  = font(14);
    textView.placeholder = @"详细描述退课的原用\n1.课程不符合需要？\n2.老师上课不准时？\n3.课程内容设计的不好？";
    [_scroll addSubview:textView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(textView).offset(0);
    }];
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"提交" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

#pragma mark - action

-(void)next{
    
}

@end
