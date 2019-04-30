//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplication_SuccessVC.h"
#import "YSJPublish_CompanyVC.h"
#import "YSJPopTeachTypeView.h"
#import "YSJPopTextView.h"
#import "LGTextView.h"
#import "YSJDetailForCompanyPublishVC.h"

#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJPublish_CompanyVC ()
@property (nonatomic,strong) YSJPopTeachTypeView *teachTypeView;
//需求标题cell
@property (nonatomic,strong) YSJPopTextFiledView *xuTitleCell;

@property (nonatomic,strong) LGTextView *xuTextView;

@property (nonatomic,strong) UIButton  *selectedBtn;

@property (nonatomic,strong)UIView * mySilderLine;

@end

@implementation YSJPublish_CompanyVC
{
    UIScrollView  *_scroll;
    UILabel *_name;
    UITextField *_identifierTextFiled;
    UILabel *_sex;
    YSJFactoryForCellBuilder *_builder;
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
    
    self.title = @"发布";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UI

-(void)initUI{
    
    YSJFactoryForCellBuilder *builder = [[YSJFactoryForCellBuilder alloc]init];
    
    _builder = builder;
    
    _scroll = [builder createViewWithDic:[self getCellDic]];
    _scroll.contentSize = CGSizeMake(0, 1300);
    [self.view addSubview:_scroll];
    
    //首次选中（）
    [_builder publishForTeachOneByOne];
    
    [self topView];
    
    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{@"cellH":@"76",
                          @"orY":@"230",
                          @"arr":@[
                                  @{
                                      @"type":@(CellPopCouserChosed),
                                      @"title":@"分类",
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"课程特色",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopMoreTextFiledView),
                                      @"title":@"课程价格",
                                      @"arr":@"现价,原价"
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"适用人群",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"课程人数",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"上课地址",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopLine),
                                      @"lineH":@"6",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"课程标签",
                                      }
                                  
                                  ]
                          };
    return dic;
}

-(void)topView{
    
    YSJPopTextFiledView *xuTitle = [[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 76) withTitle:@"课程标题" subTitle:@"请输入课程标题"];
    self.xuTitleCell = xuTitle;
    [_scroll addSubview:xuTitle];
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"课程详情";
    xuTextTitle.textColor = KBlack333333;
    xuTextTitle.userInteractionEnabled = YES;
    [_scroll addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(76);
        make.width.offset(kWindowW);
        make.top.equalTo(xuTitle.mas_bottom).offset(0);
    }];
    
    WeakSelf;
    [xuTextTitle addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        YSJDetailForCompanyPublishVC *vc = [[YSJDetailForCompanyPublishVC alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [xuTextTitle addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW-kMargin-8-kMargin);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.offset(0);
    }];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(xuTextTitle.mas_bottom).offset(5);
    }];
    
    UIView *baseSwitchView = [[UIView alloc]init];
    baseSwitchView.backgroundColor = KWhiteColor;
    [_scroll addSubview:baseSwitchView];
    [baseSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(60);
        make.top.equalTo(bottomLine.mas_bottom).offset(0);
    }];
    
    int i = 0 ;
    NSArray *arr = @[@"明星课程",@"精品课程",@"试听课程"];
    CGFloat btnW = kWindowW/arr.count;
    for (NSString *str in arr) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW,55)];
        [btn setTitle:str forState:0];
        [btn setTitleColor:KMainColor forState:UIControlStateSelected];
        [btn setTitleColor:gray999999 forState:0];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        btn.titleLabel.font = font(16);
        [baseSwitchView addSubview:btn];
        if (i==0) {
            self.selectedBtn =  btn;
            btn.selected = YES;
        }
        i++;
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = grayF2F2F2;
    [baseSwitchView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(3);
        make.bottom.offset(0);
    }];
    
    UIView *silderLine = [[UIView alloc]init];
    silderLine.backgroundColor = KMainColor;
    _mySilderLine = silderLine;
    _tag = silderLine;
    [baseSwitchView addSubview:silderLine];
    [silderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW/6-25);
        make.width.offset(50);
        make.height.offset(3);
        make.bottom.offset(0);
    }];
}

-(void)typeClick:(UIButton *)btn{
    
    if (self.selectedBtn==btn) {
        return;
    }
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    _mySilderLine.centerX = btn.centerX;
    
    if (btn.tag==1) {
        [_builder publishForTeachPinDan];
    }else{
        [_builder publishForTeachOneByOne];
    }
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"确认发布" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

#pragma mark - action

#pragma mark  提交申请

-(void)next{
    
    NSArray *keyArr = @[@"sale_item",@"address",@"is_at_home",@"occupation",@"school",@"education",@"describe"];
    
    NSMutableArray *valueArr = [_builder getAllContent];
    
    int i = 0 ;
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in valueArr) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            [dic setObject:value forKey:keyArr[i]];
        }
        i++;
    }
    
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherStep3 parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        YSJApplication_SuccessVC *vc = [[YSJApplication_SuccessVC alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//显示弹出框列表选择
- (void)showSheet{
    
}

-(YSJPopTeachTypeView*)teachTypeView{
    if (!_teachTypeView) {
        _teachTypeView = [[YSJPopTeachTypeView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_teachTypeView];
        WeakSelf;
        _teachTypeView.block = ^(NSMutableArray *chosedArr) {
            //             [weakSelf.tableView reloadData];
            NSLog(@"%@",chosedArr);
            
        };
    }
    return _teachTypeView;
}
@end
