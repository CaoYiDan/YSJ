

#import "YSJBaseForDetailView.h"

@interface YSJBaseForDetailView ()<SDCycleScrollViewDelegate>
//滚动banner
@property(nonatomic,strong)SDCycleScrollView *bannerView;

@end

@implementation YSJBaseForDetailView

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
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, bannerHeight-15, kWindowW, 0)];
    baseView.backgroundColor = KWhiteColor;
    self.profileV = baseView;
    
    [self addSubview:baseView];
    
    [self setProfileView];
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

#pragma mark  轮播点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //    [self.delegate SPNewDynamicHeaderViewDidSelectedType:@"bannerClick" index:index];
}

//由子类去实现
-(void)setProfileView{
    
}

@end
