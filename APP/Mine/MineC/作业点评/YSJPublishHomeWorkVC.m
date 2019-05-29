//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "ImageCell.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "ZLPhotoBrowser.h"
#import "ZLPhotoActionSheet.h"
#import "ZLPhotoManager.h"
#import "LGTextView.h"
#import "YSJOrderCourseView.h"
#import "LGComposePhotosView.h"
#import "YSJPublishHomeWorkVC.h"
#import "ZLPhotoActionSheet.h"
#import "YSJCourseModel.h"
#import "SPCommon.h"

#import "YSJPostVideoOrImgView.h"

//定位服务
#import <CoreLocation/CoreLocation.h>

@interface YSJPublishHomeWorkVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray<UIImage *> *lastSelectPhotos;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;

@property (nonatomic, strong) NSArray *arrDataSources;

@property (nonatomic, assign) BOOL isOriginal;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;

@property(nonatomic,weak)LGComposePhotosView *photoView;

@property(nonatomic,weak)LGTextView *textView;

@property (nonatomic,strong) UILabel *evaluate;

@property (nonatomic, strong) NSMutableArray *imgArr;


@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) NSMutableArray *evaluateArr;

@property (nonatomic,assign)NSInteger index;

@end

@implementation YSJPublishHomeWorkVC



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"布置作业";
    
    _index = 4;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.middleView];
    self.bottomView.backgroundColor = KWhiteColor;
    [self  setSaveButton];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
}

#pragma  mark - setter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _scrollView.contentSize=CGSizeMake(0, 900);
    }
    return _scrollView;
}

//上半部分创建
- (UIView *)topView{
    
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, 156+200)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
    }
    return _topView;
}

- (void)topUI{
    //课程评价
    YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 200, kWindowW, 102)];
//    view.model = self.model;
    [self.topView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(102);
        make.top.offset(0);
    }];
   
    UIView *bottomLine22 = [[UIView alloc]init];
    bottomLine22.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine22];
    [bottomLine22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(view).offset(0);
    }];
    
    //作业题目
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"作业题目";
    xuTextTitle.textColor = KBlack333333;
    [self.topView addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin+5);
        make.height.offset(20);
        make.top.equalTo(view.mas_bottom).offset(10);
    }];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56+130, SCREEN_W-2*kMargin, 104)];
    self.textView = textView;
    [self.topView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(104);
        make.width.offset(SCREEN_W-2*kMargin); make.top.equalTo(xuTextTitle.mas_bottom).offset(20);
    }];
    textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
    textView.textColor = black666666;
    textView.delegate = self;
    textView.font  = font(14);
    textView.placeholder = @"详细描述作业题目…";
    [self.topView addSubview:textView];
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//中间视图创建
- (UIView *)middleView{
    
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frameHeight+10, SCREEN_W, 300)];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self middleUI];
    }
    return _middleView;
}

- (void)middleUI{
    
    YSJPostVideoOrImgView *view = [[YSJPostVideoOrImgView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 300)];
    [self.middleView addSubview:view];
}


//下部分视图创建
-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView=[[UIView alloc]init];
        [self.scrollView addSubview:self.bottomView];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.equalTo(_middleView.mas_bottom).offset(0);
            make.size.mas_offset(CGSizeMake(SCREEN_W-20, 76
                                            *2));
        }];
        
        
    }
    return _bottomView;
}

-(void)setSaveButton{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"发布" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}



//添加取消按钮->
-(void)addCancelBtn{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setFrame:CGRectMake(20, 20, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftIgtem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = leftIgtem;
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}

//完成发布
-(void)finishPublish{
    //2.block传值
    //    if (self.mDismissBlock != nil) {
    //        self.mDismissBlock();
    //    }
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self countWord:textView.text]>500) {
        Toast(@"您已超出了最大输入字符限制");
        return NO;
    }
    return YES;
}

-(int)countWord:(NSString *)s
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}


@end
