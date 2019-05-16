//
//  SPPublishLocationVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPublishLocationVC.h"
#import "SPLocationSearchVC.h"
#import "SPChosedCell.h"
////定位服务
//#import <CoreLocation/CoreLocation.h>

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface SPPublishLocationVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,AMapSearchDelegate,UITextFieldDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,copy)NSString *resultStr;
@property(nonatomic ,strong)AMapSearchAPI*search;
@end

@implementation SPPublishLocationVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.titleLabel.text = @"所在位置";
    
    [self.view addSubview:self.tableView];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //配置地图参数
    [self configMapServices];
    //配置搜索参数
    [self configPoiResquest];
    
}

-(void)selectedTableViewIndex{
    if (_selectedIndex ==-1) {
        return;
    }
    //选中
    NSIndexPath * index =  [NSIndexPath   indexPathForRow:self.selectedIndex inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:(UITableViewScrollPositionMiddle)];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPChosedCell*cell = [SPChosedCell cellWithTableView:tableView indexPath:indexPath];
    
    cell.textLabel.text =  self.listArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    return [self searchBtn];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *locationStr = @"";
    
    if(indexPath.row!=0){
        
    UITableViewCell *cell =[ tableView cellForRowAtIndexPath:indexPath];
        locationStr = cell.textLabel.text;
    }
    
    !self.publishLocationBlock?:self.publishLocationBlock(locationStr,indexPath.row);
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma  mark - -----------------搜索回调delegate-----------------

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) return;
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [self.listArray addObject:obj.name];
    }];
    
    [self.tableView reloadData];
    
    //选中选择的地点
    [self selectedTableViewIndex];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma  mark - -----------------action-----------------

-(void)searchClick{
    
    SPLocationSearchVC *vc = [[SPLocationSearchVC alloc]init];
    vc.searchBlock = ^(NSString *searchStr){
        !self.publishLocationBlock?:self.publishLocationBlock(searchStr,(-1));
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark ------------- setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
        [_listArray addObject:@"不显示位置"];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPChosedCell class] forCellReuseIdentifier:SPChosedCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.sectionFooterHeight = 0;
    
    }
    return _tableView;
}

-(void)configMapServices{
    
    [AMapServices sharedServices].apiKey = @"e2eea3c13d873d7b2ae0bb8805b53446";
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

-(void)configPoiResquest{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:[[StorageUtil getUserLat] floatValue]longitude:[[StorageUtil getUserLon] floatValue]];
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
}

-(UIView *)searchBtn{
    
    UIButton *base  = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, SCREEN_W, 40)];
    [base addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
    [searchImg setImage:[UIImage imageNamed:@"s_search"]];
    searchImg.userInteractionEnabled = NO;
    [base addSubview:searchImg];
    
    UILabel *searchLab = [[UILabel alloc]initWithFrame:CGRectMake(35, 1, 140, 40)];
    searchLab.font = font(14);
    searchLab.text = @"搜索附近位置";
    [base addSubview:searchLab];
    
    return base;
}
@end
