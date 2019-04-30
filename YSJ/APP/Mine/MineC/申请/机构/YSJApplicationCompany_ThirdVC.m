//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "BDImagePicker.h"
#import "YSJApplication_SuccessVC.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplicationCompany_SecondVC.h"
#import "YSJApplicationCompany_ThirdVC.h"
#import "YSJPopTextView.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJApplicationCompany_ThirdVC ()
@property (nonatomic,strong) UIImageView *photo;
@property (nonatomic,strong) YSJPopTextView *textFiled;
@property (nonatomic,copy) NSString *introductionStr;
@property (nonatomic,copy) NSString *featureStr;

@end
@implementation YSJApplicationCompany_ThirdVC
{
    UIScrollView  *_scroll;
    
    UIView *_tag;
    
    YSJFactoryForCellBuilder *_builder;
    
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

-(void)dealloc{
    
    NSLog(@"销毁了");
}

#pragma mark - UI

-(NSMutableDictionary *)getCellDic{
    
    NSDictionary *dic = @{@"cellH":@"76",
                          @"orY":@"111",
                          @"arr":@[
                                  @{
                                      @"type":@(CellPopTextView),
                                      @"title":@"机构介绍",
                                      },
                                  @{
                                      @"type":@(CellPopTextView),
                                      @"title":@"机构特色",
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"教师数量",
                                                @"keyBoard":@(UIKeyboardTypeNumberPad)
                                      }
                                  ]
                          };
    return dic;
}

-(void)initUI{
    
    YSJFactoryForCellBuilder *builder = [[YSJFactoryForCellBuilder alloc]init];
    
    _builder = builder;
    
    _scroll = [builder createViewWithDic:[self getCellDic]];
    
    [self.view addSubview:_scroll];
    
    _tag =builder.lastBottomView;
    
    [self topView];

    [self setPhotoView];

    [self setBottomView];
    
}


-(void)setBase{
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scroll = scrollView;
    _scroll.backgroundColor = KWhiteColor;
    [self.view addSubview:_scroll];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
}

-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step2_3"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:topImg];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
    }];
}


-(void)setPhotoView{
    
    //场地图
    UILabel * labForTitle = [[UILabel alloc]init];
    [_scroll addSubview:labForTitle];
    labForTitle.text = @"场地图";
    labForTitle.textColor = KBlack333333;
    labForTitle.font = Font(16);
    labForTitle.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    [labForTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_tag.mas_bottom).offset(22);
        make.left.offset(kMargin);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    
    
    CGFloat photoW = (kWindowW-2*kMargin);
    
    //照片
    self.photo = [[UIImageView alloc]init];
    [_scroll addSubview:self.photo];
    self.photo.clipsToBounds = YES;
    self.photo.backgroundColor =grayF2F2F2;
    self.photo.layer.cornerRadius = 4;
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.image = [UIImage imageNamed:@"add5"];
    self.photo.userInteractionEnabled = YES;
    WeakSelf
    [self.photo addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf addPhotobtn1Click];
    }];
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(labForTitle.mas_bottom).offset(20);
        make.left.offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW/351.0*163.0);
    }];
    
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"提交申请" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

- (YSJPopTextView *)textFiled{
    if (!_textFiled) {
        _textFiled = [[YSJPopTextView
                       alloc]initWithFrame:self.view.bounds placeHolder:@"" content:@""];
        [self.view addSubview:_textFiled];
    }
    return _textFiled;
}

#pragma mark - action

#pragma mark  提交申请

-(void)next{
    
    [self upDateHeadIcon:self.photo.image WithImageType:1];
  
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
    
   
    NSArray *keyArr = @[@"describe",@"feature",@"num_teacher"];
    
    int i = 0 ;
    NSMutableDictionary *dic = @{}.mutableCopy;
    
    for (NSString *value in [_builder getAllContent]) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            [dic setObject:value forKey:keyArr[i]];
        }
        i++;
    }
    
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    NSLog(@"%@",dic);
    
    [dic setObject:imageData forKey:@"img"];
  
    [manager POST:YcompanyStep3 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"img" fileName:@"text.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[self dictionaryWithJsonString:result2];
        NSLog(@"%@",dict);
        
        pushClass(YSJApplication_SuccessVC);
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
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
@end
