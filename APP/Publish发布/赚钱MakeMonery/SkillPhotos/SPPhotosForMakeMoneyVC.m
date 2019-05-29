//
//  SPPhotosForMakeMoneyVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPhotosForMakeMoneyVC.h"
#import "SPSixPhotoView.h"
#import "BDImagePicker.h"
#import "SPPublishModel.h"
#import "SPSkillWorkExp.h"
@interface SPPhotosForMakeMoneyVC ()

@property (nonatomic, strong) SPSixPhotoView *photoView;
@property(nonatomic,copy)NSString *imgChangeType;
@property (nonatomic, assign)NSInteger imgIndex;

@end

@implementation SPPhotosForMakeMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title= @"我要赚钱";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTitle];
    [self createPhotoView];
    [self setPublishButton];
}

-(void)setPublishButton{
    UIButton *publish = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H2-80-SafeAreaTopHeight, SCREEN_W-80, 40)];
    publish.backgroundColor = RGBCOLOR(253, 56, 101);
    [publish setTitle:@"发布" forState:0];
    publish.layer.cornerRadius = 5;
    publish.clipsToBounds = YES;
    publish.titleLabel.font = font(16);
    [publish addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:publish];
}

-(void)createTitle{
    UIView *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 10)];
    topLine.backgroundColor =HomeBaseColor;
    [self.view addSubview:topLine];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_W, 40)];
    title.font = font(15);
    title.text = @"   技能相册";
    [self.view addSubview:title];
}

//创建头部相册布局
-(void)createPhotoView{
    
    self.photoView = [[SPSixPhotoView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_W, SCREEN_W)];
    
    [self.photoView setPhotosArr:self.model.skillImgList];
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
        if (self.model.skillImgList.count==0) {
            self.model.skillImgList = @[].mutableCopy;//初始化一下
            [dic setObject:@"true" forKey:@"master"];
        }else{
            [dic setObject:@"false" forKey:@"master"];
        }

        if ([self.imgChangeType isEqualToString:@"替换"]) {
            [self.model.skillImgList replaceObjectAtIndex:self.imgIndex withObject:dic];
        }else if ([self.imgChangeType isEqualToString:@"添加"]){
            [self.model.skillImgList addObject:dic];
        }
        
        [self.photoView setPhotosArr:self.model.skillImgList];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self post];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    
    if (self.model.skillImgList.count==0) {
        Toast(@"请至少上传一张照片");
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *paramenters= [[NSMutableDictionary alloc]init];
    //    信息id，当已经存在发布的技能时该id必填
    //    信息CODE，当已经存在发布的技能时该code必填
    if (!isEmptyString(self.model.lucCode)) {
        [paramenters setObject:self.model.lucCode forKey:@"lucCode"];
        [paramenters setObject:self.model.lucID forKey:@"id"];
    }
    
    [paramenters setObject:[StorageUtil getCity] forKey:@"city"];
    [paramenters setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [paramenters setObject:[StorageUtil getCode] forKey:@"code"];
    [paramenters setObject:self.model.price forKey:@"price"];
    [paramenters setObject:self.model.priceUnit forKey:@"priceUnit"];
    [paramenters setObject:self.model.serContent forKey:@"serContent"];
    [paramenters setObject:self.model.serIntro forKey:@"serIntro"];
    [paramenters setObject:self.model.serRemark forKey:@"serRemark"];
    [paramenters setObject:self.model.serTime forKey:@"serTime"];
    
    [paramenters setObject:self.model.serRemark forKey:@"serRemark"];
    [paramenters setObject:self.model.skillCode forKey:@"skillCode"];

    
    //工作经历
    SPSkillWorkExp *expModel = self.model.skillWorkExp[0];
    if (!isEmptyString(expModel.companyName)) {
        NSMutableArray *expArr = @[].mutableCopy;
        for (SPSkillWorkExp *exp in self.model.skillWorkExp) {
            NSMutableDictionary *expDic = @{}.mutableCopy;
            [expDic setObject:exp.companyName forKey:@"companyName"];
            [expDic setObject:exp.workCity forKey:@"workCity"];
            [expDic setObject:exp.industry forKey:@"industry"];
            [expDic setObject:exp.jobTitle forKey:@"jobTitle"];
            [expDic setObject:@(exp.working) forKey:@"working"];
            [expDic setObject:exp.workBeginTime forKey:@"workBeginTime"];
            [expDic setObject:exp.workEndTime forKey:@"workEndTime"];
            [expArr addObject:expDic];
        }
        [paramenters setObject:expArr forKey:@"skillWorkExp"];
    }
    
    [paramenters setObject:self.model.skillImgList forKey:@"skillImgList"];
    
    [paramenters setObject:[StorageUtil getCity] forKey:@"locationValue"];
    [paramenters setObject:self.model.bailRuleId forKey:@"bailRuleId"];
    NSLog(@"%@",paramenters);
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlLucrativeAdd parameters:paramenters progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        if (self.formWhere == 0) {
            //发送通知 跳转到首页
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationJumpToHome object:nil];
            //退出
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else if (self.formWhere == 1){
           //发送通知 跳转到租约广场
             [[NSNotificationCenter defaultCenter]postNotificationName:NotificationPublishSkillFinshedForLeaseVC object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
       
        hidenMBP;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        Toast(@"oo,出错了耶");
        
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

@end
