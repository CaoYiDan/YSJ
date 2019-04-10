//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPerfectViewController.h"
#import "SPMyProflieHeader.h"
#import "SPKungFuCell.h"
#import "SPKungFuModel.h"
#import "SPSixPhotoView.h"
#import "SPUser.h"

#import "SPMyTagVC.h"
#import "SPTagCell.h"
#import "SPKungFuCell.h"
#import "SPCommon.h"
#import "SPPerfecSexVC.h"
#import "BDImagePicker.h"
#import "SPPerfectNameVC.h"
#import "SPPerfectBirthDayVC.h"
#import "SPBaseEditVC.h"

#import "SPMyCenterCell.h"

@interface SPPerfectViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;

@property (nonatomic, strong) SPSixPhotoView *headerView;
@property(nonatomic ,strong)NSMutableArray *photosArr;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)NSArray *textArr;
@property(nonatomic ,strong)NSArray *imgArr;
@property(nonatomic,copy)NSString *imgChangeType;
@property(nonatomic,assign)NSInteger imgIndex;
/**<##><#Name#>*/
//@property(nonatomic, strong)SPUser *user;
@end

@implementation SPPerfectViewController

-(NSMutableArray *)photosArr{
    if (!_photosArr) {
        _photosArr = @[].mutableCopy;
    }
    return _photosArr;
}

#pragma  mark - lefe cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    self.textArr = @[@"性别",@"昵称",@"生日",@"工作经验",@"工作领域",@"行业",@"来自",@"经常出没",@"我的签名"];
    self.imgArr = @[@"c_sex",@"c_name",@"c_birthday",@"c_expersence",@"c_industry",@"c_hang",@"c_form",@"c_often",@"c_sign"];
    
    [self sNavigation];

    [self.view addSubview:self.tableView];
    
    [self getData];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)getData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dic setObject:[StorageUtil  getCode] forKey:@"code"];
    [dic setObject:[StorageUtil getCode] forKey:@"readerCode"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlProfileDetail parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"详细%@",responseObject);
        
        self.user = [SPUser mj_objectWithKeyValues:responseObject[@"data"]];

        [_tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         self.user = [[SPUser alloc]init];
    }];
}

#pragma  mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.textArr.count;
    }else if (section == 1) {
        return self.user.skills.count;
    }else{
        return self.user.tags.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        SPMyCenterCell*cell = [tableView dequeueReusableCellWithIdentifier:SPMyCenterCellID forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[SPMyCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPMyCenterCellID];
        }
        
        [cell.imageView setImage:[UIImage imageNamed:self.imgArr[indexPath.row]]];
        cell.textLabel.text = self.textArr[indexPath.row];
        cell.textLabel.font = kFontNormal;
        [cell setMyText: [self stringForIndex:indexPath.row]];
        
        return cell;
        
    }else if (indexPath.section == 1) {
        SPKungFuCell*cell = [tableView dequeueReusableCellWithIdentifier:SPKungFuCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPKungFuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPKungFuCellID];
        }
        SPKungFuModel *model1 = self.user.skills[indexPath.row];
        cell.model2 = model1;
        cell.indexRow2 = indexPath.row;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        SPTagCell*cell = [tableView dequeueReusableCellWithIdentifier:SPTagCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPTagCellID];
        }
        SPKungFuModel *model1 = self.user.tags[indexPath.row];
        [cell setMyCenterModel:model1];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 42;
    }else{
        
        SPKungFuModel *model1 = [[SPKungFuModel alloc]init];
        if (indexPath.section == 1) {
            model1 = self.user.skills[indexPath.row];
        }else{
            model1  =self.user.tags[indexPath.row];
        }
        return model1.subProperties.count/4*40+(model1.thirdLevelArr.count%4==0?0:1)*40;
    }
}

-(NSString *)stringForIndex:(NSInteger)row{
    NSString *contentText = @"";
    switch (row) {
        case 0:
            if (self.user.gender) {
                contentText = @"男";
            }else{
                contentText= @"女";
            }
            break;
        case 1:
            contentText = self.user.nickName;
            
            break;
        case 2:
            contentText = self.user.birthday;
            
            break;
        case 3:
            contentText = self.user.experience;
            
            break;
        case 4:
            contentText = self.user.domain;
            
            break;
        case 5:
            contentText =self.user.job;
            break;
        case 6:
            contentText =self.user.beFrom;
            break;
        case 7:
            contentText =self.user.haunt;
            break;
        case 8:
            contentText =self.user.signature;
            break;
        default:
            break;
    }
    
    if (isEmptyString(contentText)) {
        return @"请选择";
    }else{
        return contentText;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf;
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            SPPerfecSexVC *vc = [[SPPerfecSexVC alloc]init];
            vc.formMyCenter = YES;
            vc.isGirl = !self.user.gender;
            __weak typeof(self.user) weakUser = self.user;
            vc.perfaceBlock = ^(NSDictionary *dict){
                if ([dict[@"gender"] integerValue]==0) {
                    weakUser.gender = 0;
                }else{
                    weakUser.gender = 1;
                }
                
                //更新相关界面
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row ==1){
            SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
            vc.formMyCenter = YES;
            vc.user = self.user;
            vc.perfaceBlock = ^(NSDictionary *dict){
                
                weakSelf.user.nickName = dict[@"nickName"];
                weakSelf.user.beFrom = dict[@"beFrom"];
                weakSelf.user.haunt = dict[@"haunt"];
                //更新相关界面
                [weakSelf.tableView reloadData];
               
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row ==2){
            SPPerfectBirthDayVC *vc = [[SPPerfectBirthDayVC alloc]init];
            vc.user = self.user;
            vc.formMyCenter = YES;
            vc.perfaceBlock = ^(NSDictionary *dict){
                weakSelf.user.birthday= dict[@"birthday"];
                //更新相关界面
                [weakSelf.tableView reloadData];
                
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row ==3){
            //工作经验
            SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
            NSString *code =@"experience";//关键词
            vc.codeText = code;
            vc.formMyCenter = YES;
            vc.titletText = @"请输入您的工作经验";
            vc.placeHoder = self.user.experience;
            vc.perfaceBlock= ^(NSDictionary *dict){
                weakSelf.user.experience = dict[code];
                //更新相关界面
                [weakSelf.tableView reloadData];
                
            };
            [self.navigationController pushViewController:vc animated:YES];    }else if (indexPath.row ==4){
                //工作领域
                SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
                NSString *code =@"domain";//关键词
                vc.codeText = code;
                vc.formMyCenter = YES;
                vc.placeHoder = self.user.domain;
                vc.titletText = @"请输入您的工作领域";
                vc.perfaceBlock = ^(NSDictionary *dict){
                    weakSelf.user.domain = dict[code];
                    //更新相关界面
                    [weakSelf.tableView reloadData];
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row ==5){
                //行业
                SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
                NSString *code1 =@"job";//关键词
                vc.codeText = code1;
                vc.formMyCenter = YES;
                vc.titletText = @"请输入您的行业";
                vc.placeHoder = self.user.job;
                vc.perfaceBlock = ^(NSDictionary *dict){
                    weakSelf.user.job= dict[code1];
                    //更新相关界面
                    [weakSelf.tableView reloadData];
                   
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row ==6){
                //来自
                SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
                vc.formMyCenter = YES;
                vc.user = self.user;
                vc.perfaceBlock = ^(NSDictionary *dict){
                    weakSelf.user.nickName = dict[@"nickName"];
                    weakSelf.user.beFrom = dict[@"beFrom"];
                    weakSelf.user.haunt = dict[@"haunt"];
                    //更新相关界面
                    [weakSelf.tableView reloadData];
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else if (indexPath.row ==7){
                //经常出没
                SPPerfectNameVC *vc = [[SPPerfectNameVC alloc]init];
                vc.formMyCenter = YES;
                vc.user = self.user;
                vc.perfaceBlock = ^(NSDictionary *dict){
                    weakSelf.user.nickName = dict[@"nickName"];
                    weakSelf.user.beFrom = dict[@"beFrom"];
                    weakSelf.user.haunt = dict[@"haunt"];
                    //更新相关界面
                    [weakSelf.tableView reloadData];
                  
                };
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if (indexPath.row ==8){
                //个性签名
                SPBaseEditVC *vc = [[SPBaseEditVC alloc]init];
                NSString *code =@"signature";//关键词
                vc.codeText = code;
                vc.formMyCenter = YES;
                vc.titletText = @"我的个性签名";
                vc.placeHoder = self.user.signature;
                vc.perfaceBlock = ^(NSDictionary *dict){
                    weakSelf.user.signature = dict[code];
                    //更新相关界面
                    [weakSelf.tableView reloadData];
                    
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
    }
}

#pragma  mark - setter

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-70-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 42;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        
        [_tableView registerClass:[SPMyCenterCell class] forCellReuseIdentifier:SPMyCenterCellID];
        [_tableView registerClass:[SPKungFuCell class] forCellReuseIdentifier:SPKungFuCellID];
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
    }
    return _tableView;
}

-(void)sNavigation{
    
//    self.titleLabel.text = @"基础信息";
    self.navigationItem.title = @"完善信息";
    //    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    //    [save setTitle:@"保存" forState:0];
    //    [save setTitleColor:[UIColor blackColor] forState:0];
    //    UIBarButtonItem *saveBtn=[[UIBarButtonItem alloc]initWithCustomView:save];
    //    self.navigationItem.rightBarButtonItem = saveBtn;
}

#pragma  mark - action
-(void)save{
    
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next{
    SPMyTagVC *vc = [[SPMyTagVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end


