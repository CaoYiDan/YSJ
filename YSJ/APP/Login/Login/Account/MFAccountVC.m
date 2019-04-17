//
//  MFMineVC.m
//  MoFang
//
//  Created by xujf on 2018/9/21.
//  Copyright © 2018年 ZBZX. All rights reserved.

#import "MFAccountVC.h"

#import "MFLoginVC.h"

#import "MFChangePasswordVC.h"

#import "SPBaseNavigationController.h"

@interface MFAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MFAccountVC
{
    NSArray *_dataArr;
}

//
#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"账号信息";
    
    _dataArr = @[@"修改昵称",@"修改密码"];
    
    [self.view addSubview:self.tableView];
    
    [self setQuitBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)dealloc{
    
}

-(void)setQuitBtn{
    
    UIButton *quitBtn = [FactoryUI createButtonWithtitle:@"退出登录" titleColor:nil imageName:nil backgroundImageName:nil target:self selector:@selector(quit)];
    quitBtn.frame = CGRectMake(50, 150, kWindowW-100, 50);
    quitBtn.titleLabel.font=Font(15);
    [self.tableView addSubview:quitBtn];
    
}

-(void)quit{
    
//    [StorageUtil saveLastUserName:[StorageUtil getUserPhone]];
//    [StorageUtil saveUserPhone:@""];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark RequestNetWork

#pragma mark UITableviewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

#pragma mark UITableviewDataSource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"normalCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *bottomLine = [[UIView alloc]init];
         bottomLine.backgroundColor = [UIColor hexColor:@"f2f2f2"];
        [cell addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.right.offset(-kMargin);
            make.height.offset(1);
            make.bottom.offset(0);
        }];
    }
    cell.textLabel.textColor = KBlackColor;
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==2) {//退出登录
      
    }else if (indexPath.row == 1){
        MFChangePasswordVC *vc = [[MFChangePasswordVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark CustomDelegate

#pragma mark event response

#pragma mark private methods

#pragma mark getters and setters
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor = grayF2F2F2;
        
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.rowHeight = 60;
        
    }
    return _tableView;
}

@end
