//
//  SPMineIdentificationVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/12/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMineIdentificationVC.h"
#import "SPMineIdentifiDetailVC.h"
@interface SPMineIdentificationVC ()<UITableViewDataSource, UITableViewDelegate>
{
    
    int _pageNum;
    
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *selectArray;
@property (nonatomic, strong)UIButton * secondBtn;
@property (nonatomic, strong)UIButton * firstBtn;
@property (nonatomic, strong)UILabel * haveNoMessageLab;

@end

@implementation SPMineIdentificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(245, 245, 245, 1);
    [self initNav];
    //[self initUI];
    //[self loadData];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView removeFromSuperview];
    [self loadData];
    
}

#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//
//    NSString * kurl;
//
//    kurl = SystemNotiUrl;
//
//    [dict setObject:@(_pageNum) forKey:@"pageNum"];
//    [dict setObject:@10 forKey:@"pageSize"];
//    [dict setObject:[StorageUtil getCode] forKey:@"reciver"];
    NSString * str = [NSString stringWithFormat:@"%@%@",URLOfIdentifyListGet,[StorageUtil getCode]];
    NSLog(@"%@",str);
    self.dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",URLOfIdentifyListGet,[StorageUtil getCode]] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //[self.dataSourceArray addObject:responseObject[@"phoneStatus"]];
        //[self.dataSourceArray addObject:responseObject[@"identStatus"]];
        //[self.dataSourceArray addObject:responseObject[@"skillStatus"]];
         NSLog(@"%@",responseObject);
        //[self.selectArray addObject:responseObject[@"data"][@"phoneStatus"]];
        //[self.selectArray addObject:responseObject[@"data"][@"identStatus"]];
        //[self.selectArray addObject:responseObject[@"isSkill"]];
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            
            [self.dataSourceArray addObject:tempDict];
        }
        [self initUI];
        //[self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        //Toast(error);
    }];
    
    
}
#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifiCell = @"identifiCell";
    // dequeueReusableCellWithIdentifier cell重复内容的时候用下面这个方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifiCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    if (self.dataSourceArray) {
        
        cell.textLabel.text = self.dataSourceArray[indexPath.row][@"key"];
        cell.textLabel.textColor = [UIColor blackColor];
        
        if ([self.dataSourceArray[indexPath.row][@"value"] isEqualToString:CERTIFIED]) {
                    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
                    cell.detailTextLabel.text = @"已认证";
                }else if ([self.dataSourceArray[indexPath.row][@"value"] isEqualToString:@"TOBEAUDITED"]) {
                    cell.detailTextLabel.textColor = [UIColor redColor];
                    cell.detailTextLabel.text = @"待审核";
                }else if ([self.dataSourceArray[indexPath.row][@"value"] isEqualToString:@"CERTIFIEDREFUSAL"]) {
                    cell.detailTextLabel.textColor = [UIColor redColor];
                    cell.detailTextLabel.text = @"认证拒绝";
                }else if ([self.dataSourceArray[indexPath.row][@"value"] isEqualToString:@"UNCERTIFIED"]){
                    cell.detailTextLabel.textColor = [UIColor redColor];
                    cell.detailTextLabel.text = @"未认证";
                }
        
    }
    
    
    //cell.detailTextLabel.text = self.selectArray[indexPath.row];
    /*
     身份认证状态 已认证：CERTIFIED，待审核：TOBEAUDITED，未认证：UNCERTIFIED，认证拒绝：CERTIFIEDREFUSAL
     */
    //NSLog(@"%@",self.selectArray[indexPath.row]);
//
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSourceArray[indexPath.row][@"key"] isEqualToString:@"身份认证"]) {
        SPMineIdentifiDetailVC * detailVC = [[SPMineIdentifiDetailVC alloc]init];
        detailVC.identifiStr = self.dataSourceArray[indexPath.row][@"value"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    //[self.selectArray addObject:self.dataSourceArray[indexPath.row] ];
    
    
}
#pragma mark - initUI
- (void)initUI{
    
//    [self.dataSourceArray addObject:@"手机认证"];
//    [self.dataSourceArray addObject:@"身份认证"];
//    [self.selectArray addObject:@"已认证"];
//    [self.selectArray addObject:@"未认证"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 88) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces=NO; 
    self.tableView.backgroundColor = WC;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    UIView * footView = [[UIView alloc]init];
    self.tableView.tableFooterView = footView;
    
}
#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = @"认证中心";
    self.titleLabel.textColor = [UIColor blackColor];
    
    //[self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
    //[self.rightButton setTitle:@"" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -  rightButtonClick
- (void)rightButtonClick{
    
    
    
}
#pragma mark - lazyLoad
- (NSMutableArray * )dataSourceArray{
    
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSourceArray;
    
}

- (NSMutableArray * )selectArray{
    
    if (!_selectArray) {
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectArray;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
