//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMylevelVC.h"
#import "SPMyLevelHeader.h"
#import "SPUser.h"
#import "SPMyCenterCell.h"
#import "SPMyAppointmentVC.h"//预约
#import "SPReserveTimeViewController.h"//预约时间设置
@interface SPMylevelVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)SPMyLevelHeader *tableHeader;
@property(nonatomic ,strong)NSDictionary *levelDict;

@property(nonatomic ,strong)NSArray *texgtArr;
@property(nonatomic ,strong)NSArray *imgArr;
@end

@implementation SPMylevelVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //,@"预约时间设置",@"预约我的" ,@"申请平台认证"
    self.texgtArr = @[@"下一个等级",@"下一级资讯费用"];
    self.imgArr = @[@"l_next_level",@"l_appointment_time",@"l_appointment_my",@"l_next_money",@"l_next_money"];
    
    [self sNavigation];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    [self.view addSubview:self.tableView];
    
    [self createHeader];
    
    [self loadData];
}

#pragma  mark - 请求数据
-(void)loadData{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlGetUserLevel parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        self.levelDict = responseObject[@"data"];
        self.tableHeader.levelDict = self.levelDict;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)sNavigation{
    
    self.titleLabel.text= @"我的等级";
    
//    UIButton *introduction = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
//    [introduction addTarget:self action:@selector(introduct) forControlEvents:UIControlEventTouchDown];
//    [introduction setTitle:@"等级说明" forState:0];
//    [introduction setTitleColor:[UIColor blackColor] forState:0];
//    UIBarButtonItem *introductionBtn=[[UIBarButtonItem alloc]initWithCustomView:introduction];
//    self.navigationItem.rightBarButtonItem = introductionBtn;

}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.texgtArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPMyCenterCell*cell = [tableView dequeueReusableCellWithIdentifier:SPMyCenterCellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[SPMyCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPMyCenterCellID];
        
    }
    [cell.imageView setImage:[UIImage imageNamed:self.imgArr[indexPath.row]]];
    cell.textLabel.text = self.texgtArr[indexPath.row];
    cell.textLabel.font = kFontNormal;

    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [cell setMyText: [self stringForIndex:indexPath.row]];
    
    [cell changeContentFrameAndTextALight];
    
    return cell;
}

-(NSString *)stringForIndex:(NSInteger)row{
    NSString *contentText = @"";
    switch (row) {
        case 0:
            
            contentText = self.levelDict[@"nextLevelName"] ;
            
            break;
        case 1:
            contentText = [NSString stringWithFormat:@"%@元/小时",[self.levelDict[@"nextLevelReward"] stringValue]];
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
       
        default:
            break;
    }
    return contentText;
//    if (row == 4) {
//        return  @"";
//    }
//    if (isEmptyString(contentText)) {
//        return @"请选择";
//    }else{
//        return contentText;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        
        //SPReserveTimeViewController * timeVC = [[SPReserveTimeViewController alloc]init];
        
        //[self.navigationController pushViewController:timeVC animated:YES];
    }
    
    if (indexPath.row==2) {
        
        //SPMyAppointmentVC * reserveVC = [[SPMyAppointmentVC alloc]init];
        
        //[self.navigationController pushViewController:reserveVC animated:YES];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y>60) {
        y=60;
    }
    self.tableHeader.frame = CGRectMake(0, 0, SCREEN_W, 310-y);
}

#pragma  mark - setter


-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 42;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[SPMyCenterCell class] forCellReuseIdentifier:SPMyCenterCellID];
    }
    return _tableView;
}

-(void)createHeader{
    _tableHeader = [[SPMyLevelHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 310)];
    _tableHeader.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView =_tableHeader;
}

#pragma  mark - action
-(void)introduct{
    
}
@end
