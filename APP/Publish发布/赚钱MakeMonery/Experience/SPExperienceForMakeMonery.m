//
//  SPExperienceForMakeMonery.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPExperienceForMakeMonery.h"
#import "SPPhotosForMakeMoneyVC.h"
#import "JXAlertview.h"
#import "SPSkillWorkExp.h"
#import "SPPublishModel.h"
#import "SPExperienceForMakeMoneryCell.h"
#import "CustomMonthDatePicker.h"
#import "AddressViewController.h"
#import "SPIndustryView.h"
@interface SPExperienceForMakeMonery ()<UITableViewDelegate,UITableViewDataSource,CustomAlertDelegete,SPExperienceCellDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSArray *textArr;
@property(nonatomic,assign)NSInteger sectionNumber;

@property(nonatomic,strong)SPIndustryView *industryView;
@end

@implementation SPExperienceForMakeMonery
{
    SPSkillWorkExp *_chosedSkillExp;
    CustomMonthDatePicker *monthDpicker;  //'年-月'日期选择器
    NSString   *_selectDate; //标记选中的日期
    NSInteger _selectedIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    [self config];
    
    [self.view addSubview:self.tableView];
    
    [self addBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reslutCity:) name:NotificationChoseCity object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//选择了城市
-(void)reslutCity:(NSNotification *)notify{
    
    SPSkillWorkExp *expModel = self.model.skillWorkExp[_selectedIndex];
    
    expModel.workCity = notify.object;
    
    [_tableView reloadData];
}

//选择标签View
-(SPIndustryView *)industryView{
    if (!_industryView) {
        _industryView = [[SPIndustryView alloc]initWithFrame:CGRectMake(0, SCREEN_H2, SCREEN_W, SCREEN_H)];
        [self.view addSubview:_industryView];
    }
    return _industryView;
}

-(void)config{
    
    self.navigationItem.title = @"我要赚钱";
    
    //riqi
    monthDpicker = [[CustomMonthDatePicker alloc] initWithFrame:CGRectMake(0, 20, SCREEN_W-100, 140)];
    self.textArr = @[@"公司全称",@"工作城市",@"所属行业",@"职位名称",@"任职时间"];
    
    self.view.backgroundColor =HomeBaseColor;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //初始化model中的经历数组
    if (!self.model.skillWorkExp) {
        self.model.skillWorkExp = @[].mutableCopy;
        SPSkillWorkExp *expModel = [[SPSkillWorkExp alloc]init];
        [self.model.skillWorkExp addObject:expModel];
    }
    
    self.sectionNumber = self.model.skillWorkExp.count;
}

-(void)addBottomView{
    
    UIButton *jump = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H2-SafeAreaBottomHeight-SafeAreaTopHeight-60, SCREEN_W/2-40-10,40)];
    jump.backgroundColor = HomeBaseColor;
    [jump setTitle:@"跳过" forState:0];
    jump.titleLabel.font = font(14);
    [jump setTitleColor:PrinkColor forState:0];
    jump.layer.borderColor = PrinkColor.CGColor;
    jump.layer.borderWidth = 1;
    jump.layer.cornerRadius = 5;
    jump.clipsToBounds = YES;
    [jump addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:jump];
    
    UIButton *next = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2+10, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight-60, SCREEN_W/2-40-10,40)];
    next.backgroundColor = PrinkColor;
    [next setTitle:@"下一步" forState:0];
    next.titleLabel.font = font(14);
    next.layer.cornerRadius = 5;
    next.clipsToBounds = YES;
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:next];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   SPSkillWorkExp *expModel = self.model.skillWorkExp[indexPath.section];
    SPExperienceForMakeMoneryCell *cell= [SPExperienceForMakeMoneryCell cellWithTableView:tableView indexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.expModel = expModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==4) return 70;
//    return 45;
    return  92+46+46+70;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    title.backgroundColor = [UIColor whiteColor];
    title.font = font(15);
    title.text = @"  工作经历";
    return  title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    base.backgroundColor = HomeBaseColor;
    UIButton *add = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    add.backgroundColor = HomeBaseColor;
    [add setTitleColor:PrinkColor forState:0];
    [add setTitle:@"+添加" forState:0];
    add.titleLabel.font = font(14);
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchDown];
    [base addSubview:add];
    
    UIButton *delete = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-80 , 0, 60, 40)];
    delete.backgroundColor = HomeBaseColor;
    [delete setTitleColor:[UIColor grayColor] forState:0];
    [delete setTitle:@"移除" forState:0];
    delete.titleLabel.font = font(14);
    delete.tag = section;
    [delete addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchDown];
    [base addSubview:delete];
    
    return base;
}


-(void)choseCity{
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:addressVC];
    [self presentViewController:naVC animated:YES completion:nil];
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,5, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-65-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HomeBaseColor;
        //        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//        _tableView.separatorColor = [UIColor clearColor];
//        [_tableView registerClass:[SPExperienceInputCell class] forCellReuseIdentifier:SPExperienceInputCellID];
//        [_tableView registerClass:[SPExperienceArrowCell class] forCellReuseIdentifier:SPExperienceArrowCellID];
//        [_tableView registerClass:[SPExpOfficeTimeCell class] forCellReuseIdentifier:SPExpOfficeTimeCellID];
        [_tableView registerClass:[SPExperienceForMakeMoneryCell class] forCellReuseIdentifier:SPExperienceForMakeMoneryCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
//        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getHomeBanner)];
//        // footer
//        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
//        _tableView.mj_footer.hidden = YES;
    }
    return _tableView;
}

#pragma  mark - -----------------点击触发事件action-----------------

-(void)add{
    
    self.sectionNumber++;
    
    SPSkillWorkExp *expModel = [[SPSkillWorkExp alloc]init];
    [self.model.skillWorkExp addObject:expModel];
     
    [self.tableView reloadData];
    //滚动到底部 展示新添加的填写框
    [self scrollToBottomWithAnimated:YES];
    
   
}

- (void)scrollToBottomWithAnimated:(BOOL)animated
{
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.model.skillWorkExp.count-1];
    [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition: UITableViewScrollPositionBottom animated:animated];
}

-(void)delete:(UIButton *)btn{
    
 if (self.sectionNumber==1) return;
    
    self.sectionNumber--;
    
    [self.model.skillWorkExp removeObjectAtIndex:btn.tag];
    [self.tableView reloadData];
//    NSIndexSet *index = [NSIndexSet indexSetWithIndex:btn.tag];
//    [self.tableView deleteSections:index withRowAnimation:UITableViewRowAnimationTop];
}

-(void)jump{
    
    SPPhotosForMakeMoneyVC *vc = [[SPPhotosForMakeMoneyVC alloc]init];
    vc.model = self.model;
    vc.formWhere = self.formWhere;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)next{
    for (SPSkillWorkExp *expM in self.model.skillWorkExp) {
        if (isEmptyString(expM.companyName)||isEmptyString(expM.industry)||isEmptyString(expM.jobTitle)||isEmptyString(expM.workBeginTime)||isEmptyString(expM.workEndTime)||isEmptyString(expM.workCity)) {
            Toast(@"请完善信息");
            return;
        }
    }
    
    [self jump];
}

#pragma  mark - ------------ExperienceCellDelegate----------------------
-(void)SPExperienceCellDelegateDidSelectedIndexPath:(NSIndexPath *)indexPath WithType:(NSInteger)type andStringType:(NSString *)stringType{
    
    _selectedIndex = indexPath.section;
    _chosedSkillExp = self.model.skillWorkExp[indexPath.section];
    
    if([stringType isEqualToString:@"城市"]){
        [self choseCity];
    }else if([stringType isEqualToString:@"行业"]){
        [self choseIndutry];
    }else if([stringType isEqualToString:@"职位"]){
        [self choseCity];
    }else if ([stringType isEqualToString:@"任职时间"]) {
        [self showTimeWithTag:type];
    }
}

-(void)choseIndutry{
    
    SPSkillWorkExp *exp = self.model.skillWorkExp[_selectedIndex];
    WeakSelf;
    self.industryView.chooseBlock= ^(NSString *industry){
        exp.industry = industry;
        [weakSelf.tableView reloadData];
    };
    
    self.industryView.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.industryView.alpha = 1;
        self.industryView.frame = self.view.bounds;
    }];
}

-(void)showTimeWithTag:(NSInteger)tag{
    NSLog(@"%ld",(long)tag);
    [self.view endEditing:YES];
    if (tag==1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未离职？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            JXAlertview *alert2 = [[JXAlertview alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-100, 200)];
            alert2.center = self.view.center;
            alert2.delegate = self;
            alert2.tag = tag;
            [alert2 initwithtitle:@"请选择时间" andcommitbtn:@"确定" andStr:@"12"];
            
            //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
            [alert2 addSubview:monthDpicker];
            [alert2 show];
        }];
        
        UIAlertAction * login = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
             _chosedSkillExp.workEndTime = @"至今";
            [self.model.skillWorkExp replaceObjectAtIndex:_selectedIndex withObject:_chosedSkillExp];
            [_tableView reloadData];
            return ;
        }];
            [alert addAction:cancel];
            [alert addAction:login];
            
            [self presentViewController:alert animated:YES completion:nil];
    }else{
        
        JXAlertview *alert2 = [[JXAlertview alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-100, 200)];
        alert2.center = self.view.center;
        alert2.delegate = self;
        alert2.tag = tag;
        [alert2 initwithtitle:@"请选择时间" andcommitbtn:@"确定" andStr:@"12"];
        
        //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
        [alert2 addSubview:monthDpicker];
        [alert2 show];
    }
    
}

-(void)SPExperienceCellDelegateDidSelectedIndexPath:(NSIndexPath *)indexPath WithType:(NSInteger)type{
    
   
}

#pragma mark - CustomAlertDelegete
-(void)btnindex:(int)index :(int)tag
{
    NSLog(@"%d",tag);
    
    if (index == 2 ) {
        
        _selectDate = [NSString stringWithFormat:@"%d-%02d",monthDpicker.year,monthDpicker.month];
        NSLog(@"%@",_selectDate);
        if (tag==0) {//选择的开始时间
            /** 如果是 “至今” 则需要单独判断*/
            if ([_chosedSkillExp.workEndTime isEqualToString:@"至今"]) {
                 _chosedSkillExp.workBeginTime = _selectDate;
                [self.model.skillWorkExp replaceObjectAtIndex:_selectedIndex withObject:_chosedSkillExp];
                [_tableView reloadData];
                return;
            }
            if (!isEmptyString(_chosedSkillExp.workEndTime)) {
                NSArray *dateArr = [_chosedSkillExp.workEndTime componentsSeparatedByString:@"-"];
                NSInteger endYear = [dateArr[0] integerValue];
                NSInteger endMonth = [dateArr[1] integerValue];
                
                if (endYear < monthDpicker.year) {
                    
                    Toast(@"开始时间不能大于结束时间");
                    return;
                }else if( endMonth < monthDpicker.month && endYear == monthDpicker.year){
                    Toast(@"开始时间不能大于结束时间");
                    return;
                    
                }else{
                    _chosedSkillExp.workBeginTime = _selectDate;
                }
            }else{
                _chosedSkillExp.workBeginTime = _selectDate;
            }
            
        }else{
            
            if (!isEmptyString(_chosedSkillExp.workBeginTime)) {
                NSArray *dateArr = [_chosedSkillExp.workBeginTime componentsSeparatedByString:@"-"];
                NSInteger beginYear = [dateArr[0] integerValue];
                NSInteger beginMonth = [dateArr[1] integerValue];
                
                if (beginYear > monthDpicker.year) {
                    
                    Toast(@"开始时间不能大于结束时间");
                    return;
                }else if( beginMonth>monthDpicker.month && beginYear == monthDpicker.year){
                    Toast(@"开始时间不能大于结束时间");
                    return;
                   
                }else{
                     _chosedSkillExp.workEndTime = _selectDate;
                }
            }else{
                _chosedSkillExp.workEndTime = _selectDate;
            }
        }
        
        [self.model.skillWorkExp replaceObjectAtIndex:_selectedIndex withObject:_chosedSkillExp];
        [_tableView reloadData];
    }
}
@end
