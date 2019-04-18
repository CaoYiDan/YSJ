//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJCommonArrowView.h"
#import "YSJApplication_secondVC.h"

#import "YSJApplicationCompany_firstVC.h"

#define cellH 76

@interface YSJApplicationCompany_firstVC ()

@end

@implementation YSJApplicationCompany_firstVC
{
    UIScrollView  *_scroll;
    UILabel *_name;
    UITextField *_identifierTextFiled;
    UILabel *_sex;
    
    YSJCommonSwitchView *_supportHome;
    
    UIView *_tag;
    UIView *_tag0;
    UIView *_tag1;
    UIView *_tag2;
    UIView *_tag3;
    UIView *_tag4;
    
    NSMutableArray *_cellViewArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"机构申请";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UI

-(void)initUI{
    
    [self setBase];
    
    [self topView];
    
    [self setView1];
    
//    [self setSwitchView];
    
    [self setBottomView];
    
}


-(void)setBase{
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scroll = scrollView;
    _scroll.backgroundColor = KWhiteColor;
    [self.view addSubview:_scroll];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
}

-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step2_1"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:topImg];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    _tag = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
    }];
}

-(void)setView1{
    
    _cellViewArr = @[].mutableCopy;
    NSArray *arr = @[@"机构名称",@"机构电话",@"营业时间",@"机构地址",@"营业项目"];
    int i=0;
    for (NSString *str in arr) {
        
        YSJCommonArrowView *cell = [[YSJCommonArrowView alloc]initWithFrame:CGRectMake(0, cellH*i+111, kWindowW, cellH) withTitle:str subTitle:@""];
        [_scroll addSubview:cell];
        [_cellViewArr addObject:cell];
        __weak typeof(cell) weakCell = cell;
        [cell addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [SPCommon creatAlertControllerTitle:str subTitle:@"" _alertSure:^(NSString *text) {
                weakCell.rightSubTitle = text;
            }];
        }];
        if (i==1) {
            _tag = cell;
        }
        i++;
    }
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"下一步" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

#pragma mark - action

-(void)next{
    
    for (YSJCommonArrowView *cell in _cellViewArr) {
        NSLog(@"%@",cell.rightSubTitle);
    }
    
}


@end
