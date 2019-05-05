
//  YSJApplication_firstVC.m

//  SmallPig

//  Created by xujf on 2019/4/17.

//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplication_SuccessVC.h"
#import "YSJAlpplication_ThirdVC.h"
#import "YSJPopTeachTypeView.h"
#import "YSJPopTextView.h"

#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJAlpplication_ThirdVC ()
@property (nonatomic,strong) YSJPopTeachTypeView *teachTypeView;
//可售课程cell
@property (nonatomic,strong) YSJPopTextFiledView *courseTypeCell;
//学历cell
@property (nonatomic,strong) YSJPopTextFiledView *xueliCell;
@end

@implementation YSJAlpplication_ThirdVC
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
    
    self.title = @"私教申请";
    
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
    [self.view addSubview:_scroll];
    _tag =builder.lastBottomView;
    
    [self topView];

    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{cb_cellH:@"76",
                          cb_orY:@"111",
                         cb_cellArr:@[
                                  @{
                                      @"type":@(CellPopCouserChosed),
                                      @"title":@"可授课程",
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"授课地点",
                                      },
                                  
                                  @{
                                      @"type":@(CellSwitch),
                                      @"title":@"上门服务",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"职业",
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"工作单位/学校",
                                      },
                                  @{
                                      @"type":@(CellPopSheet),
                                      @"title":@"学历",
                                      @"sheetText":  @"大专,本科,硕士,博士,其他"
                                      
                                      },
                                  @{
                                      @"type":@(CellPopTextView),
                                      @"title":@"个人介绍",
                                      }
                                  ]
                          };
    return dic;
}


-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step3"];
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
    
    [dic setObject:self.certifierString forKey:@"qualifications"];
   
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
            weakSelf.courseTypeCell.rightSubTitle = [chosedArr componentsJoinedByString:@","];
        };
    }
    return _teachTypeView;
}
@end
