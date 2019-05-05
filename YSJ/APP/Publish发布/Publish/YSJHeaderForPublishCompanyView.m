//
//  YSJHeaderForPublishCompanyView.m
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJAddTeacherVC.h"
#import "ZLPhotoActionSheet.h"
#import "LGTextView.h"
#import "LGComposePhotosView.h"
#import "YSJHeaderForPublishCompanyView.h"

@interface YSJHeaderForPublishCompanyView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIView *bottomView;
@property(nonatomic,weak)LGComposePhotosView *photoView;
@property(nonatomic,weak)LGTextView *textView;
@property(nonatomic,copy)NSString *limitStr;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray<PHAsset *> *lastSelectAssets;

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation YSJHeaderForPublishCompanyView


-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topView];
        [self addSubview:self.middleView];
        [self addSubview:self.bottomView];
        self.clipsToBounds = YES;
    }
    return self;
}

//上半部分创建
- (UIView *)topView{
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, 156)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
    }
    return _topView;
}

- (void)topUI{
    
    //需求内容
    UILabel * xuTextTitle = [[UILabel alloc]init];
    xuTextTitle.font = font(16);
    xuTextTitle.text = @"课程详情";
    xuTextTitle.textColor = KBlack333333;
    [self.topView addSubview:xuTextTitle];
    [xuTextTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(20);
        make.top.offset(18);
    }];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56, SCREEN_W-2*kMargin, 84)];
    self.textView = textView;
    [self.topView addSubview:textView];
    textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
    textView.textColor = black666666;
    textView.delegate = self;
    textView.font  = font(14);
    textView.placeholder = @"详细描述课程内容\n1.描述课程内容特色、学习目标、教学理念等\n2.描述老师授课特色\n3.描述课程为学生带来的影响是什么";
    [self.topView addSubview:textView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.topView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//中间视图创建
- (UIView *)middleView{
    if (!_middleView) {
        _middleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.topView.frameHeight+28, SCREEN_W, 120)];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self middleUI];
    }
    return _middleView;
}

- (void)middleUI{
    
    LGComposePhotosView *photoView=[[LGComposePhotosView alloc]init];
    [self.middleView addSubview:photoView];
    self.photoView = photoView;
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    photoView.photosAsset = self.lastSelectAssets;
    WeakSelf;
    __typeof(photoView)weakPhotoView=photoView;
    photoView .clickblock=^(NSInteger tag){
        //这里的tag ，其实是按图片的高度赋值的，
        if (tag == 110) {
            
            [self showWithPreview:NO];
            
        }else if (tag >120){
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.middleView.frameHeight = tag;
                
                /*self.block
                 返回 0 ,约定的是点击了“添加老师”按钮
                 返回 不是0 ,约定的返回的“h” 是添加图片引发的header的高度的动态变化高度
                 */
                !weakSelf.block?:weakSelf.block(tag-120);
            }];
        }else{
            [weakSelf.lastSelectAssets removeObjectAtIndex:tag];
            [weakSelf.photos removeObjectAtIndex:tag];
            [weakSelf.photoView setImgs:weakSelf.photos];
        }
    };
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.middleView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

//下部分视图创建
-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView=[[UIView alloc]init];
        [self  addSubview:self.bottomView];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.equalTo(_middleView.mas_bottom).offset(0);
            make.size.mas_offset(CGSizeMake(SCREEN_W-0, 100));
        }];
        
        [self bottomUI];
    }
    return _bottomView;
}

-(void)bottomUI{
    
    //资质证书
    UILabel * labForTitle = [[UILabel alloc]init];
    [self.bottomView addSubview:labForTitle];
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
    
    UIButton * demo= [UIButton buttonWithType:UIButtonTypeCustom];
    [demo setTitleColor: KMainColor forState:0];
    demo.titleLabel.font = font(14);
    [demo setTitle:@"添加" forState:UIControlStateNormal];
  
    [demo addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:demo];
    [demo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(labForTitle).offset(0);
        make.left.offset(kWindowW-40-kMargin);
        make.width.offset(40);
        make.height.offset(40);
        
    }];
}

#pragma  mark - -----------------调取相册-----------------

- (void)showWithPreview:(BOOL)preview
{
    ZLPhotoActionSheet *a = [self getPas];
    
    if (preview) {
        [a showPreviewAnimated:YES];
    } else {
        [a showPhotoLibrary];
    }
}

- (ZLPhotoActionSheet *)getPas
{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    
    actionSheet.maxSelectCount =9;
    
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.showCaptureImageOnTakePhotoBtn = NO;
    actionSheet.allowSelectImage =YES;
    actionSheet.allowSelectGif = NO;
    actionSheet.allowSelectVideo = NO;
    actionSheet.allowSelectLivePhoto = NO;
    actionSheet.allowForceTouch = NO;
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = [SPCommon getCurrentVC];
    
    actionSheet.arrSelectedAssets = self.lastSelectAssets;
    
    weakify(self);
    
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        strongify(weakSelf);
        //for (UIImage *img in images) {
        //  [strongSelf.photoView addPhoto:img];
        //}
        [strongSelf.photoView setImgs:images];
        strongSelf.photos = images.mutableCopy;
        strongSelf.lastSelectAssets = assets.mutableCopy;
    }];
    
    return actionSheet;
}

-(void)add{
    
    /*self.block
    返回 0 ,约定的是点击了“添加老师”按钮
    返回 不是0 ,约定的返回的“h” 是添加图片引发的header的高度的动态变化高度
     */
    !self.block?:self.block(0.0);
}

@end
