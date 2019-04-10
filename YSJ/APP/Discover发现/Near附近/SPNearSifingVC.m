//
//  SPNearSifingVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNearSifingVC.h"
#import "SPLevelView.h"
#import "SPLevelModel.h"
#import "SPPopAgeChosedView.h"
#import "SPsiftingCell.h"
#import "SPSiftingKungFu.h"
#import "AddressViewController.h"

@interface SPNearSifingVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)SPSiftingKungFu *kungFuView;

@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic, strong)SPLevelView *levelView;
@property(nonatomic, strong)NSMutableArray *levleArr;
//技能参数数组
@property(nonatomic, strong)NSMutableArray *wugongArr;
//年龄参数
@property(nonatomic, copy)NSString *ageParameter;
//年龄字段
@property(nonatomic, copy)NSString *ageStr;

@property(nonatomic, strong)NSString *city;

@property(nonatomic, strong)UIView *indexPath0View;

@property(nonatomic,strong)SPPopAgeChosedView *ageView;
@end

@implementation SPNearSifingVC

{
    NSArray *_textArr;
    UIButton *_man;
    UIButton *_girl;
    NSDictionary *_ageParameterDict;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self config];
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:[self siftingBtn]];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)config{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = @"筛选";
    
    /** 初始化一些数据*/
    _textArr = @[@"年龄",@"技能",@"城市",@"个人标签",@""];
    self.city = @"";
    _levleArr  = @[].mutableCopy;
    _wugongArr = @[].mutableCopy;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choseNeadrSiftingCity:) name:NotificationChoseNearSiftingCity object:nil];
}

#pragma  mark  等级选择界面

-(SPLevelView *)levelView{
    if (!_levelView) {
        _levelView = [[SPLevelView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_levelView];
    }
    return _levelView;
}

#pragma  mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPsiftingCell*cell = [tableView dequeueReusableCellWithIdentifier:@"sifting"];
    if (cell==nil) {
        cell = [[SPsiftingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sifting"];
        
        UIView *line =[[UIView  alloc]initWithFrame:CGRectMake(4, 39, SCREEN_W-4, 1)];
        line.backgroundColor = BASEGRAYCOLOR;
        [cell.contentView addSubview:line];
    }
    if (indexPath.row==0) {
        //男女选择
        [cell addSubview:[self indexPath0View]];
    }else{

    cell.textLabel.font = font(15);
    cell.textLabel.text = _textArr[indexPath.row-1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"n_%ld",(long)indexPath.row]]];
        
        if (indexPath.row==1) {
            //年龄
            cell.detailLabel.text = self.ageStr;
            
        }else if (indexPath.row==2) {
            //武功
            cell.detailLabel.text = [_wugongArr componentsJoinedByString:@" / "];
            
        }else if (indexPath.row==3) {
            //城市
            cell.detailLabel.text = self.city;
        }
    }
    return cell;
}

-(NSString *)getLevelString{
    //等级
    NSString *detailText = @"";
    int i = 0;
    for (SPLevelModel *model in _levleArr) {
        if (i==0) {
            detailText = model.name;
        }else{
            detailText =[detailText stringByAppendingString:[NSString stringWithFormat:@" / %@",model.name]];
        }
        i++;
    }
    return detailText;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.ageView.originY = 0;
        }];
        
    }else if (indexPath.row ==2){
    
        [UIView animateWithDuration:0.3 animations:^{
            self.kungFuView.originY = 0;
        }];
        
    }else if (indexPath.row == 3){
        
//        [self presentToCityChoseVc];
    }
}

-(void)popLeveleView{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.levelView.originY = 0;
    }completion:^(BOOL finished) {
        [self.levelView setAnimtion];
    }];
    
    //选择回调
    WeakSelf;
    self.levelView.levelBlock = ^(NSArray *chosedArr){
        weakSelf.levleArr = (NSMutableArray *)chosedArr;
        [weakSelf.tableView reloadData];
    };
}

-(void)presentToCityChoseVc{
    
    //地址选择器
    AddressViewController *addressVC = [[AddressViewController alloc]init];
    addressVC.type = 2;
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:addressVC];
    [self presentViewController:naVC animated:YES completion:nil];
}

#pragma  mark  选择武功界面

-(SPSiftingKungFu *)kungFuView{
    if (!_kungFuView) {
        _kungFuView = [[SPSiftingKungFu alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_kungFuView];
        WeakSelf;
        _kungFuView.siftingKungFuBlock = ^(NSMutableArray *resultArr){
            _wugongArr = resultArr;
            [weakSelf.tableView reloadData];
        };
    }
    return _kungFuView;
}

#pragma  mark  //选择年龄view

-(SPPopAgeChosedView *)ageView{
    if (!_ageView) {
        _ageView= [[SPPopAgeChosedView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_ageView];
        
        WeakSelf;
        
        _ageView.block = ^(NSString *ageStr,NSString *ageParamater){
            weakSelf.ageStr = ageStr;
            weakSelf.ageParameter = ageParamater;
            [weakSelf.tableView reloadData];
        };
    }
    return _ageView;
}

#pragma  makr 男 女 选择view

-(UIView*)indexPath0View{
    
    if (!_indexPath0View) {
        
        UIView *baseCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 39)];
        
        [baseCellView addSubview:[self addButtonWithText:@"男" frame:CGRectMake(SCREEN_W/2-100, 0, 100, 39)]];
        
        [baseCellView addSubview:[self addButtonWithText:@"女" frame:CGRectMake(SCREEN_W/2, 0, 100, 39)]];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2-0.5, 4, 1, 32)];
        line.backgroundColor = BASEGRAYCOLOR;
        [baseCellView addSubview:line];
        
        _indexPath0View = baseCellView;
    }
    
    return _indexPath0View;
}

-(UIButton *)addButtonWithText:(NSString *)text frame:(CGRect)frame{
    UIButton *sexBtn = [[UIButton alloc]initWithFrame:frame];
    sexBtn.titleLabel.font = kFontNormal;
    [sexBtn setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"] forState:0];
    [sexBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"] forState:UIControlStateSelected];
    [sexBtn setTitleColor:[UIColor blackColor] forState:0];
    sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    sexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -42);
    [sexBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [sexBtn setTitle:text forState:0];
    
    if ([text isEqualToString:@"女"]) {
        sexBtn.tag = 1;
        _girl = sexBtn;
        sexBtn.selected = YES;
    }else{
        sexBtn.tag = 0;
        _man = sexBtn;
    }
    
    return sexBtn;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.rowHeight = 40;
        
    }
    return _tableView;
}

#pragma  mark 男女点击事件
-(void)click:(UIButton *)btn{
   
    btn.selected = !btn.isSelected;
    if (btn.tag ==0) {
        _girl.selected = !btn.isSelected;
    }else{
         _man.selected = !btn.isSelected;
    }
}

#pragma  mark 筛选按钮

-(UIButton *)siftingBtn{
    UIButton *sifting = [[UIButton alloc]initWithFrame:CGRectMake(40, IS_IPHONE_X?SCREEN_H-70-34:SCREEN_H-70, SCREEN_W-80, 40)];
    sifting.layer.cornerRadius = 20;
    sifting.clipsToBounds = YES;
    sifting.titleLabel.font = font(14);
    sifting.layer.borderColor = RGBCOLOR(26, 134, 222).CGColor;
    [sifting setTitleColor:RGBCOLOR(26, 134, 222) forState:0];
    sifting.layer.borderWidth = 1.5f;
    [sifting setTitle:@"筛  选" forState:0];
    [sifting addTarget:self action:@selector(sifting) forControlEvents:UIControlEventTouchDown];
    return sifting;
}

#pragma  mark  筛选按钮点击事件 (1.保存筛选信息，2.pop)

-(void)sifting{
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    
    [dict setObject:_city forKey:@"city"];
    
    [dict setObject:_man.isSelected?@"1":@"0" forKey:@"gender"];
    
    [dict setObject:[self getLevelArr] forKey:@"levelList"];
    
    NSDictionary *locationDic  = @{@"lat":[StorageUtil getUserLat],@"lon":[StorageUtil getUserLon]};
    NSLog(@"%@",locationDic);
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    
    [dict setObject:_wugongArr forKey:@"skillList"];
    
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    if (!isEmptyString(self.ageParameter)) {
         [dict setObject:self.ageParameter forKey:@"ageRange"];
    }
   
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrladdSearchHistory parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
    
        [self.navigationController popViewControllerAnimated:YES];
        
        //发布通知
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSiftingForNear object:dict];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
}

-(NSMutableArray *)getLevelArr{
    NSMutableArray *levelList =  @[].mutableCopy;
    for (SPLevelModel *levleModel in _levleArr) {
        [levelList addObject:@(levleModel.level)];
    }
    return levelList;
}

#pragma  mark  筛选城市 通知回调事件

-(void)choseNeadrSiftingCity:(NSNotification *)notify{

    _city = notify.object;
    [self.tableView reloadData];
}

@end
