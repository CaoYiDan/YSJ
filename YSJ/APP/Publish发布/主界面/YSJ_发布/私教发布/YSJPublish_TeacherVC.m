//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplication_SuccessVC.h"
#import "YSJPublish_TeacherVC.h"
#import "YSJPopTeachTypeView.h"
#import "YSJPopTextView.h"
#import "LGTextView.h"
#import "YSJDetailForTeacherPublishVC.h"
#import "YSJChoseTagsVC.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJPublish_TeacherVC ()
@property (nonatomic,strong) YSJPopTeachTypeView *teachTypeView;
//需求标题cell
@property (nonatomic,strong) YSJPopTextFiledView *xuTitleCell;
//需求详情label
@property (nonatomic,strong) UILabel *xuDetailLabel;
//图片数组
@property (nonatomic,strong) NSMutableArray *imgArr;
//上课时间
@property (nonatomic,strong) NSString  *courseTime;
//课时数
@property (nonatomic,strong) NSString  *courseNum;

@property (nonatomic,strong) UIButton  *selectedBtn;

@property (nonatomic,strong)UIView * mySilderLine;

@end

@implementation YSJPublish_TeacherVC
{
    UIScrollView  *_scroll;
    UILabel *_name;
    UITextField *_identifierTextFiled;
    UILabel *_sex;
    YSJFactoryForCellBuilder *_builder;
    YSJCommonSwitchView *_supportHome;
    
    UIView *_tag;
    UIView *_tag0;
    UIView *_tag1;
    UIView *_tag2;
    UIView *_tag3;
    UIView *_tag4;
    
    NSMutableArray *_cellViewArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.title = @"发布";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UI

-(void)initUI{
    
    YSJFactoryForCellBuilder *builder = [[YSJFactoryForCellBuilder alloc]init];
    
    _builder = builder;
    
    _scroll = [builder createViewWithDic:[self getCellDic]];
    _scroll.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:_scroll];
    
    //首次选中（）
    [_builder publishForTeachOneByOne];
    
    [self topView];
    
    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{cb_cellH:@"76",
                          cb_orY:@"230",
                         cb_cellArr:@[
      @{
          @"type":@(CellPopCouserChosed),
          @"title":@"分类",
          cb_courseCategoryType:@(1)
          },
      @{
          @"type":@(CellPopTextView),
          @"title":@"课程特色",
          },
      
      @{
          @"type":@(CellPopMoreTextFiledView),
          @"title":@"课程价格",
          cb_moreTextFiledArr:@"现价,原价,拼单价"
          },
      
      @{
          @"type":@(CellPopNormal),
          @"title":@"适用人群",
          },
      
      @{
          @"type":@(CellSwitch),
          @"title":@"上门服务",
          },
      
      @{
          @"type":@(CellPopNormal),
          @"title":@"上课地址",
          },
      
      @{
          @"type":@(CellPopLine),
          @"lineH":@"6",
          },
      
      @{
          @"type":@(CellPushVC),
          @"title":@"课程标签",
          cb_otherString:@"老师-课程",
          }
                                  ]
                          };
    return dic;
}

-(void)topView{
    
    YSJPopTextFiledView *xuTitle = [[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 76) withTitle:@"课程标题" subTitle:@"请输入课程标题"];
    self.xuTitleCell = xuTitle;
    [_scroll addSubview:xuTitle];
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"课程详情";
    xuTextTitle.textColor = KBlack333333;
    xuTextTitle.userInteractionEnabled = YES;
    [_scroll addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(76);
        make.width.offset(kWindowW);
        make.top.equalTo(xuTitle.mas_bottom).offset(0);
    }];
    
    #pragma mark 跳转到课程详情
    
    WeakSelf;
    [xuTextTitle addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        YSJDetailForTeacherPublishVC *vc = [[YSJDetailForTeacherPublishVC alloc]init];
        vc.block = ^(NSString *detailText, NSMutableArray *imgArr, NSString *courseTime, NSString *courseNum) {
            weakSelf.xuDetailLabel.text = detailText;
            weakSelf.imgArr = imgArr;
            weakSelf.courseNum = courseNum;
            weakSelf.courseTime = courseTime;
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    _xuDetailLabel = [[UILabel alloc]init];
    _xuDetailLabel.textAlignment = NSTextAlignmentRight;
    _xuDetailLabel.textColor = gray999999;
    _xuDetailLabel.font = font(14);
    [xuTextTitle addSubview:_xuDetailLabel];
    [_xuDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin-20-20);
        make.left.offset(140);
        make.height.offset(normalCellH
                           );
        make.top.offset(0);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [xuTextTitle addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW-kMargin-8-kMargin);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.offset(0);
    }];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(xuTextTitle.mas_bottom).offset(5);
    }];
    
    UIView *baseSwitchView = [[UIView alloc]init];
    baseSwitchView.backgroundColor = KWhiteColor;
    [_scroll addSubview:baseSwitchView];
    [baseSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(60);
        make.top.equalTo(bottomLine.mas_bottom).offset(0);
    }];
    
    int i = 0 ;
    NSArray *arr = @[@"私教课程",@"拼单课程"];
    CGFloat btnW = kWindowW/arr.count;
    for (NSString *str in arr) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, 0, btnW,55)];
        [btn setTitle:str forState:0];
        [btn setTitleColor:KMainColor forState:UIControlStateSelected];
        [btn setTitleColor:gray999999 forState:0];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        btn.titleLabel.font = font(16);
        [baseSwitchView addSubview:btn];
        if (i==0) {
            self.selectedBtn =  btn;
            btn.selected = YES;
        }
        i++;
    }
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = grayF2F2F2;
    [baseSwitchView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(3);
        make.bottom.offset(0);
    }];
    
    UIView *silderLine = [[UIView alloc]init];
    silderLine.backgroundColor = KMainColor;
    _mySilderLine = silderLine;
    _tag = silderLine;
    [baseSwitchView addSubview:silderLine];
    [silderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW/4-51);
        make.width.offset(102);
        make.height.offset(3);
        make.bottom.offset(0);
    }];
}

#pragma mark  点击发布课程的类型

-(void)typeClick:(UIButton *)btn{
    
    if (self.selectedBtn==btn) {
        return;
    }
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    _mySilderLine.centerX = btn.centerX;
    
    if (btn.tag==1) {
        [_builder publishForTeachPinDan];
    }else{
        [_builder publishForTeachOneByOne];
    }
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"确认发布" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

#pragma mark - action

#pragma mark  提交申请

-(void)next{
    
    if (isEmptyString(_xuTitleCell.rightSubTitle) || [_xuTitleCell.rightSubTitle isEqualToString:@"课程标题"] || isEmptyString(_xuDetailLabel.text)) {
        Toast(@"请填写完整信息");
        return;
    }
    
    //从第二个字段开始罗列"key"数组（第0个和第1个 的拼接方式不一样）
    NSArray *keyArr = @[@"",@"feaatures",@"",@"suitable_range",@"is_at_home",@"address",@"lables"];
    
    //获取value数组
    NSMutableArray *valueArr = [_builder getAllContent];
    
    int i = 0 ;
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in valueArr) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
            
        }else{
            
            if (i==0 || i==2) {
                //第0个和第2个 的拼接方式不一样
            }else{
                
              [dic setObject:value forKey:keyArr[i]];
                
            }
        }
        i++;
    }
    
    [dic setObject:_xuTitleCell.rightSubTitle forKey:@"title"];
    
    [dic setObject:_xuDetailLabel.text forKey:@"describe"];
    
    [dic setObject:self.courseTime forKey:@"course_time"];
    
    //最少课时数
    [dic setObject:[[self.courseNum componentsSeparatedByString:@","][0] componentsSeparatedByString:@":"][1] forKey:@"min_times"];
    
    //建议课时数
     [dic setObject:[[self.courseNum componentsSeparatedByString:@","][1] componentsSeparatedByString:@":"][1] forKey:@"r_times"];
    
    //课程大类
    [dic setObject:[valueArr[0] componentsSeparatedByString:@"-"][0] forKey:@"coursetype"];
    //课程小类
    [dic setObject:[valueArr[0] componentsSeparatedByString:@"-"][1] forKey:@"coursetypes"];
    //现价
    [dic setObject:[[valueArr[2] componentsSeparatedByString:@","][0] componentsSeparatedByString:@":"][1] forKey:@"price"];
    
    //原价
    [dic setObject:[[valueArr[2] componentsSeparatedByString:@","][1]componentsSeparatedByString:@":"][1] forKey:@"old_price"];
    
    //需求种类(私教、机构)
    [dic setObject:self.selectedBtn.tag==0?@"一对一课程":@"拼单课程" forKey:@"type"];
    //token
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    if (self.selectedBtn.tag==0) {
        
        [dic setObject:@(0) forKey:@"min_user"];
        [dic setObject:@(0) forKey:@"max_user"];
        [dic setObject:@(0.0) forKey:@"multi_price"];
        
    }else{
        
        //拼单价
        [dic setObject:[[valueArr[2] componentsSeparatedByString:@","][2]componentsSeparatedByString:@":"][1] forKey:@"multi_price"];
        //支不支持服务（不支持，）
        [dic setObject:@"0" forKey:@"is_at_home"];
      
        //拼单最少人数
        [dic setObject:[[valueArr[4] componentsSeparatedByString:@","][0] componentsSeparatedByString:@":"][1] forKey:@"min_user"];
        
        //拼单最多人数
        [dic setObject:[[valueArr[4] componentsSeparatedByString:@","][1]componentsSeparatedByString:@":"][1] forKey:@"max_user"];
    }
    
    NSLog(@"%@",dic);
  
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

    [manager POST:YPublishTeacherCourse parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < _imgArr.count; i++) {
            
            //压缩-添加-上传图片
            //遍历你的第一层图片请求数组
            [self.imgArr enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
                //压缩图片转化为data,第一个参数是图片,第二个参数是压缩系数
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                //添加转化后的data到body中
                //data:转化后的imageData
                //name:服务器需要的标识,服务器根据这个来取图片流,类似parameters里面的key
                //fileName:服务器保存的图片名字,base64加密后更佳 (如有不对欢迎指出 )
                //mimeType:图片类型,一般为@"image/jpeg"固定格式,特殊可添加其他格式
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"publish_teacher_Image%ld",idx+1] fileName:[NSString stringWithFormat:@"%@%lu.jpeg",@"planImage",(unsigned long)idx]mimeType:@"image/jpeg"];
            }];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[result2 stringChangeToDictionary];
        
        NSLog(@"%@",dict);
        
        if ([dict[@"status"] integerValue]==200) {
            Toast(@"发布成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"publishFinish" object:nil];
            
        }else{
            Toast(@"错误格式");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
