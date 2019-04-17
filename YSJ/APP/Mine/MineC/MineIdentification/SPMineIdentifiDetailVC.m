//
//  SPMineIdentifiDetailVC.m
//  SmallPig
//

//

#import "SPMineIdentifiDetailVC.h"
#import "SPLzsIdentifiDetailView.h"
#import "BDImagePicker.h"
@interface SPMineIdentifiDetailVC ()
@property (nonatomic,strong)UILabel * cadDetailLab;
@property (nonatomic,strong)UITextField * cadNumLab;
@property (nonatomic,strong)UIButton * addPhotobtn1;//手持证件正面照
@property (nonatomic,strong)UIButton * addPhotobtn2;//手持证件反面照
@property (nonatomic,strong)UIButton * commitBtn;//提交
@property (nonatomic,strong)UIImageView * photoIV1;//第一个图
@property (nonatomic,strong)UIImageView * photoIV2;//第二个图
@property (nonatomic,copy)NSString * identiStr;//用于转换显示身份认证类型 下个界面
@property (nonatomic,copy)NSString * imgPathFaceStr;//正面照路劲
@property (nonatomic,copy)NSString * imgPathBackStr;//背面照路劲
@end

@implementation SPMineIdentifiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initNav];
    /*
     身份认证的状态：未认证、已认证、待审核、认证未通过
     未认证：内容页为空，可提交
     已认证：内容页为用户提交系统的数据，不可修改不可提交
     待审核：内容页为用户提交系统的数据，不可修改不可提交
     认证未通过：内容页为用户提交系统的数据，可修改可提交
     
     身份认证状态 已认证：CERTIFIED，待审核：TOBEAUDITED，未认证：UNCERTIFIED，认证拒绝：CERTIFIEDREFUSA
     */
    
    if ([self.identifiStr isEqualToString:@"UNCERTIFIED"]){//未认证
        
        [self initUI];
        
    }else if([self.identifiStr isEqualToString:@"CERTIFIEDREFUSAL"]){//认证未通过
        
        //认证未通过,可获取信息,并修改
        [self initUI];
        [self getLoadData];
        
    }else
    {
        
        //待审核和已认证 不能编辑
        [self initUI];
        [self getLoadData];
        self.cadDetailLab.userInteractionEnabled = NO;
        self.cadNumLab.userInteractionEnabled = NO;
        self.addPhotobtn1.userInteractionEnabled = NO;
        self.addPhotobtn2.userInteractionEnabled = NO;
        self.commitBtn.userInteractionEnabled = NO;
        
    }
    //[self loadData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - getLoadData
- (void)getLoadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //NSString * Kurl = [NSString stringWithFormat:@"%@%@",URLOfGetCertification,[StorageUtil getCode]];
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",URLOfGetCertification,[StorageUtil getCode]] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的认证%@",responseObject);
        
        NSDictionary * data = responseObject[@"data"];
        self.identiStr = data[@"certificateType"];
        self.cadNumLab.text = data[@"certificateNum"];
        [self.photoIV1 sd_setImageWithURL:[NSURL URLWithString:data[@"certificatePositivePhoto"]]];
        [self.photoIV2 sd_setImageWithURL:[NSURL URLWithString:data[@"certificateBackPhoto"]]];
        
        if ([self.identiStr isEqualToString:@"PASSPORT"]) {
            self.cadDetailLab.text = @"护照 >";
            
        }else if ([self.identiStr isEqualToString:@"PASSCHECK"]){
            self.cadDetailLab.text = @"港澳通行证 >";
        }else if ([self.identiStr isEqualToString:@"IDCARD"]){
            
            self.cadDetailLab.text = @"身份证 >";
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -  loadData 申请认证
-(void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
   
    
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [dict setObject:self.identiStr forKey:@"certificateType"];
    [dict setObject:self.cadNumLab.text forKey:@"certificateNum"];
    //正面照路劲
    [dict setObject:self.imgPathFaceStr forKey:@"certificatePositivePhoto"];
    //背面照
    [dict setObject:self.imgPathBackStr forKey:@"certificateBackPhoto"];
    [[HttpRequest sharedClient]httpRequestPOST:URLOfApplyForCertification parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        //NSLog(@"我的消息%@",responseObject);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        Toast(@"提交成功");
        [self getBackVC];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark getBackVC
- (void)getBackVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark 调取相册

- (void)upDateHeadIcon:(UIImage *)photo WithImageType:(int)type{
    
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
    
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
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
        if (type==1) {//正面照路劲
            
            self.imgPathFaceStr = dict[@"image"];
        }else{
            
            self.imgPathBackStr = dict[@"image"];
        }
        
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        //        [self post];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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

#pragma mark - initUI
- (void)initUI{
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_W, SCREEN_H-100)];
    scrollView.contentSize = CGSizeMake(0, 800);
    scrollView.backgroundColor = WC;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    
    UILabel * cadCateLab = [[UILabel alloc]init];
    //[self.view addSubview:cadCateLab];
    [scrollView addSubview:cadCateLab];
    [cadCateLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(15);
        make.left.offset(15);
        make.width.offset(100);
        make.height.offset(20);
    }];
    cadCateLab.text = @"证件类型";
    cadCateLab.textColor = [UIColor blackColor];
    cadCateLab.font = Font(14);
    cadCateLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    cadCateLab.textAlignment = NSTextAlignmentLeft;
    //证件类型
    self.cadDetailLab = [[UILabel alloc]init];
     //= cadDetailLable;
    [scrollView addSubview:self.cadDetailLab];
    //[self.view addSubview:self.cadDetailLab];
    
    UITapGestureRecognizer * tapCadDetai = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(caddetailTap)];
    self.cadDetailLab.userInteractionEnabled = YES;
    [self.cadDetailLab addGestureRecognizer:tapCadDetai];
    
//    [self.cadDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(cadCateLab.mas_top);
//
//        make.left.offset(150);
//        make.width.offset(120);
//        make.height.offset(20);
//    }];
    self.cadDetailLab.frame = CGRectMake(SCREEN_W-135, 15, 120, 20);
    self.cadDetailLab.text = @"请选择证件类型 >";
    self.cadDetailLab.textColor = [UIColor blackColor];
    self.cadDetailLab.font = Font(14);
    self.cadDetailLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    self.cadDetailLab.textAlignment = NSTextAlignmentRight;
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = RGBCOLOR(240, 240, 240);
    //[self.view addSubview:lineView1];
    [scrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(cadCateLab.mas_bottom).offset(10);
        make.left.equalTo(cadCateLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(1);
        
    }];
    
    UILabel * cadNumberTextLab = [[UILabel alloc]init];
    //[self.view addSubview:cadNumberTextLab];
    [scrollView addSubview:cadNumberTextLab];
    [cadNumberTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.left.equalTo(cadCateLab.mas_left);
        make.width.offset(80);
        make.height.offset(20);
        
    }];
    cadNumberTextLab.text = @"证件号码";
    cadNumberTextLab.textColor = [UIColor blackColor];
    cadNumberTextLab.font = Font(14);
    cadNumberTextLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    cadNumberTextLab.textAlignment = NSTextAlignmentLeft;
    //证件类型
    self.cadNumLab = [[UITextField alloc]init];
    //[self.view addSubview:self.cadNumLab];
    [scrollView addSubview:self.cadNumLab];
    [self.cadNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView1.mas_bottom).offset(10);
        make.left.equalTo(cadNumberTextLab.mas_right);
        make.width.offset(SCREEN_W-120);
        make.height.offset(20);
    }];
    
    self.cadNumLab.placeholder = @"请输入证件号码";
    self.cadNumLab.textColor = [UIColor blackColor];
    self.cadNumLab.font = Font(14);
    self.cadNumLab.textAlignment = NSTextAlignmentLeft;
    
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = RGBCOLOR(240, 240, 240);
    //[self.view addSubview:lineView2];
    [scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(cadNumberTextLab.mas_bottom).offset(10);
        make.left.equalTo(cadCateLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(1);
        
    }];
    
    //
    UILabel * faceLab = [[UILabel alloc]init];
    //[self.view addSubview:faceLab];
    [scrollView addSubview:faceLab];
    [faceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView2.mas_bottom).offset(10);
        make.left.equalTo(cadCateLab.mas_left);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    faceLab.text = @"手持证件正面照";
    faceLab.textColor = [UIColor blackColor];
    faceLab.font = Font(14);
    faceLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    faceLab.textAlignment = NSTextAlignmentLeft;
    
    //
    self.addPhotobtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.addPhotobtn1 setTitle:@"添加照片" forState:UIControlStateNormal];
    [self.addPhotobtn1 setBackgroundColor:RGBCOLOR(250, 27, 82)];
    self.addPhotobtn1.clipsToBounds = YES;
    self.addPhotobtn1.layer.cornerRadius = 4;
    //[self.view addSubview:self.addPhotobtn1];
    
    [self.addPhotobtn1 addTarget:self action:@selector(addPhotobtn1Click) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.addPhotobtn1];
    [self.addPhotobtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(lineView2.mas_bottom).offset(5);
        make.right.equalTo(lineView2.mas_right);
        make.width.offset(80);
        make.height.offset(30);
        
    }];
    
    //
    self.photoIV1 = [[UIImageView alloc]init];
    //[self.view addSubview:self.photoIV1];
    [scrollView addSubview:self.photoIV1];
    self.photoIV1.layer.borderColor =RGBCOLOR(240, 240, 240).CGColor;
    self.photoIV1.layer.borderWidth = 1;
    self.photoIV1.clipsToBounds = YES;
    self.photoIV1.layer.cornerRadius = 8;
    self.photoIV1.contentMode = UIViewContentModeScaleAspectFit;
    [self.photoIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(faceLab.mas_bottom).offset(15);
        make.left.equalTo(faceLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset((SCREEN_W-30)/16*9);
    }];
    
    //
    UIView * lineView3 = [[UIView alloc]init];
    lineView3.backgroundColor = RGBCOLOR(240, 240, 240);
    //[self.view addSubview:lineView3];
    [scrollView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.photoIV1.mas_bottom).offset(10);
        make.left.equalTo(faceLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(1);
        
    }];
    
    //
    UILabel * backLab = [[UILabel alloc]init];
    //[self.view addSubview:backLab];
    [scrollView addSubview:backLab];
    [backLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView3.mas_bottom).offset(10);
        make.left.equalTo(cadCateLab.mas_left);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    backLab.text = @"手持证件背面照";
    backLab.textColor = [UIColor blackColor];
    backLab.font = Font(14);
    backLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    backLab.textAlignment = NSTextAlignmentLeft;
    
    //
    self.addPhotobtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.addPhotobtn2 setTitle:@"添加照片" forState:UIControlStateNormal];
    [self.addPhotobtn2 setBackgroundColor:RGBCOLOR(250, 27, 82)];
    self.addPhotobtn2.clipsToBounds = YES;
    self.addPhotobtn2.layer.cornerRadius = 4;
    //[self.view addSubview:self.addPhotobtn2];
    
    [self.addPhotobtn2 addTarget:self action:@selector(addPhotobtn2Click) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:self.addPhotobtn2];
    [self.addPhotobtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(lineView3.mas_bottom).offset(5);
        make.right.equalTo(lineView3.mas_right);
        make.width.offset(80);
        make.height.offset(30);
        
    }];
    
    //
    self.photoIV2 = [[UIImageView alloc]init];
    //[self.view addSubview:self.photoIV2];
    [scrollView addSubview:self.photoIV2];
    self.photoIV2.layer.borderColor =RGBCOLOR(240, 240, 240).CGColor;
    self.photoIV2.layer.borderWidth = 1;
    self.photoIV2.clipsToBounds = YES;
    self.photoIV2.layer.cornerRadius = 8;
    self.photoIV2.contentMode = UIViewContentModeScaleAspectFit;
    //self.photoIV2.backgroundColor =
    [self.photoIV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backLab.mas_bottom).offset(15);
        make.left.equalTo(backLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset((SCREEN_W-30)/4*3);
    }];
    
    //
    UIView * lineView4 = [[UIView alloc]init];
    lineView4.backgroundColor = RGBCOLOR(240, 240, 240);
    //[self.view addSubview:lineView4];
    [scrollView addSubview:lineView4];
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.photoIV2.mas_bottom).offset(10);
        make.left.equalTo(faceLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(1);
        
    }];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-SafeAreaTopHeight-100, SCREEN_W, 100)];
    bottomView.backgroundColor = WC;
    
    [self.view addSubview:bottomView];
    self.commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commitBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [self.commitBtn setBackgroundColor:RGBCOLOR(250, 27, 82)];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:self.commitBtn];
    [bottomView addSubview:self.commitBtn];
    self.commitBtn.clipsToBounds = YES;
    self.commitBtn.layer.cornerRadius = 4;
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(30);
        make.left.offset(35);
        make.width.offset(SCREEN_W-70);
        make.height.offset(40);
        
    }];
}
#pragma mark - 吊起弹窗
- (void)caddetailTap{
    
    SPLzsIdentifiDetailView * detailView = [[SPLzsIdentifiDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    if ([self.identiStr isEqualToString:@"PASSPORT"]) {
        
        detailView.index = 1;
        
    }else if ([self.identiStr isEqualToString:@"PASSCHECK"]){
        
        detailView.index = 2;
        
    }else if ([self.identiStr isEqualToString:@"IDCARD"]){
        
        detailView.index = 0;
        
    }else{
        
        detailView.index = 5;
        
    }
    detailView.block = ^(NSString *field) {
      
        self.identiStr = field;
        if ([self.identiStr isEqualToString:@"PASSPORT"]) {
            self.cadDetailLab.text = @"护照 >";
            
        }else if ([self.identiStr isEqualToString:@"PASSCHECK"]){
            self.cadDetailLab.text = @"港澳通行证 >";
        }else if ([self.identiStr isEqualToString:@"IDCARD"]){
            
            self.cadDetailLab.text = @"身份证 >";
        }
        
    };
    [self.view addSubview:detailView];
}

#pragma mark - commitBtnClick
- (void)commitBtnClick{
    
    if (self.identiStr !=nil &&self.cadNumLab.text !=nil && self.imgPathFaceStr !=nil &&self.imgPathBackStr !=nil ) {
        
        [self loadData];
    }else{
        
        Toast(@"信息不完整,请重试");
    }
    
}
#pragma  mark 调取相册
#pragma mark - addPhotobtn1Click
- (void)addPhotobtn1Click{
    
    //吊起相册
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        
        if (image) {
            self.photoIV1.image = image;
            [weakSelf upDateHeadIcon:image WithImageType:1];
        }
        
    }];
    
    
}
- (void)addPhotobtn2Click{
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
       
        if (image) {
            self.photoIV2.image = image;
            [weakSelf upDateHeadIcon:image WithImageType:2];
        }
        
    }];
    
}
#pragma mark - initNav
- (void)initNav{
    
    self.titleLabel.text = @"身份认证";
    self.titleLabel.textColor = [UIColor blackColor];
    
    //[self.rightButton setImage:[UIImage imageNamed:@"me_r1_c15"] forState:UIControlStateNormal];
    //[self.rightButton setTitle:@"" forState:UIControlStateNormal];
    //[self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
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
