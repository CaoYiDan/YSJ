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
#import "YSJPublish_RequementVC.h"

#import "YSJPopTextView.h"
#import "LGTextView.h"

#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJPublish_RequementVC ()

//需求标题cell
@property (nonatomic,strong) YSJPopTextFiledView *xuTitleCell;

@property (nonatomic,strong) LGTextView *xuTextView;

@property (nonatomic,strong) UIButton  *selectedBtn;

@property (nonatomic,strong)UIView * mySilderLine;
@end

@implementation YSJPublish_RequementVC
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
    _scroll.contentSize = CGSizeMake(0, 1150);
    [self.view addSubview:_scroll];
    
    [self topView];
    
    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{cb_cellH:@"76",
                          cb_orY:@"320",
                          cb_cellArr:@[
      @{
          @"type":@(CellPopCouserChosed),
          @"title":@"分类",
          cb_courseCategoryType:@(1),
          },
      @{
          @"type":@(CellPopMoreTextFiledView),
          @"title":@"课程价格",
          cb_moreTextFiledArr:@"最低价格,最高价格"
          },
      
      @{
          @"type":@(CellPopNormal),
          @"title":@"上课时段",
          },
      
      @{
          @"type":@(CellSwitch),
          @"title":@"上门服务",
          },
      
      @{
          @"type":@(CellPopNormal),
          @"title":@"上课地址",
          },
      
      @{
          @"type":@(CellPopNormal),
          @"title":@"可接受距离(km)",
          cb_keyBoard:@(UIKeyboardTypeNumberPad),
          },
      
      @{
          @"type":@(CellPopLine),
          @"lineH":@"6",
          },
      
      @{
          cb_type:@(CellPushVC),
          cb_title:@"需求标签",
          cb_pushvc:@"YSJChoseTagsVC",
          cb_otherString:@"学生-需求",
          },
      @{
          cb_type:@(CellPushVC),
          cb_title:@"自身标签",
          cb_pushvc:@"YSJChoseTagsVC",
          cb_otherString:@"学生-学生",
          }
      ]
                          };
    return dic;
}


-(void)topView{
    
    YSJPopTextFiledView *xuTitle = [[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 76) withTitle:@"需求标题" subTitle:@"请输入您的需求"];
    self.xuTitleCell = xuTitle;
    [_scroll addSubview:xuTitle];
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"需求内容";
    xuTextTitle.textColor = KBlack333333;
    [_scroll addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(60);
        make.top.equalTo(xuTitle.mas_bottom).offset(0);
    }];
    
    self.xuTextView = [[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 76+60, kWindowW-2*kMargin, 120)];
    self.xuTextView .placeholder = @"详细描述会为您快速匹配合适的老师或机构\n1.描述想找哪一类艺术老师/机构\n2.描述你希望找什么样的老师/机构\n3.描述自己现阶段的水平如何";
    self.xuTextView.placeholderColor = gray999999;
    self.xuTextView.font = font(14);
    self.xuTextView.textColor = black666666;
    [_scroll addSubview:self.xuTextView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(self.xuTextView.mas_bottom).offset(5);
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
    NSArray *arr = @[@"找私教",@"找机构"];
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
        make.left.offset(kWindowW/4-25);
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
    
    if (btn.tag==0) {
        [_builder showViewForRequement];
    }else{
        [_builder hiddenViewForRequement];
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
    
    if (isEmptyString(_xuTitleCell.rightSubTitle) || [_xuTitleCell.rightSubTitle isEqualToString:@"需求标题"] || isEmptyString(_xuTextView.text)) {
        Toast(@"请填写完整信息");
        return;
    }
    
    //从第二个字段开始罗列"key"数组（第0个和第1个 的拼接方式不一样）
    NSArray *keyArr = @[@"course_time",@"is_at_home",@"address",@"distance",@"lables",@"userlables"];
    
    //获取value数组
    NSMutableArray *valueArr = [_builder getAllContent];

    int i = 0 ;
    
    NSLog(@"%@",valueArr);
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in valueArr) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            //从第二个字段开始罗列"key"数组（第0个和第1个 的拼接方式不一样）
            if (i>=2) {
                [dic setObject:value forKey:keyArr[i-2]];
            }
            
        }
        i++;
    }
    
    [dic setObject:_xuTitleCell.rightSubTitle forKey:@"title"];
    
    [dic setObject:_xuTextView.text forKey:@"describe"];
    
    //课程大类
    [dic setObject:[valueArr[0] componentsSeparatedByString:@"-"][0] forKey:@"coursetype"];
    //课程小类
     [dic setObject:[valueArr[0] componentsSeparatedByString:@"-"][1] forKey:@"coursetypes"];
    //最低价格
    [dic setObject:[[valueArr[1] componentsSeparatedByString:@","][0] componentsSeparatedByString:@":"][1] forKey:@"lowprice"];
    //最高价格
    [dic setObject:[[valueArr[1] componentsSeparatedByString:@","][1]componentsSeparatedByString:@":"][1] forKey:@"highprice"];
    //需求种类(私教、机构)
    [dic setObject:self.selectedBtn.tag==0?@"私教":@"机构" forKey:@"course_kind"];
    //token
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YPublishDemands parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        Toast(@"发布成功");
        //发布通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"publishFinish" object:nil];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//显示弹出框列表选择
- (void)showSheet{
    
}

@end
