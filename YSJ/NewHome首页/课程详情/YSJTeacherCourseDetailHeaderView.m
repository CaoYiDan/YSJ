

#import "YSJTeacherCourseDetailHeaderView.h"

#import "YSJTeacherModel.h"

#import "SPKitExample.h"

@interface YSJTeacherCourseDetailHeaderView ()<SDCycleScrollViewDelegate>
//滚动banner
@property(nonatomic,strong)SDCycleScrollView *bannerView;
//中间viwe
@property(nonatomic,strong)UIView *middleView;
//bottomView
@property(nonatomic,strong)UIView *bottomView;

@end

@implementation YSJTeacherCourseDetailHeaderView
{
    UILabel *_courseName;
    UILabel *_coursePrice;
    UILabel *_courseOldPrice;
    UILabel *_courseIntroduction;
    UIButton *_tag1;
    UIButton *_tag2;
    UIButton *_tag3;
    
    
    UILabel *_address;
    UIButton *_distance;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.bannerView];
    [self addSubview:self.middleView];
//    [self addSubview:self.bottomView];
}

//轮播图
-(SDCycleScrollView*)bannerView{
    if (!_bannerView) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_W,banHeight) imageURLStringsGroup:self.bannerImgArr];
        
        _bannerView.currentPageDotColor=[UIColor grayColor];
        _bannerView.pageDotColor=[UIColor blackColor];
        _bannerView.backgroundColor = KMainColor; _bannerView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        _bannerView.infiniteLoop = YES;
        _bannerView.delegate = self;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 3;
    }
    return _bannerView;
}

-(UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc]initWithFrame:CGRectMake(0, banHeight, SCREEN_W, proHeight)];
        [self addSubview:_middleView];
        [self setMiddle];
    }
    return _middleView;
}

-(void)setMiddle{
    
    _courseName = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 200, 30)];
    _courseName.font = font(16);
    _courseName.textColor = [UIColor blackColor];
    _courseName.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:_courseName];
    
    
    _coursePrice = [[UILabel alloc]init];
    _coursePrice.font = font(14);
    _coursePrice.textColor = KMainColor;
    _coursePrice.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:_coursePrice];
    [_coursePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_courseName);
        make.height.offset(30);
        make.top.equalTo(_courseName.mas_bottom).offset(7);
    }];
    
    _courseOldPrice = [[UILabel alloc]init];
    _courseOldPrice.font = font(13);
    _courseOldPrice.textColor = grayF2F2F2;
    _courseOldPrice.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:_courseOldPrice];
    [_courseOldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_courseName.mas_right).offset(10);
        make.height.offset(30);
        make.centerY.equalTo(_coursePrice.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine0 = [[UIView alloc]init];
    bottomLine0.backgroundColor = grayF2F2F2;
    [_middleView addSubview:bottomLine0];
    [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(_coursePrice.mas_bottom).offset(7);
    }];
    
    
    _courseIntroduction = [[UILabel alloc]init];
    _courseIntroduction.font = font(13);
    _courseIntroduction.numberOfLines = 0;
    _courseIntroduction.textColor = gray999999;
    _courseIntroduction.backgroundColor = [UIColor whiteColor];
     _courseIntroduction.text = @"多就费劲单身快乐废旧塑料费劲老是的多就费劲单 ";
    [_middleView addSubview:_courseIntroduction];
    [_courseIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_courseName).offset(0);
        make.right.offset(-kMargin);
    make.top.equalTo(bottomLine0.mas_bottom).offset(10);
    }];
    
    
    UIView *bottomLine1 = [[UIView alloc]init];
    bottomLine1.backgroundColor = grayF2F2F2;
    [_middleView addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(_courseIntroduction.mas_bottom).offset(10);
    }];
    
    NSArray *arr = @[@"随时退",@"过期自动退",@"三人班"];
    for (int i =0; i<arr.count; i++) {
        UIButton *btn = [FactoryUI createButtonWithtitle:arr[i] titleColor:gray999999 imageName:@"d_no_zan" backgroundImageName:nil target:nil selector:nil];
        [_middleView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kWindowW/3*i);
            make.width.offset(kWindowW/3);
            make.height.offset(40);
            make.top.equalTo(bottomLine1.mas_bottom).offset(0);
        }];
        if (i==0) {
            _tag1 = btn;
        }
    }
    
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [_middleView addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(6);
        make.top.equalTo(_tag1.mas_bottom).offset(0);
    }];
    
    
    UILabel *addressTitle = [[UILabel alloc]init];
    addressTitle.font = font(16);
    addressTitle.text = @"上课地址";
    addressTitle.backgroundColor = [UIColor whiteColor];
    [_middleView addSubview:addressTitle];
    [addressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(40);
        make.top.equalTo(bottomLine2.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine3 = [[UIView alloc]init];
    bottomLine3.backgroundColor = grayF2F2F2;
    [_middleView addSubview:bottomLine3];
    [bottomLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(addressTitle.mas_bottom).offset(0);
    }];
    
    _address = [[UILabel alloc]init];
    _address.font = font(13);
    _address.numberOfLines = 0;
    _address.textColor = gray999999;
    _address.backgroundColor = [UIColor whiteColor];
    _address.text = @"多就费劲单身快乐废旧塑料费劲老是 ";
    _address.backgroundColor = KWhiteColor;
    [_middleView addSubview:_address];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-100);
    make.top.equalTo(addressTitle.mas_bottom).offset(10);
    }];
    
    _distance = [FactoryUI createButtonWithtitle:@"2.9km" titleColor:gray999999 imageName:@"city" backgroundImageName:nil target:nil selector:nil];
    [_middleView addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);

        make.height.offset(30);
        make.top.equalTo(_address.mas_bottom).offset(7);
    }];
    
    {
    NSArray *arr = @[@"d_no_zan",@"d_no_zan"];
    for (int i =0; i<arr.count; i++) {
        UIButton *btn = [FactoryUI createButtonWithtitle:nil titleColor:gray999999 imageName:@"d_no_zan" backgroundImageName:nil target:self     selector:@selector(btnClick:)];
        [_middleView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-kMargin-40*i);
            make.width.offset(40);
            make.height.offset(40);
            make.centerY.equalTo(_address).offset(0);
        }];
        btn.tag = i;
     }
    }
    
    UIView *bottomLine4 = [[UIView alloc]init];
    bottomLine4.backgroundColor = grayF2F2F2;
    [_middleView addSubview:bottomLine4];
    [bottomLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(10);
        make.bottom.offset(0);
    }];
}

-(void)btnClick:(UIButton *)btn{
   
}

-(void)invite{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    YWPerson *person = [[YWPerson alloc]initWithPersonId:@"32"];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
}


-(void)setProfileM:(YSJTeacherModel *)profileM{
    _profileM = profileM;
    
    
}

#pragma mark  轮播点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //    [self.delegate SPNewDynamicHeaderViewDidSelectedType:@"bannerClick" index:index];
}

@end
