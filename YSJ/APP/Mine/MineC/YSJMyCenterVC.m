//
//  YSJMyCenterVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/10.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJMyCenterVC.h"

@interface YSJMyCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@end

@implementation YSJMyCenterVC



#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@"兴趣设置",@"认证中心",@"应用分享"];
    self.titleImageArr = @[@"wd_sz_xq",@"wd_sz_rz",@"wd_sz_fx"];
    
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else{
        
        return self.titleArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * mineCell = @"mineCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mineCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section==0) {
        
        cell.textLabel.text = @"我的钱包";
        cell.imageView.image = [UIImage imageNamed:@"wd_qb"];
    }else{
        
        cell.textLabel.text = self.titleArr[indexPath.row];
        
        cell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
#pragma mark CustomDelegate

#pragma mark event response

#pragma mark private methods

#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-KBottomHeight);
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}


@end
