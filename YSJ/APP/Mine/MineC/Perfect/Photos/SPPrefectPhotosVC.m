//
//  SPPhotosForMakeMoneyVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPrefectPhotosVC.h"
#import "SPSixPhotoView.h"
#import "BDImagePicker.h"
#import "SPPublishModel.h"
#import "SPSkillWorkExp.h"
#import "SPMyKungFuVC.h"
@interface SPPrefectPhotosVC ()

@property (nonatomic, strong) SPSixPhotoView *photoView;
@property(nonatomic,copy)NSString *imgChangeType;
@property (nonatomic, assign)NSInteger imgIndex;
@property(nonatomic,strong)NSMutableArray *photosArr;
//返回按钮
@property (nonatomic, strong)UIButton *backBtn;
@end

@implementation SPPrefectPhotosVC

-(NSMutableArray *)photosArr{
    if (!_photosArr) {
        _photosArr = @[].mutableCopy;
    }
    return _photosArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:self.backBtn];
    [self createTitle];
    [self createPhotoView];
    [self setPublishButton];
    
    NSMutableArray *avatarList = (NSMutableArray*)[StorageUtil getUserDict][@"avatarList"];
    NSLog(@"%@",avatarList);
    if (avatarList.count!=0) {
        
        [self.photoView setPhotosArr:avatarList];
        [self.photosArr addObjectsFromArray:avatarList];
        
    }
}

-(void)setPublishButton{
    UIButton *publish = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight-40, SCREEN_W-80, 40)];
    publish.backgroundColor = RGBCOLOR(253, 56, 101);
    [publish setTitle:@"下一步" forState:0];
    publish.layer.cornerRadius = 5;
    publish.clipsToBounds = YES;
    publish.titleLabel.font = font(16);
    [publish addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:publish];
}

-(void)createTitle{
    
    //    UIView *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    //    topLine.backgroundColor =HomeBaseColor;
    //    [self.view addSubview:topLine];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, SafeAreaTopHeight, SCREEN_W, 40)];
    title.font = font(15);
    title.text = @"我的相册";
    [self.view addSubview:title];
}

//创建头部相册布局
-(void)createPhotoView{
    
    self.photoView = [[SPSixPhotoView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+40, SCREEN_W, SCREEN_W)];
    [self.photoView setPhotosArr:nil];
    [self.view addSubview:self.photoView];
    WeakSelf;
    self.photoView.sixPhotoViewBlock = ^(NSString *type,NSInteger tag){
        weakSelf.imgIndex = tag;
        weakSelf.imgChangeType = type;
        [weakSelf photo];
    };
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
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[self dictionaryWithJsonString:result2];
        //            [self.photosArr addObject:dict[@"image"]];
        
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:dict[@"image"] forKey:@"url"];
        if (self.photosArr.count==0 || self.imgIndex == 0) {
            
            [dic setObject:@"true" forKey:@"master"];
        }else{
            [dic setObject:@"false" forKey:@"master"];
        }
        
        if ([self.imgChangeType isEqualToString:@"替换"]) {
            [self.photosArr replaceObjectAtIndex:self.imgIndex withObject:dic];
        }else if ([self.imgChangeType isEqualToString:@"添加"]){
            [self.photosArr addObject:dic];
        }
        
        [self.photoView setPhotosArr:self.photosArr];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(void)post{
    
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

-(void)publish{
    
    if (self.photosArr.count==0) {
        Toast(@"请至少上传一张照片");
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    
    [paramenters setObject:self.photosArr forKey:@"avatarList"];
    
    [paramenters setObject:[StorageUtil getId] forKey:@"id"];
    [paramenters setObject:[StorageUtil getCode] forKey:@"code"];
    
    NSLog(@"%@",paramenters);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlUpdateUser parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        hidenMBP;
        
        SPMyKungFuVC *vc = [[SPMyKungFuVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        hidenMBP;
    }];
}

//返回按钮
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,SafeAreaStateHeight, 60, 60)];
        //交给子类实现
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    }
    return _backBtn;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

