//
//  SPLocationSearchVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLocationSearchVC.h"
#import "SPChosedCell.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface SPLocationSearchVC ()<UISearchBarDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,copy)NSString *resultStr;
@property(nonatomic ,strong)AMapSearchAPI*search;
@property(nonatomic ,strong)UISearchBar *searchBar;
@end

@implementation SPLocationSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = @"搜索附近位置";
    
    [self.view addSubview:self.tableView];

    [self configMapServices];

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
    
    AMapPOI *obj =  self.listArray[indexPath.row];
    cell.textLabel.text = obj.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self searchView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapAOI *api = self.listArray[indexPath.row];
    !self.searchBlock?:self.searchBlock(api.name);
  
    [self.navigationController popToViewController:self.navigationController.viewControllers[1]  animated:YES];
}

#pragma  mark - -----------------POI 搜索回调delegate-----------------

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    self.listArray = (NSMutableArray *)response.pois;
    
    [self.tableView reloadData];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma  mark - -----------------searchBardelegate-----------------

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchClick];
}

#pragma  mark - -----------------action-----------------

-(void)searchClick{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = self.searchBar.text;
    request.city                = [StorageUtil getUserAddresssDict][@"City"];
    
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma  mark - -----------------setter-----------------

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SPChosedCell class] forCellReuseIdentifier:SPChosedCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    }
    return _tableView;
}

-(void)configMapServices{
    
    [AMapServices sharedServices].apiKey = @"e2eea3c13d873d7b2ae0bb8805b53446";
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
}

-(UIView *)searchView{
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 42)];
    base.backgroundColor = [UIColor whiteColor];
    
    UISearchBar *searchField = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 1, SCREEN_W-75, 40)];
    self.searchBar = searchField;
    searchField.barStyle = UISearchBarStyleDefault;
    searchField.backgroundColor = [UIColor clearColor];
    searchField.placeholder = @"搜索附近位置";
    searchField.delegate = self;
    [base addSubview:searchField];
    
    UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-70,2, 65, 38)];
    btn.backgroundColor = MyBlueColor;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    btn.titleLabel.font = font(14);
    [btn setTitle:@"搜索" forState:0];
    [btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    [base addSubview:btn];
    
    return base;
}
@end
