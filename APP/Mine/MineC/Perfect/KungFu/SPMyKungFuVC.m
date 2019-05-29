//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyKungFuVC.h"
#import "SPMyHeader.h"
#import "SPKungFuSection.h"
#import "SPKungFuCell.h"
#import "SPApplicationVC.h"
#import "SPKungFuModel.h"
#import "SPChooseView.h"
#import "SPMyInterestVC.h"
#import "SPMyTagVC.h"

@interface SPMyKungFuVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)SPMyHeader *tableHeader;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPChooseView *chooseView;

@end

@implementation SPMyKungFuVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //背景图片
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    //tableview
    [self.view insertSubview:self.tableView atIndex:1];
    //myHeader
    [self.view insertSubview:self.tableHeader atIndex:2];
    //请求数据
    [self loadData];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
}

#pragma  mark - 请求数据
-(void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:SKILL forKey:@"rootType"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:listSkillsByUser parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
           NSLog(@"%@",responseObject[@"data"]);
         self.listArray = (NSMutableArray*)[SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        for (SPKungFuModel *model1 in self.listArray) {
            
            //1.初始化都折叠 2.从个人编辑界面过来的，则展开对应的行
            if (self.formMyCenter && [self.code isEqualToString:model1.code]) {
                model1.flag = @"YES";
            }else{
                model1.flag = @"NO";
            }
            //目前返回的三级数据，是全部的三级武功，根据selected属性 判断 是不是当前用户曾经选择过的
            for (SPKungFuModel *model2 in model1.subProperties) {
                //一定要先初始化一下，不然为空
                if (model2.thirdLevelArr==nil) {
                    model2.thirdLevelArr = [[NSMutableArray alloc]init];
                }
                for (SPKungFuModel *model3 in model2.subProperties) {
                    if (model3.selected) {
                        [model2.thirdLevelArr addObject:model3];
                    }
                }
            }
        }
        //菊花隐藏
        [MBProgressHUD hideHUDForView:self.view  animated:YES];

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SPKungFuModel *model1 = self.listArray[section];
   
    if ([model1.flag isEqualToString:@"NO"]) {
        return 0;
    } else {
        return model1.subProperties.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPKungFuCell*cell = [tableView dequeueReusableCellWithIdentifier:SPKungFuCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SPKungFuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPKungFuCellID];
    }
    cell.indexRow = indexPath.row;
    SPKungFuModel *model1 = self.listArray[indexPath.section];
    SPKungFuModel *model2 = model1.subProperties[indexPath.row];
    cell.model = model2;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    SPKungFuModel *model1 = self.listArray[indexPath.section];
    SPKungFuModel *model2 = model1.subProperties[indexPath.row];
    if (model2.thirdLevelArr.count==0) {
        return 40;
    }
    return model2.thirdLevelArr.count/4*40+(model2.thirdLevelArr.count%4==0?0:1)*40;
    
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SPKungFuSection *view = [[SPKungFuSection alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    view.backgroundColor = [UIColor whiteColor];
    SPKungFuModel *model1 = self.listArray[section];
    view.title = model1.value;
    view.tag = section;
    
    if (view.gestureRecognizers == nil) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClickedAction:)];
        [view addGestureRecognizer:tap];
    }
    return view;
}

#pragma  mark - 与选择武功View 的交互
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPKungFuModel *model1 = self.listArray[indexPath.section];
    SPKungFuModel *model2 = model1.subProperties[indexPath.row];
   
    //将 所有可选择标签 和已选择的标签传过去
    [self.chooseView loadWithCode:nil withAllArray:model2.subProperties haveChosedArr:model2.thirdLevelArr headerTitle:model2.value];
    
    WeakSelf;
    
    /** Block回调*/
    self.chooseView.chooseBlock = ^(NSArray *arr){
        //将选中的数组，传给模型
        
        model2.thirdLevelArr =(NSMutableArray*)arr;
        //更新相关界面
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
        [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    };
    self.chooseView.alpha = 0;
   [UIView animateWithDuration:0.4 animations:^{
       self.chooseView.alpha = 1;
       self.chooseView.frame = self.view.bounds;
   }];
    return;
}

#pragma  mark - setter

//选择标签View
-(SPChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[SPChooseView alloc]initWithFrame:CGRectMake(0, SCREEN_H2, SCREEN_W, SCREEN_H)];
        [self.view addSubview:_chooseView];
    }
    return _chooseView;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,headerHeight1, SCREEN_W, SCREEN_H2-headerHeight1) style:UITableViewStyleGrouped];
        _tableView.alpha = 0.9;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPKungFuCell class] forCellReuseIdentifier:SPKungFuCellID];
        _tableView.sectionFooterHeight = 0;
        _tableView.contentInset =  UIEdgeInsetsMake(0, 0, 80, 0);
    }
    return _tableView;
}

-(SPMyHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SPMyHeader alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, headerHeight1)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        _tableHeader.alpha = 0.9;
        [_tableHeader setImg:[UIImage imageNamed:@"skill"]];
        ////  + 新武功
//        [_tableHeader addSubview:[self addMyKungFu]];
    }
    return _tableHeader;
}

//  + 新武功
-(UIButton *)addMyKungFu{
    UIButton *add = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-80, 70, 70, 40)];
    
    [add setTitleColor:[UIColor blackColor] forState:0];
    add.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [add setTitle:@"+ 新技能" forState:0];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchDown];
    return add;
}


#pragma  mark - action

-(void)add{
    SPApplicationVC *vc = [[SPApplicationVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark sectionView点击 折叠或展开
- (void) headerViewClickedAction:(UITapGestureRecognizer *)sender
{
    SPKungFuModel *model1 = self.listArray[sender.view.tag];
    if ([model1.flag isEqualToString:@"NO"]) {
        model1.flag = @"YES";
    } else {
        model1.flag = @"NO";
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

-(void)jump{
    [self pushViewCotnroller:NSStringFromClass([SPMyTagVC class])];
}

-(void)next{
    self.needShow = NO;
    NSMutableArray *skillArr = [[NSMutableArray alloc]init];
    //三级遍历，将选择的标签 存储到数组
    for (SPKungFuModel *model1 in self.listArray) {
        for (SPKungFuModel *model2 in model1.subProperties) {
            if (model2.thirdLevelArr.count!=0) {
                for (SPKungFuModel *model3 in model2.thirdLevelArr) {
                    [skillArr addObject:[NSString stringWithFormat:@"%@:%@:%@",model3.code,model3.value,model2.code]];
                }
            }
        }
    }
   //将数组元素 用 "," 拼接（  10000000017:银行证券:10000000023,10000000042:家政服务:10000000022  ）
  NSString *skillSrt = [skillArr componentsJoinedByString:@","];
    NSLog(@"%@",skillSrt);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:skillSrt forKey:@"skillsStr"];
    [self postMessage:dict pushToVC:NSStringFromClass([SPMyInterestVC class])];
}

-(void)back{
    //拦截返回按钮 显示提示框
    [self showAliterView];
}

-(void)save{
    self.needShow = NO;
    NSMutableArray *skillArr = [[NSMutableArray alloc]init];
    //三级遍历，将选择的标签 存储到数组
    for (SPKungFuModel *model1 in self.listArray) {
        for (SPKungFuModel *model2 in model1.subProperties) {
            if (model2.thirdLevelArr.count!=0) {
                for (SPKungFuModel *model3 in model2.thirdLevelArr) {
                    [skillArr addObject:[NSString stringWithFormat:@"%@:%@:%@",model3.code,model3.value,model2.code]];
                }
            }
        }
    }
    //将数组元素 用 "," 拼接（  10000000017:银行证券:10000000023,10000000042:家政服务:10000000022  ）
    NSString *skillSrt = [skillArr componentsJoinedByString:@","];
    NSLog(@"%@",skillSrt);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:skillSrt forKey:@"skillsStr"];
    [self postMessage:dict pushToVC:@"pop"];
}
@end
