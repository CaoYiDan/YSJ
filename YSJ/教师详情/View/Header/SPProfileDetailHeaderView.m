

#import "SPProfileDetailHeaderView.h"

#import "YSJTeacherModel.h"

#import "YSJTeacherHeaderView.h"

#import "SPKitExample.h"
@interface SPProfileDetailHeaderView ()<SDCycleScrollViewDelegate>
//滚动banner
@property(nonatomic,strong)SDCycleScrollView *bannerView;
//个人简介
@property(nonatomic,strong)YSJTeacherHeaderView *profileView;

@end

@implementation SPProfileDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.bannerView];
    [self addSubview:self.profileView];
   
}
- (void)setBannerImgArr:(NSMutableArray *)bannerImgArr{
    _bannerImgArr = bannerImgArr;
    _bannerView.imageURLStringsGroup = bannerImgArr;
}
//轮播图
-(SDCycleScrollView*)bannerView{
    if (!_bannerView) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_W,bannerHeight) imageURLStringsGroup:self.bannerImgArr];
        
        _bannerView.currentPageDotColor= KMainColor;
        _bannerView.pageDotColor= KWhiteColor;
        _bannerView.backgroundColor = gray999999; _bannerView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        _bannerView.infiniteLoop = YES;
        _bannerView.delegate = self;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 3;
    }
    return _bannerView;
}

-(YSJTeacherHeaderView *)profileView{
    if (!_profileView) {
        _profileView = [[YSJTeacherHeaderView alloc]initWithFrame:CGRectMake(0, bannerHeight-15, SCREEN_W, profileHeight)];
        _profileView.backgroundColor = KWhiteColor;
        [self addSubview:_profileView];
    }
    return _profileView;
}

-(void)invite{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    YWPerson *person = [[YWPerson alloc]initWithPersonId:@"32"];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
}


-(void)setProfileM:(YSJTeacherModel *)profileM{
    _profileM = profileM;
    self.profileView.model = profileM;
    
}

#pragma mark  轮播点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    [self.delegate SPNewDynamicHeaderViewDidSelectedType:@"bannerClick" index:index];
}

@end
