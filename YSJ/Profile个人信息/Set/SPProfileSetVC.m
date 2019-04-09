//
//  SPNearSifingVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/12.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPProfileSetVC.h"

#import "SPBaseEditVC.h"
#import "SPShareView.h"
#import "SPsiftingCell.h"

@interface SPProfileSetVC ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic ,strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *levleArr;
@property(nonatomic, strong)NSMutableArray *wugongArr;

@property(nonatomic, strong)UIView *indexPath0View;
@property(nonatomic,strong)SPShareView *shareView;
@end

@implementation SPProfileSetVC

{
    NSArray *_textArr;
    UIButton *_rightBtn;
    UIButton *_leftBtn;
    
    BOOL _notReadMe;
    BOOL _notReadOne;
    NSString *_remark;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self config];
    
    [self getMySet];
    
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma  mark - -----------------获取我之前的设置-----------------

-(void)getMySet{
    NSMutableDictionary *dict = @{}.mutableCopy;

    [dict setObject:self.code forKey:@"targetCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLookAtPrivacyForOne parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        _remark = responseObject[@"data"][@"remark"];
        _notReadOne = [responseObject[@"data"][@"notReadOne"] boolValue];
        _notReadMe = [responseObject[@"data"][@"notReadMe"] boolValue];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)config{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = @"资料设置";
    
    /** 初始化一些数据*/
    _textArr = @[@"设置备注",@"把他推荐给好友",@"是否举报"];
    
    _remark = @"";
    
    [self.rightButton setTitle:@"保存" forState:0];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:0];
    [self addRightTarget:@selector(save)];
}

#pragma  mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  4;
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
        //动态设置
        [cell addSubview:[self indexPath0View]];

        _leftBtn.selected = _notReadMe;
        _rightBtn.selected = _notReadOne;
        
    }else{
        cell.textLabel.font = font(15);
        cell.textLabel.text = _textArr[indexPath.row-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"zl_%ld",(long)indexPath.row]]];
        if (indexPath.row==1) {
            cell.detailLabel.text = _remark;
        }
        if(indexPath.row==3){
            
            [cell.imageView setImage:[UIImage imageNamed:@"lb_r11_c1"]];
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        //工作领域
        SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
//        NSString *code =@"domain";//关键词
        vc.codeText = self.code;
        vc.formMyCenter = YES;
        vc.titletText = @"设置备注";
        vc.placeHoder = _remark;
        vc.perfaceBlock = ^(NSDictionary *dict){
            _remark = dict[@"remake"];
            [self.tableView reloadData];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row ==2){
        
        [UIView animateWithDuration:0.4 animations:^{
            [self.view addSubview:self.shareView];
            self.shareView.shareImg = self.shareImg;
            self.shareView.hidden = NO;
            self.shareView.originY = 0;
        }];
       
    }else if (indexPath.row==3){
        UIAlertAction * alertAc = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSMutableDictionary *dic = @{}.mutableCopy;
//            [dic setObject:@"" forKey:@"reportContent"];
            [dic setObject:[StorageUtil getCode] forKey:@"code"];
            [dic setObject:self.code forKey:@"reportCode"];
            NSLog(@"%@",dic);
            [[HttpRequest sharedClient]httpRequestPOST:kUrlReport parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                NSLog(@"%@",responseObject);
                Toast(@"我们已将信息发送到我们的检测中心");
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }];
        UIAlertAction * alertNo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"是否举报" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:alertAc];
        [alertVC addAction:alertNo];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
}

#pragma  makr 动态权限设置
-(UIView*)indexPath0View{
    if (!_indexPath0View) {
        
        UIView *baseCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 39)];
        
        [baseCellView addSubview:[self addButtonWithText:@"不让他看我的动态" frame:CGRectMake(SCREEN_W/2-100, 0, 100, 39) index:2]];
        
        [baseCellView addSubview:[self addButtonWithText:@"不看他的动态" frame:CGRectMake(SCREEN_W/2, 0,SCREEN_W/2 , 39) index:1]];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2-0.5, 4, 1, 32)];
        line.backgroundColor = BASEGRAYCOLOR;
        [baseCellView addSubview:line];
        
        _indexPath0View = baseCellView;
    }
    
    return _indexPath0View;
}

-(UIButton *)addButtonWithText:(NSString *)text frame:(CGRect)frame index:(NSInteger)index{
    UIButton *sexBtn = [[UIButton alloc]initWithFrame:frame];
    sexBtn.titleLabel.font = kFontNormal;
    [sexBtn setImage:[UIImage imageNamed:@"grxx6tc_r3_c1"] forState:0];
    [sexBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"] forState:UIControlStateSelected];
    [sexBtn setTitleColor:[UIColor blackColor] forState:0];
    if (index==2) {
        _leftBtn = sexBtn;
        if (kiPhone5) {
            sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -120, 0, 0);
            sexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -172);
        }else{
        sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -140, 0, 0);
        sexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -142);
        }
    }else{
        _rightBtn = sexBtn;
        sexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
        sexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -145);
    }
    sexBtn.tag = index;
    [sexBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [sexBtn setTitle:text forState:0];
    
    return sexBtn;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10, SCREEN_W, SCREEN_H2-10-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 44;
        
    }
    return _tableView;
}

#pragma  mark 动态权限设置点击事件
-(void)click:(UIButton *)btn{
     btn.selected = !btn.isSelected;
//    NSMutableDictionary *dic  = @{}.mutableCopy;
//   
//    [dic setObject:self.code forKey:@"targetCode"];
//    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];
////    0 黑名单
////    1 我不查看他的动态
////    2 他不能查看我的动态
//    [dic setObject:@(btn.tag) forKey:@"relation"];
//
//    NSString *url = btn.isSelected?kUrlPrivacyDelete:kUrlPrivacyAdd;
//   
//    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
//        NSLog(@"%@",responseObject);
//        btn.selected = !btn.isSelected;
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
}

#pragma  mark  筛选按钮点击事件 (1.保存筛选信息，2.pop)

-(void)sifting{
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    
//    [dict setObject:_city forKey:@"city"];
    
//    [dict setObject:_man.isSelected?@"1":@"0" forKey:@"gender"];
    
//    [dict setObject:[self getLevelArr] forKey:@"levelList"];
    
//    NSDictionary *locationDic  = @{@"lat":[StorageUtil getUserLat],@"lon":[StorageUtil getUserLon]};
//    
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    
    [dict setObject:_wugongArr forKey:@"skillList"];
    
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrladdSearchHistory parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        //发布通知
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationSiftingForNear object:dict];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma  mark - -----------------保存----------------

-(void)save{
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    
    [dict setObject:@(_leftBtn.selected) forKey:@"notReadMe"];
    [dict setObject:@(_rightBtn.selected) forKey:@"notReadOne"];
    [dict setObject:_remark forKey:@"remark"];
    [dict setObject:self.code forKey:@"targetCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlUpdatePrivacyForOne parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        //        _shareView.shareImg = self..image;
    }
    return _shareView;
}
@end
