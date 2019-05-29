//
//  YSJTeacherInfoView.m
//  SmallPig
//
//  Created by xujf on 2019/3/27.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJCompanyTeacherCell.h"
#import "YSJCompanysModel.h"
#import "YSJChildCompanyLeftVC.h"
#import "NSString+getSize.h"
#import "YSJUserModel.h"
@implementation YSJChildCompanyLeftVC
{
    NSArray *_dataArr;
    
    NSMutableArray *_dataListArr;
    
    UIImageView *_img;
    
    UILabel *_name;
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    
    [self initUI];
}

- (void)initUI{
    
    _dataListArr = @[].mutableCopy;
    
    _dataArr = @[@"名师风采",@"品牌介绍",@"办学特色",@"营业时间"];
    _dataListArr = _dataArr;
    [self.view addSubview:self.tableView];
    
}

#pragma  mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        YSJCompanyTeacherCell *cell = [YSJCompanyTeacherCell loadCode:tableView];
        cell.listArr = self.model.company_teacher;
        return cell;
    }
    
    return [self normalCellWithTableView:tableView index:indexPath];
}

-(UITableViewCell *)normalCellWithTableView:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell loadCode:tableView];
    cell.textLabel.text = _dataListArr[indexPath.section];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = gray999999;
    cell.textLabel.font = font(14);
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [cell.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    return cell;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderAtSection:section];
}

// title
-(UIView *)sectionHeaderAtSection:(NSInteger)section{
    
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 40)];
    base.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 100, 30)];
    title.numberOfLines = 0;
    title.text = _dataArr[section];
    title.font = BoldFont(18);
    [base addSubview:title];
    
    return base;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",_dataListArr);
    if (indexPath.section==0) {
        
        return 152;
        
    }else if (indexPath.section==1){
        return  [_dataListArr[1] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }else if (indexPath.section==2){
        return  [_dataListArr[2] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }else if (indexPath.section==3){
        return  [_dataListArr[3] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }
    return 0;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(12,0, SCREEN_W-2*12, SCREEN_H-348) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.showsVerticalScrollIndicator = NO;
       
    }
    return _tableView;
}

@end
