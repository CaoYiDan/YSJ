//
//  SPMyKungFuVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPEditMyProfileVC.h"
#import "SPMyProflieHeader.h"
#import "SPKungFuCell.h"
#import "SPKungFuModel.h"
#import "SPSixPhotoView.h"
#import "SPUser.h"
#import "SPMyTagVC.h"
#import "SPMyKungFuVC.h"
#import "SPMyInterestVC.h"
#import "SPTagCell.h"
#import "SPKungFuCell.h"
#import "SPCommon.h"
#import "SPPerfecSexVC.h"
#import "BDImagePicker.h"
#import "SPPerfectNameVC.h"
#import "SPPerfectBirthDayVC.h"
#import "SPBaseEditVC.h"

#import "SPMyCenterCell.h"
@interface SPEditMyProfileVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;

@property (nonatomic, strong) SPSixPhotoView *headerView;
@property(nonatomic ,strong)NSMutableArray *photosArr;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)NSArray *textArr;
@property(nonatomic ,strong)NSArray *imgArr;
@property(nonatomic,copy)NSString *imgChangeType;
@property(nonatomic,assign)NSInteger imgIndex;
@end

@implementation SPEditMyProfileVC

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
    
    //创建头部相册布局
    [self createHeader];
    
    NSLog(@"%@",self.user.avatarList);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 60)];
    base.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W-20, 1)];
    line.backgroundColor =[UIColor lightGrayColor];
    [base addSubview:line];
    
    UILabel *sectionView = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, SCREEN_W, 40)];
    if (section == 1) {
        sectionView.text = @"技能";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSkill)];
        tap.numberOfTapsRequired = 1;
        [base addGestureRecognizer:tap];
    }else{
        sectionView.text = @"标签";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTag)];
        tap.numberOfTapsRequired = 1;
        [base addGestureRecognizer:tap];
    }
    sectionView.userInteractionEnabled = NO;
    
    sectionView.font = BoldFont(16);
    [base addSubview:sectionView];
    return base;
}

-(void)tapTag{
    SPMyTagVC *vc = [[SPMyTagVC alloc]init];
    vc.formMyCenter = YES;
    //保存完 pop回来，刷新
    WeakSelf;
    vc.perfaceBlock = ^(NSDictionary *dict){
        weakSelf.user = [SPUser mj_objectWithKeyValues:dict];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tapSkill{
    WeakSelf;
    SPMyKungFuVC *vc = [[SPMyKungFuVC alloc]init];
    vc.formMyCenter = YES;
    //    vc.code = model.code;
    //保存完 pop回来，刷新
    vc.perfaceBlock = ^(NSDictionary *dict){
        weakSelf.user = [SPUser mj_objectWithKeyValues:dict];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
            vc.perfaceBlock = ^(NSDictionary *dict){
                weakSelf.user.gender = [dict[@"gender"] longValue];
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
                //代理回传更改详细信息
                [weakSelf.delegate backLastUser:weakSelf.user];
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
                //代理回传更改详细信息
                [weakSelf.delegate backLastUser:weakSelf.user];
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
                //代理回传更改详细信息
                [weakSelf.delegate backLastUser:weakSelf.user];
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
                    //代理回传更改详细信息
                    [weakSelf.delegate backLastUser:weakSelf.user];
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
                    //代理回传更改详细信息
                    [weakSelf.delegate backLastUser:weakSelf.user];
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
                    //代理回传更改详细信息
                    [weakSelf.delegate backLastUser:weakSelf.user];
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
                    //代理回传更改详细信息
                    [weakSelf.delegate backLastUser:weakSelf.user];
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
                    //代理回传更改详细信息
                    [weakSelf.delegate backLastUser:weakSelf.user];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
    }else if (indexPath.section==1){
        SPKungFuModel *model = self.user.skills[indexPath.row];
        SPMyKungFuVC *vc = [[SPMyKungFuVC alloc]init];
        vc.formMyCenter = YES;
        vc.code = model.code;
        //保存完 pop回来，刷新
        vc.perfaceBlock = ^(NSDictionary *dict){
            //            [weakSelf loadData];
            weakSelf.user = [SPUser mj_objectWithKeyValues:dict];
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [self tapTag];
        
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 42;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(0,0 , SafeAreaBottomHeight, 0);
        [_tableView registerClass:[SPMyCenterCell class] forCellReuseIdentifier:SPMyCenterCellID];
        [_tableView registerClass:[SPKungFuCell class] forCellReuseIdentifier:SPKungFuCellID];
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
        
    }
    return _tableView;
}

//创建头部相册布局
-(void)createHeader{
    
    self.headerView = [[SPSixPhotoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
    NSLog(@"%@",self.user.avatarList);
    [self.headerView setPhotosArr:self.user.avatarList];
    WeakSelf;
    self.headerView.sixPhotoViewBlock = ^(NSString *type,NSInteger tag){
        weakSelf.imgIndex = tag;
        weakSelf.imgChangeType = type;
        [weakSelf photo];
    };
}

-(void)sNavigation{
    
    self.titleLabel.text = @"基础信息";
    
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

#pragma  mark 调取相册
-(void)photo{
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        //上传图片---获取图片网络地址
        //        [weakSelf upDateHeadIcon:image];
        //        _photoImage=image;
        if (image) {
            [weakSelf upDateHeadIcon:image];
        }
        
    }];
}

- (void)upDateHeadIcon:(UIImage *)photo{
    
    //菊花显示
    NSLog(@"相册%@",photo);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         
                                                         @"text/html",
                                                         
                                                         @"image/jpeg",
                                                         
                                                         @"image/png",
                                                         
                                                         @"application/octet-stream",
                                                         
                                                         @"text/json",
                                                         
                                                         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval =100.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
//    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    
     NSData *imageData = [SPCommon reSizeImageData:photo maxImageSize:600 maxSizeWithKB:1024.0];
    
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
    [imageData writeToFile:fullPath atomically:NO];
    
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"image"];
    [dictT setObject:@"/usr/local/tomcat/webapps/" forKey:@"imageUploadPath"];
    [manager POST:kUrlPostImg parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[self dictionaryWithJsonString:result2];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:dict[@"image"] forKey:@"url"];
        if (self.user.avatarList.count==0 || self.imgIndex == 0) {
            [dic setObject:@"true" forKey:@"master"];
        }else{
            [dic setObject:@"false" forKey:@"master"];
        }
        
        if ([self.imgChangeType isEqualToString:@"替换"]) {
            [self.user.avatarList replaceObjectAtIndex:self.imgIndex withObject:dic];
        }else if ([self.imgChangeType isEqualToString:@"添加"]){
            [self.user.avatarList addObject:dic];
        }
        
        [self.headerView setPhotosArr:self.user.avatarList];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self post];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"shibai%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


-(void)post{
    
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    
    if (!isNull(self.user.avatarList)) {
         [paramenters setObject:self.user.avatarList forKey:@"avatarList"];
    }
   
    [paramenters setObject:[StorageUtil getId] forKey:@"id"];
    [paramenters setObject:[StorageUtil getCode] forKey:@"code"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlUpdateUser parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.user.avatar = self.user.avatarList[0][@"url"];
        
        //代理回传更改详细信息
        [self.delegate backLastUser:self.user];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"dsds");
    }];
}

#pragma  mark  将字符串转成字典
-(id )dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        return nil;
    }
    
    return dic;
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

