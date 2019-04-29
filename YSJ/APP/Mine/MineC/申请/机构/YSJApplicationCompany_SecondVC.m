//

//

#import "YSJApplicationCompany_SecondVC.h"
#import "SPLzsIdentifiDetailView.h"
#import "BDImagePicker.h"
#import "YSJApplication_demoVC.h"
#import "YSJApplication_certificateVC.h"
#import "YSJApplicationCompany_ThirdVC.h"


@interface YSJApplicationCompany_SecondVC ()
@property (nonatomic,strong)UILabel * cadDetailLab;
@property (nonatomic,strong)UITextField * cadNumLab;
@property (nonatomic,strong)UIButton * addPhotobtn1;//手持证件正面照
@property (nonatomic,strong)UIButton * addPhotobtn2;//手持证件反面照
@property (nonatomic,strong)UIButton * commitBtn;//提交

@property (nonatomic,strong)UIImageView * photoIV3;//第三个图
@property (nonatomic,strong)UIImageView * photoIV4;//第四个图

@property (nonatomic,copy)NSString * identiStr;//用于转换显示身份认证类型 下个界面

@property (nonatomic,copy)NSString * imgPathFaceStr;//正面照路劲

@property (nonatomic,copy)NSString * imgPathBackStr;//背面照路劲

@property(nonatomic,assign)int photoType;

@end

@implementation YSJApplicationCompany_SecondVC
{
    UIScrollView *_scrollView;
    
    UIView *_firstBotttomView;
    
    UIView *_secondBotttomView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"机构申请";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - getLoadData
- (void)getLoadData{
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //NSString * Kurl = [NSString stringWithFormat:@"%@%@",URLOfGetCertification,[StorageUtil getCode]];
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",URLOfGetCertification,[StorageUtil getCode]] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的认证%@",responseObject);
        
        NSDictionary * data = responseObject[@"data"];
        self.identiStr = data[@"certificateType"];
        self.cadNumLab.text = data[@"certificateNum"];
      
        
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
    
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    
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
    [dictT setObject:[StorageUtil getId] forKey:@"token"];

    [manager POST:YcompanyStep2 parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"img" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[self dictionaryWithJsonString:result2];
        //            [self.photosArr addObject:dict[@"image"]];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setObject:dict[@"image"] forKey:@"url"];
        
        YSJApplicationCompany_ThirdVC *vc = [[YSJApplicationCompany_ThirdVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    
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
    
    [self setBase];
    
    [self setTop];
    
    [self identifierView];
    
    
    [self tipView];
    
    [self setBottomView];
}

#pragma mark baseScrollview
-(void)setBase{
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView = scrollView;
    _scrollView.backgroundColor = KWhiteColor;
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kWindowW, 800);
}
#pragma mark  top
-(void)setTop{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step2_2"];
    topImg.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:topImg];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 32+37+32, kWindowW, 6)];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scrollView addSubview:bottomLine];
    
}

#pragma mark  营业执照认证界面
-(void)identifierView{
    
    //营业执照
    UILabel * faceLab = [[UILabel alloc]init];
    [_scrollView addSubview:faceLab];
    faceLab.text = @"营业执照";
    faceLab.textColor = [UIColor blackColor];
    faceLab.font = Font(16);
    faceLab.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    [faceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(111+6);
        make.left.offset(kMargin);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    
    //营业执照
    UILabel * tipLab = [[UILabel alloc]init];
    [_scrollView addSubview:tipLab];
    tipLab.text = @"请上传机构的营业执照";
    tipLab.textColor = gray999999;
    tipLab.font = Font(12);
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(faceLab.mas_bottom).offset(5);
        make.left.offset(kMargin);
        make.height.offset(20);
        
    }];
    
    
    CGFloat photoW = (kWindowW-3*kMargin)/2;
    //身份证正面照
    self.photoIV3 = [[UIImageView alloc]init];
    [_scrollView addSubview:self.photoIV3];
    self.photoIV3.clipsToBounds = YES;
    self.photoIV3.backgroundColor =grayF2F2F2;
    self.photoIV3.layer.cornerRadius = 4;
    self.photoIV3.contentMode = UIViewContentModeScaleAspectFill;
    
    self.photoIV3.image = [UIImage imageNamed:@"yingyeimg"];
    self.photoIV3.userInteractionEnabled = NO;
    
    [self.photoIV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tipLab.mas_bottom).offset(15);
        make.left.offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW/169.0*238.0);
    }];
    
    
    //身份证反面照
    self.photoIV4 = [[UIImageView alloc]init];
    [_scrollView addSubview:self.photoIV4];
    self.photoIV4.clipsToBounds = YES;
    self.photoIV4.backgroundColor =grayF2F2F2;
    self.photoIV4.layer.cornerRadius = 4;
    self.photoIV4.contentMode = UIViewContentModeScaleAspectFill;
    self.photoIV4.image = [UIImage imageNamed:@"add4"];
    self.photoIV4.userInteractionEnabled = YES;
    WeakSelf;
    [self.photoIV4 addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakSelf.photoType = 4;
        [weakSelf addPhotobtn1Click];
    }];
    [self.photoIV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tipLab.mas_bottom).offset(15);
        make.left.equalTo(self.photoIV3.mas_right).offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW/169.0*238.0);
    }];
}

-(void)tipView{
    
    UILabel *tip1 = [FactoryUI createLabelWithFrame:CGRectZero text:@"请参考样例，拍摄完整照片\n\n需文字清晰、完整、露出国徽及印章\n\n不可用其他证件替代" textColor:gray999999 font:font(14)];
    tip1.numberOfLines = 0;
    tip1.textAlignment = NSTextAlignmentLeft;
    [_scrollView addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.top.equalTo(self.photoIV4.mas_bottom).offset(38);
    }];
}

#pragma mark  bottomView

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"下一步" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-25);
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
           
         self.photoIV4.image = image;
       
        }
        
    }];
    
}

#pragma mark - action

//查看实例
-(void)seeDemo{
    
    pushClass(YSJApplication_DemoVC);
}

-(void)next{
   
    [self upDateHeadIcon:self.photoIV4.image WithImageType:1];
    
  
}


@end
