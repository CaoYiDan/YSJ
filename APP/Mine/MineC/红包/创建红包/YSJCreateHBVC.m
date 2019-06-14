
//  YSJApplication_firstVC.m

//  SmallPig

//  Created by xujf on 2019/4/17.

//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCourseModel.h"
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplication_SuccessVC.h"
#import "YSJCreateHBVC.h"
#import "YSJPopTeachTypeView.h"
#import "YSJPopTextView.h"

#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJCreateHBVC ()
@property (nonatomic,strong) YSJPopTeachTypeView *teachTypeView;
//可售课程cell
@property (nonatomic,strong) YSJPopTextFiledView *courseTypeCell;
//学历cell
@property (nonatomic,strong) YSJPopTextFiledView *xueliCell;
@end

@implementation YSJCreateHBVC
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
    NSMutableArray *_courseArr;
    NSString *_courseName;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"创建红包券";
    
    _courseName = @"全部";
    
    if ([self.identifier isEqualToString:User_Company]) {
        [self getCompanyCourseRequestisScu:^(BOOL isScu) {
            [self initUI];
        }];
        
    }else{
        
       [self getCourseinfoRequestisScu:^(BOOL isScu) {
        [self initUI];
       }];
    }
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
                          cb_orY:@"0",
                          cb_cellArr:@[
                                  @{
                                      @"type":@(CellTextFiled),
                                      @"title":@"红包券名称",
                                      cb_placeholder:@"请输入红包券名称",
                                      cb_keyBoard:@(UIKeyboardTypeDefault)
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"红包券金额",
                                      cb_keyBoard:@(UIKeyboardTypeDecimalPad)
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"红包券数量",
                                      cb_keyBoard:@(UIKeyboardTypeNumberPad)
                                      },
                                  
                                  @{
                                      @"type":@(CellPopYouXiaoView),
                                      @"title":@"有效期",
                                      },
                                  @{
                                      @"type":@(CellPopMenKanView),
                                      @"title":@"门槛",
                                      },
                                  @{
                                      @"type":@(CellPopSheet),
                                      @"title":@"使用课程",
                                      @"sheetText":  _courseName
                                      
                                      },
                                 
                                  ]
                          };
    
    NSLog(@"%@",_courseName);
    return dic;
}


-(void)topView{}
    
   

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
    
    NSArray *keyArr = @[@"name",@"amount",@"count",@"starttime",@"gate",@"category"];
    
    NSMutableArray *valueArr = [_builder getAllContent];
    
    int i = 0 ;
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in valueArr) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            
            if ([keyArr[i] isEqualToString:@"amount"]) {
                 [dic setObject:@([value doubleValue]) forKey:keyArr[i]];
            }else if ([keyArr[i] isEqualToString:@"count"]) {
                [dic setObject:@([value integerValue]) forKey:keyArr[i]];
            }else if ([keyArr[i] isEqualToString:@"gate"]) {
                [dic setObject:@([[[value componentsSeparatedByString:@"满"][1] componentsSeparatedByString:@"元"][0] doubleValue]) forKey:keyArr[i]];
            }else{
                [dic setObject:value forKey:keyArr[i]];
            }
        }
        i++;
    }
    
    NSString *getDate = [_builder getAllContent][3];
    [dic setObject:[NSString stringWithFormat:@"%@ %@",[getDate componentsSeparatedByString:@" 至 "][0],@"00:00:00"] forKey:@"starttime"];
    [dic setObject:[NSString stringWithFormat:@"%@ %@",[getDate componentsSeparatedByString:@" 至 "][1],@"00:00:00"] forKey:@"endtime"];
    
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    NSString *getCourse = [_builder getAllContent][5];
    if ([getCourse isEqualToString:@"全部"]) {
        [dic setObject:@"all" forKey:@"category"];
       
        [dic setObject:@"all" forKey:@"course_id"];
    }else{
        
        for (YSJCourseModel *model in _courseArr) {
            
            if ([model.title isEqualToString:getCourse]) {
                
                [dic setObject:model.coursetype forKey:@"category"];
            
                [dic setObject:model.courseId forKey:@"course_id"];
            }
        }
    }
   
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:Yredpacketcreate parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
           
            NSLog(@"%@",chosedArr);
            weakSelf.courseTypeCell.rightSubTitle = [chosedArr componentsJoinedByString:@","];
        };
    }
    return _teachTypeView;
}

#pragma mark 私教授课内容

-(void)getCourseinfoRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [dic setObject:[StorageUtil getUserMobile] forKey:@"teacherID"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeachercourseinfo parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        _courseArr  = @[].mutableCopy;
        _courseArr = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"multicourse"]];
        
       NSMutableArray *arr = [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"course"]];
        
        [_courseArr addObjectsFromArray:arr];
        
        for (YSJCourseModel *model in _courseArr) {
            _courseName = [_courseName stringByAppendingString:[NSString stringWithFormat:@",%@",model.title]];
        }
        NSLog(@"%@",_courseName);
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
    }];
}

#pragma mark 机构授课内容

-(void)getCompanyCourseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:isEmptyString([StorageUtil getId])?@"":[StorageUtil getId] forKey:@"token"];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"locate"];
    [dic setObject:[StorageUtil getUserMobile] forKey:@"companyID"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YCompanyCourse parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *free_courseArr= [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"free_course"]];
        NSArray*courseArr= [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"course"]];
        NSArray*famous_course= [YSJCourseModel mj_objectArrayWithKeyValuesArray:responseObject[@"famous_course"]];
        
        _courseArr = @[].mutableCopy;
        [_courseArr addObjectsFromArray:free_courseArr];
        [_courseArr addObjectsFromArray:courseArr];
        [_courseArr addObjectsFromArray:famous_course];
        
        for (YSJCourseModel *model in _courseArr) {
            _courseName = [_courseName stringByAppendingString:[NSString stringWithFormat:@",%@",model.title]];
        }
        NSLog(@"%@",_courseName);
        requestisScu(YES);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        requestisScu(YES);
        
    }];
}

@end
