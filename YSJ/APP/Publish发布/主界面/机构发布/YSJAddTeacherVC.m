
#import "YSJAddTeacherVC.h"
#import "YSJPopTextFiledView.h"
#import "BDImagePicker.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 70

@interface YSJAddTeacherVC ()

@property (nonatomic,strong) UIImageView *photo;

@end

@implementation YSJAddTeacherVC
{
    UIScrollView *_scroll;
    YSJFactoryForCellBuilder  *_builder;
    YSJPopTextFiledView *_nameCell;
    UITextField *_identifierTextFiled;
    YSJPopTextFiledView *_sexCell;
    UIView *_tag;
  
}

#pragma mark - life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"添加老师";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - setter

-(void)initUI{
    
    YSJFactoryForCellBuilder *builder = [[YSJFactoryForCellBuilder alloc]init];
    
    _builder = builder;
    
    _scroll = [builder createViewWithDic:[self getCellDic]];
    
    [self.view addSubview:_scroll];
    
    _tag =builder.lastBottomView;
    
    [self topView];
    
    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{
      cb_cellH:@"76",
      cb_orY:@"151",
      cb_cellArr:
      @[
          @{
            @"type":@(CellPopNormal),
            @"title":@"老师姓名",
           },
          @{
              @"type":@(CellPopCouserChosed),
              @"title":@"授课类型",
              cb_courseCategoryType:@(1),//单选
              },
         
          @{
              @"type":@(CellPopTextView),
              @"title":@"老师介绍",
              
              },@{
              cb_type:@(CellPushVC),
              cb_title:@"老师标签",
             cb_otherString:@"学生-需求",
              },
      ]
    };
    return dic;
}

#pragma mark  授课老师添加照片

-(void)topView{
    
    //授课老师
    UILabel * labForTitle = [[UILabel alloc]init];
    [_scroll addSubview:labForTitle];
    labForTitle.text = @"授课老师";
    labForTitle.textColor = [UIColor blackColor];
    labForTitle.font = Font(16);
    labForTitle.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    [labForTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(22);
        make.left.offset(kMargin);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    
    CGFloat photoW = 70;
    //身份证正面照
    self.photo = [[UIImageView alloc]init];
    [_scroll addSubview:self.photo];
    self.photo.clipsToBounds = YES;
    self.photo.backgroundColor =grayF2F2F2;
    self.photo.layer.cornerRadius = photoW/2;
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.userInteractionEnabled = YES;
    self.photo.image = [UIImage imageNamed:@"add_btn7"];
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(labForTitle.mas_bottom).offset(15);
        make.left.offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW);
    }];
    
    WeakSelf;
    [self.photo addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [weakSelf addPhotobtn1Click];
    }];
    
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"保存" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-25);
    }];
}

-(void)save{
    
    NSArray *keyArr = @[@"name",@"teaching_type",@"describe",@"labels"];
    NSMutableArray *valueArr = [_builder getAllContent];
    if (keyArr.count!=valueArr.count) {
        Toast(@"请填写完整信息");
        return;
    }
    
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:[StorageUtil getId] forKey:@"token"];
    
    int i =0;
    for (NSString *str in valueArr) {
        [dictT setObject:str forKey:keyArr[i]];
        i++;
    }
    NSLog(@"%@",dictT);
    
    //菊花显示
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
        
        @"application/json",
         
         @"text/html",
         
         @"image/jpeg",
         
         @"image/png",
         
         @"application/octet-stream",
         
         @"text/json",
         
         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    NSData * imageData = UIImageJPEGRepresentation(self.photo.image,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"text"];
    [imageData writeToFile:fullPath atomically:NO];
    
  
    [manager POST:YAddTeacher parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"photo" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[SPCommon dictionaryWithJsonString:result2];
        NSLog(@"%@",dict);
        
        //代理通知
        [self.delegate addTeacherSucceed];
        //返回上个界面
        [self.navigationController popViewControllerAnimated:YES];
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

}

- (void)addPhotobtn1Click{
    
    //吊起相册
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        
        if (image) {
            //添加进img数组
           
         self.photo.image = image;
            
        }
        
    }];
    
}
@end
