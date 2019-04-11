//
//  AddressViewController.m
//  AddressDemo
//
//  Created by 张武星 on 15/5/29.
//  Copyright (c) 2015年 worthy.zhang. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;//当前选中的NSIndexPath

@property(nonatomic ,strong) UIView *bottomView;//底部确定按钮
@property(nonatomic ,strong) UILabel *result;//结果
@end

@implementation AddressViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self configureData];
    [self configureViews];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;


}

-(void)configureData{
    if (self.displayType == kDisplayProvince) {
        //从文件读取地址字典
        NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"address1" ofType:@"plist"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
        
        self.provinces = [dict objectForKey:@"address"];
    }
}

-(void)configureViews{
    if (self.displayType == kDisplayProvince) { //只在选择省份页面显示取消按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    }
    self.view.backgroundColor =BASEGRAYCOLOR;
    CGRect frame =CGRectMake(0, 0, SCREEN_W, SCREEN_H2-50-SafeAreaTopHeight-SafeAreaBottomHeight);
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-50-SafeAreaTopHeight-SafeAreaBottomHeight, SCREEN_W, 50+SafeAreaBottomHeight)];
    self.bottomView.backgroundColor = MyBlueColor;
    [self.view addSubview:self.bottomView];
    
    self.result = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-100, 5, 200, 40)];
    self.result.textAlignment = NSTextAlignmentCenter;
    self.result.textColor = [UIColor whiteColor];
    NSString *resultStr = @"";
    NSLog(@"%@",self.selectedProvince);
    if (!isEmptyString(self.selectedProvince)) {
       resultStr= [resultStr stringByAppendingString:self.selectedProvince];
    }
    if (!isEmptyString(self.selectedCity)) {
       resultStr= [resultStr stringByAppendingString:self.selectedCity];
    }
    if (!isEmptyString(self.selectedArea)) {
       resultStr= [resultStr stringByAppendingString:self.selectedArea];
    }
    NSLog(@"%@",resultStr);
    self.result.text = resultStr;
    [self.bottomView addSubview:self.result];
    
    UIButton * confirm = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2+100, 5, 60, 40)];
    confirm.backgroundColor = [UIColor whiteColor];
    [confirm setTitleColor:[UIColor blackColor] forState:0];
    confirm.layer.cornerRadius =20;
    confirm.clipsToBounds = YES;
    confirm.titleLabel.font = font(14);
    [confirm setTitle:@"确定" forState:0];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchDown];
    [self.bottomView addSubview:confirm];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",self.provinces.count);
    if (self.displayType == kDisplayProvince) {
        return self.provinces.count;
    }else if (self.displayType == kDisplayCity){
        return self.citys.count;
    }else{
        return self.areas.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        if (self.displayType == kDisplayArea) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (self.displayType == kDisplayProvince) {
        NSDictionary *province = self.provinces[indexPath.row];
        NSString *provinceName = [province objectForKey:@"name"];
        NSLog(@"%@",provinceName);
        cell.textLabel.text= provinceName;
    }else if (self.displayType == kDisplayCity){
        NSDictionary *city = self.citys[indexPath.row];
        NSString *cityName = [city objectForKey:@"name"];
        cell.textLabel.text= cityName;
    }else{
        cell.textLabel.text= self.areas[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"unchecked"];
    }
    cell.textLabel.font = kFontNormal_14;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.displayType == kDisplayProvince) {
        NSDictionary *province = self.provinces[indexPath.row];
        NSArray *citys = [province objectForKey:@"sub"];
        self.selectedProvince = [province objectForKey:@"name"];
        //构建下一级视图控制器
        AddressViewController *cityVC = [[AddressViewController alloc]init];
        cityVC.displayType = kDisplayCity;//显示模式为城市
        cityVC.citys = citys;
        cityVC.type = self.type;
        cityVC.selectedProvince = self.selectedProvince;
        [self.navigationController pushViewController:cityVC animated:YES];
    }else if (self.displayType == kDisplayCity){
        
        
        NSDictionary *city = self.citys[indexPath.row];
        self.selectedCity = [city objectForKey:@"name"];
        
        if (self.type ==1 || self.type == 2) {
             self.result.text = [self.result.text stringByAppendingString:[NSString stringWithFormat:@" %@",self.selectedCity]];
            [self confirm];
        }else{
        
        NSArray *areas = [city objectForKey:@"sub"];
        //构建下一级视图控制器
        AddressViewController *areaVC = [[AddressViewController alloc]init];
            
        areaVC.displayType = kDisplayArea;//显示模式为区域
        areaVC.areas = areas;
        areaVC.selectedCity = self.selectedCity;
        areaVC.selectedProvince = self.selectedProvince;
        [self.navigationController pushViewController:areaVC animated:YES];
        }
    }
    else{
       
        self.selectedArea = self.areas[indexPath.row];
        self.result.text = [self .result.text stringByAppendingString:self.selectedArea];
        //确定
        [self confirm];
    }
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//确定
-(void)confirm{
    if(self.type == 1){
        
        [[NSNotificationCenter defaultCenter]postNotificationName: NotificationChoseOfferCity object:self.result.text];
        
    }else if(self.type == 2){
        
        [[NSNotificationCenter defaultCenter]postNotificationName: NotificationChoseNearSiftingCity object:self.result.text];
   
    }else{
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationChoseCity object:self.result.text];
       
    }
     [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
