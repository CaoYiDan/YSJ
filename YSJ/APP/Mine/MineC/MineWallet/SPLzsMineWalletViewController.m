//
//  SPLzsMineWalletViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/12/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsMineWalletViewController.h"
#import "SPLzsMineWalletModel.h"
#import "SPRechargeVC.h"
#import "SPWalletDetailVCViewController.h"
@interface SPLzsMineWalletViewController ()<UITableViewDelegate,UITableViewDataSource>
//我的钱包底部分类
@property (nonatomic,strong) NSMutableArray * tableDetailArr;
@property (nonatomic,strong) NSMutableArray * tableContentArr;
@property (nonatomic,strong) NSArray * titleImageArr;
@property (nonatomic,strong) UIButton * committeBtn;
//主页面
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,copy)NSString * headImageStr;
@property(nonatomic,copy)NSString * nickStr;
@property(nonatomic,strong)UIImageView * headIV;
@property(nonatomic,strong)UILabel *nickNameLab;
@property(nonatomic,strong)UILabel *signatureLab;//充值总额
@property(nonatomic,copy)NSString * totalFeeStr;//总额
@property(nonatomic,copy)NSString * cell1Str;
@property(nonatomic,copy)NSString * cell2Str;
@property(nonatomic,copy)NSString * cell1DetailStr;
@end

@implementation SPLzsMineWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGBCOLOR(250, 250, 250);
    [self initNav];
    //[self initUI];
    //[self loadData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    for (UIView * viewTemp in self.headView.subviews) {
        
        [viewTemp removeFromSuperview];
    }
    
    
    [self.headView removeFromSuperview];
    
    [self.tableView removeFromSuperview];
    [self loadData];
    
}
#pragma mark - loadData
- (void)loadData{
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"accountUserId"];
    //[dict setObject:@"123456" forKey:@"sysAppId"];
    NSLog(@"%@ %@",dict,URLOfMineWallet);
    self.tableContentArr = [NSMutableArray arrayWithCapacity:0];
    
    //http://192.168.1.144:8080/xzbj-api-server/v1/user/wallet
    [[HttpRequest sharedClient]httpRequestPOST:URLOfMineWallet parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"我的钱包%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.headImageStr = responseObject[@"data"][@"headImg"];
        self.nickStr = responseObject[@"data"][@"nickName"];
        self.totalFeeStr = [responseObject[@"data"][@"totalFee"] stringValue];
        
        for (NSDictionary * tempDict in responseObject[@"data"][@"accounts"]) {
            
            if ([tempDict[@"accountName"] isEqualToString:@"保证金账户"]) {
                
                NSString * str = [NSString stringWithFormat:@"保证金&诚意金"];
                self.cell1Str = str;
                [self.tableContentArr addObject:str];
                self.cell1DetailStr = [NSString stringWithFormat:@"%@ 元",[tempDict[@"accountBalance"] stringValue]];
                [self.tableDetailArr addObject: tempDict[@"accountBalance"]];
            }else if ([tempDict[@"accountName"] isEqualToString:@"现金账户"]){
                
                NSString * str = [NSString stringWithFormat:@"资金明细"];
                self.cell2Str = str;
                [self.tableDetailArr addObject:@" "];
                [self.tableContentArr addObject:str];
            }
            //            else if ([tempDict[@"accountName"] isEqualToString:@"保证金账户"]){
            //
            //                NSString * str = [NSString stringWithFormat:@"我的保证金 %@元",tempDict[@"accountBalance"]];
            //                [self.tableContentArr addObject:str];
            //            }
        }
        
        [self initUI];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"dsd");
        
    }];
    
}

#pragma mark -  initUI
- (void)initUI{
    
    //self.tableDetailArr = @[@"查看充值明细",@"查看保证金明细",@"查看明细",@"查看明细"];
    self.titleImageArr = @[@"wd_qb_cz",@"wd_qb_bzj",@"wd_qb_sr",@"wd_qb_zc"];
    //[self.tableContentArr addObject:@"我的充值 200元"];
    //[self.tableContentArr addObject:@"我的保证金 0元"];
    //[self.tableContentArr addObject:@"我的收入 0元"];
    //[self.tableContentArr addObject:@"我的支出 0元"];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H-120) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.backgroundColor = WC;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    UIImageView * imageIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wd_01"]];
    self.headView.frame = CGRectMake(0, 0, SCREEN_W, 190);
    imageIV.frame = self.headView.frame;
    imageIV.contentMode = UIViewContentModeScaleAspectFill;
    //[self.headView insertSubview:imageIV atIndex:0];
    
    self.tableView.tableHeaderView = self.headView;
    
    
    [self.view addSubview:self.tableView];
    UIView * footerView = [[UIView alloc]init];
    self.tableView.tableFooterView = footerView;
    
    self.committeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.committeBtn.frame = CGRectMake(20, SCREEN_H-120, SCREEN_W-40, 40);
    
    [self.committeBtn setBackgroundColor:RGBCOLOR(249, 28, 82)];
    [self.committeBtn setTitle:@"去充值" forState:UIControlStateNormal];
    self.committeBtn.clipsToBounds = YES;
    self.committeBtn.layer.cornerRadius = 4;
    [self.view addSubview:self.committeBtn];
    [self.committeBtn addTarget:self action:@selector(committeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self getHeadViewDetaiModel:nil];
    
}
#pragma mark -  committeBtnClick 去充值
- (void)committeBtnClick{
    
    SPRechargeVC *vc = [[SPRechargeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - headViewDetail
- (void)getHeadViewDetaiModel:(SPLzsMineWalletModel *)model{
    
    //头像
    UIImageView * imageView = [[UIImageView alloc]init];
    //imageView.backgroundColor = MAINCOLOR;
    self.headIV = imageView;
    //imageView.userInteractionEnabled= YES;
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 30;
    [self.headView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.offset(SCREEN_W/2-30);
        make.width.offset(60);
        make.height.offset(60);
    }];
    if (self.headImageStr.length) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.headImageStr]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        //[self.detailsBtn setImage:[UIImage imageNamed:@"me_xq"] forState:UIControlStateNormal];
    }else{
        
        imageView.contentMode = UIViewContentModeCenter;
        imageView.image = [UIImage imageNamed:@"boy_image"];
        //NSLog(@"%@",self.gender);
        //        if ([self.gender intValue]==1) {
        //
        //
        //        }else{
        //
        //            imageView.image = [UIImage imageNamed:@"girl_image"];
        //        }
    }
    
    
    //昵称
    self.nickNameLab = [[UILabel alloc]init];
    self.nickNameLab.text = self.nickStr;
    self.nickNameLab.textColor = RGBCOLOR(160, 160, 160);
    self.nickNameLab.textAlignment = NSTextAlignmentCenter;
    self.nickNameLab.font = [UIFont boldSystemFontOfSize:15];
    self.nickNameLab.text = self.nickStr;//@"我不是靠脸吃饭";
    [self.headView addSubview:self.nickNameLab];
    
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.left.offset(SCREEN_W/2-150);
        make.width.offset(300);
        make.height.offset(20);
        
    }];
    
    
    
    //签名
    
    self.signatureLab = [[UILabel alloc]init];
    
    //    if (self.signatureStr.length>0) {
    //        self.signatureLab.text = self.signatureStr;
    //    }else{
    //
    //        self.signatureLab.text = @"这家伙很懒,没有个性签名~";
    //    }
    self.signatureLab.text = self.totalFeeStr;//@"666.66";
    self.signatureLab.textColor =RGBCOLOR(40, 40, 40);
    self.signatureLab.textAlignment = NSTextAlignmentCenter;
    self.signatureLab.font = [UIFont boldSystemFontOfSize:18];
    
    self.signatureLab.numberOfLines = 1;//表示label可以多行显示UILineBreakModeCharacterWrap
    
    //self.signatureLab.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，与上面的计算保持一致。
    
    [self.headView addSubview:self.signatureLab];
    
    [self.signatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nickNameLab.mas_bottom).offset(15);
        make.left.offset (SCREEN_W/2-140);
        make.width.offset(280);
        make.height.offset(20);
        
    }];
    
    UILabel * allMoneyLab = [[UILabel alloc]init];
    allMoneyLab.textColor =RGBCOLOR(160,160,160);
    allMoneyLab.textAlignment = NSTextAlignmentCenter;
    allMoneyLab.font = [UIFont systemFontOfSize:15];
    allMoneyLab.text = @"余额(元)";
    allMoneyLab.numberOfLines = 1;
    
    [self.headView addSubview:allMoneyLab];
    
    [allMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.signatureLab.mas_bottom).offset(5);
        make.left.offset (SCREEN_W/2-140);
        make.width.offset(280);
        make.height.offset(20);
        
    }];
    
    UIView * grayView = [[UIView alloc]init];
    [self.headView addSubview:grayView];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(allMoneyLab.mas_bottom).offset(5);
        make.left.offset(0);
        make.width.offset(SCREEN_W);
        make.height.offset(20);
    }];
    grayView.backgroundColor = self.view.backgroundColor =RGBCOLOR(250, 250, 250);
    
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.tableContentArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * mineWalletCell = @"mineWalletCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mineWalletCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mineWalletCell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.tableContentArr[indexPath.row]];
    //    NSRange grayRange = NSMakeRange(0, [[noteStr string] rangeOfString:@" "].location);
    //
    //    [noteStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(65, 65, 65) range:grayRange];
    if (indexPath.row==0) {
        cell.textLabel.text = self.cell1Str;
    }else if(indexPath.row==1){
        
        cell.textLabel.text = self.cell2Str;
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    //cell.textLabel.attributedText = noteStr;
    if (indexPath.row==0) {
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = self.cell1DetailStr;
    }
    
    
    
    cell.imageView.image = [UIImage imageNamed:self.titleImageArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row==0) {
        
        //        SPWalletDetailVCViewController * detailVC = [[SPWalletDetailVCViewController alloc]init];
        //        detailVC.titleStr = @"充值明细";
        //        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if (indexPath.row ==1){
        SPWalletDetailVCViewController * detailVC = [[SPWalletDetailVCViewController alloc]init];
        detailVC.titleStr = @"充值明细";
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if (indexPath.row ==2){
        
        
    }else if (indexPath.row ==3){
        
        
    }
}

#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = @"我的钱包";
    self.titleLabel.textColor = [UIColor blackColor];
    
    //[self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -  rightButtonClick
- (void)rightButtonClick{
    
    
    
}

#pragma mark -  lazyLoad
- (UIView *)headView{
    
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 160)];
        _headView.backgroundColor = WC;
    }
    return _headView;
}

//cell内容加钱数
- (NSMutableArray *)tableContentArr{
    
    if (!_tableContentArr) {
        _tableContentArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _tableContentArr;
    
}

- (NSMutableArray *)tableDetailArr{
    
    if (!_tableDetailArr) {
        _tableDetailArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _tableDetailArr;
    
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

