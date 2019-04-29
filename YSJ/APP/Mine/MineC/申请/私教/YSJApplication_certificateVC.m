//
//  YSJApplication_CertificateVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "BDImagePicker.h"
#import "YSJApplication_CertificateVC.h"

@interface YSJApplication_CertificateVC ()
@property (nonatomic,strong) UIImageView *photo;
@property (nonatomic,strong)  UILabel *certifierName;
@end

@implementation YSJApplication_CertificateVC
{
   
    UILabel *_getTime;
    UISwitch *_canSee;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"私教申请";
    
    [self initUI];
}
-(void)save{
    
    [self upDateHeadIcon:self.photo.image];
   
  
}
-(void)initUI{
    
    UIButton *right = [[UIButton alloc]init];
    right.frame = CGRectMake(0, 0, 44, 44);
    [right setTitle:@"保存" forState:0];
    [right setTitleColor:KWhiteColor forState:0];
    [right addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    
    CGFloat photoW = (kWindowW-2*kMargin);
    
    //照片
    self.photo = [[UIImageView alloc]init];
    [self.view addSubview:self.photo];
    self.photo.clipsToBounds = YES;
    self.photo.backgroundColor =grayF2F2F2;
    self.photo.layer.cornerRadius = 4;
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.image = [UIImage imageNamed:@"add4"];
    self.photo.userInteractionEnabled = YES;
    WeakSelf;
    [self.photo addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf addPhotobtn1Click];
    }];
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW/351.0*163.0);
    }];
    
    [self bottomUI];
}

-(void)bottomUI{
    
    CGFloat cellH = 70;
    
    //资质证书名称
    UILabel *_leftText = [[UILabel alloc]init];
    _leftText.font = font(16);
    _leftText.text = @"资质证书名称";
    [self.view addSubview:_leftText];
    [_leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(100);
        make.height.offset(cellH);
        make.top.equalTo(_photo.mas_bottom).offset(10);
    }];
    
    UILabel *_rightText = [[UILabel alloc]init];
    _certifierName = _rightText;
    _rightText.textAlignment = NSTextAlignmentRight;
    _rightText.textColor = gray999999;
    _rightText.font = font(16);
    [self.view addSubview:_rightText];
    [_rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin-20);
        make.width.offset(100);
        make.height.offset(cellH);
        make.top.equalTo(self.photo.mas_bottom).offset(10);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [self.view addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.equalTo(_rightText).offset(0);
    }];
    
    WeakSelf;
    UIButton *btn0 = [[UIButton alloc]init];
    btn0.backgroundColor =[UIColor clearColor];
    [self.view addSubview:btn0];
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(cellH);
        make.top.equalTo(_certifierName).offset(0);
    }];
    [btn0 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [SPCommon creatAlertControllerTitle:@"证书" subTitle:@"" _alertSure:^(NSString *text) {
            _certifierName.text = text;
        }];
    }];
    
    
    UIView *bottomLine1 = [[UIView alloc]init];
    bottomLine1.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(1);
        make.bottom.equalTo(_certifierName
                            .mas_bottom).offset(0);
    }];
    
    
    //身份证号
    UILabel *leftText2 = [[UILabel alloc]init];
    leftText2.font = font(16);
    leftText2.text = @"获得时间";
    [self.view addSubview:leftText2];
    [leftText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(120);
        make.height.offset(cellH);
        make.top.equalTo(bottomLine1.mas_bottom).offset(0);
    }];
    
    UILabel *_rightTimeText = [[UILabel alloc]init];
    _getTime = _rightTimeText;
    _rightTimeText.textAlignment = NSTextAlignmentRight;
    _rightTimeText.textColor = gray999999;
    _rightTimeText.font = font(14);
    [self.view addSubview:_rightTimeText];
    [_rightTimeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin-20);
        make.width.offset(100);
        make.height.offset(cellH);
        make.top.equalTo(bottomLine1.mas_bottom).offset(0);
    }];
    
    UIImageView *arrowImg2 = [[UIImageView alloc]init];
    arrowImg2.image = [UIImage imageNamed:@"arrow"];
    [self.view addSubview:arrowImg2];
    [arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.equalTo(_rightTimeText).offset(0);
    }];
    
    UIButton *btn1 = [[UIButton alloc]init];
    btn1.backgroundColor =[UIColor clearColor];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(cellH);
        make.top.equalTo(_getTime).offset(0);
    }];
    [btn1 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [SPCommon creatAlertControllerTitle:@"获取时间" subTitle:@"" _alertSure:^(NSString *text) {
            _getTime.text = text;
        }];
    }];
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(1);
        make.bottom.equalTo(_rightTimeText.mas_bottom).offset(0);
    }];
    
    //性别
    { UILabel *_leftText = [[UILabel alloc]init];
        _leftText.font = font(16);
        _leftText.text = @"是否可见";
        [self.view addSubview:_leftText];
        [_leftText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.width.offset(100);
            make.height.offset(cellH);
            make.top.equalTo(bottomLine2.mas_bottom).offset(0);
        }];
        
        _canSee = [[UISwitch alloc]init];
        _canSee.onTintColor = KMainColor;
        [self.view addSubview:_canSee];
        [_canSee setOn:YES];
        [_canSee mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-kMargin);
            make.height.offset(30);
            make.centerY.equalTo(_leftText);
        }];
        
    }
}

#pragma  mark 调取相册

#pragma mark - addPhotobtn1Click

- (void)addPhotobtn1Click{
    
    //吊起相册
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        
        if (image) {
            self.photo.image = image;
          
        }
        
    }];
}

#pragma  mark 调取相册
#pragma  mark 上传图片
- (void)upDateHeadIcon:(UIImage *)photo{
    
    if (isEmptyString(_getTime.text)||isEmptyString((_certifierName.text))) {
        Toast(@"请填写完整信息");
        return;
    }
    
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
    NSString *path = [NSString stringWithFormat:@"%@%@",[StorageUtil getTel],@"e433332232"];
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:path];
    [imageData writeToFile:fullPath atomically:NO];
    
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"cert"];
    [dictT setObject:[StorageUtil getId] forKey:@"token"];
    [dictT setObject:_certifierName.text forKey:@"certs_name"];
    [dictT setObject:@(_canSee.isOn) forKey:@"certs_visible"];
    
    [dictT setObject:_getTime.text forKey:@"get_time"];
    [manager POST:YTeacherStep4 parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"cert" fileName:[NSString stringWithFormat:@"%@.jpg",path] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[result2 stringChangeToDictionary];
        
        //回传给上个界面
        !self.block?:self.block(self.certifierName.text);
        
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"%@",dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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

@end
