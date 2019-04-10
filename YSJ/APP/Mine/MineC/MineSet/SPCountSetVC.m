//
//  SPCountSetVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCountSetVC.h"
#import "SetTableViewCell.h"
#import "SPChangePhoneViewController.h"
@interface SPCountSetVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView * _tableView;
}
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,copy) NSString * detailStr;

@end

@implementation SPCountSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self createUI];
    [self createTableView];

    // Do any additional setup after loading the view.
}

#pragma mark - createUI
- (void)createUI{
    
    self.titleLabel.text = @"账号设置";
    //,@"密码"
    self.titleArr = @[@"手机号"];
    self.titleImageArr = @[@"dl_r1_c2",@"lb_r5_c1"];
    
    UIButton * quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(20, 455, SCREEN_W - 40, 40);

    [quitBtn setImage:[UIImage imageNamed:@"lb_r15_c3"] forState:UIControlStateNormal];
    [quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:quitBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - createTableView
- (void)createTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 100) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SetTableViewCell * setCell = [SetTableViewCell tableViewCellWithTableView:tableView];
    if (indexPath.row==0) {
        
        //setCell.detailTextLabel.text = @"13682175099";
        //setCell.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    
    setCell.textLabel.text = self.titleArr[indexPath.row];
    setCell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    return setCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row ==0) {//手机号
        
        SPChangePhoneViewController * changeVC = [[SPChangePhoneViewController alloc]init];
        
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }else if (indexPath.row ==1) {//密码
        
        
        
    }
}

#pragma mark - quitBtnClick
- (void)quitBtnClick{

    
}
@end
