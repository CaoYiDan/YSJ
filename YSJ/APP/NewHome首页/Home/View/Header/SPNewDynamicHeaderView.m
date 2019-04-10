//
//  SPNewDynamicHeaderView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNewDynamicHeaderView.h"
#import "SPDynamicCategoryCell.h"
#import "YSJActivityCell.h"
#import "SDCycleScrollView.h"

@interface SPNewDynamicHeaderView () <UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
//分类数组
@property(nonatomic,strong)NSMutableArray *categoryArr;
//滚动banner
@property(nonatomic,strong)SDCycleScrollView *bannerView;
//分类baseView
@property(nonatomic,strong)UIView *categoryView;
//轮播图数据数组
@property(nonatomic,strong)NSMutableArray *bannerArray;
//活动baseView
@property(nonatomic,strong)UIView *activityView;

@end

@implementation SPNewDynamicHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    self.categoryArr = @[@{@"img":@"jiaoshi",@"name":@"约私教"},@{@"img":@"jigou",@"name":@"约机构"},@{@"img":@"xuesheng",@"name":@"约学生"}].mutableCopy;
    self.activityArr = @[@{@"img":@"saishi",@"name":@"赛事",@"subTitle":@"这里有最精彩的赛事"},@{@"img":@"shangcheng",@"name":@"商城",@"subTitle":@"这里有最丰富的物品"},@{@"img":@"huodongxing",@"name":@"活动行",@"subTitle":@"这里有最精彩的活动"},@{@"img":@"yishuquan",@"name":@"艺术圈",@"subTitle":@"这里有最精彩的动态"}].mutableCopy;
    
    [self addSubview:self.bannerView];
    
    [self addSubview:self.categoryView];
    
    [self addSubview:self.activityView];
    
}

//轮播图
-(SDCycleScrollView*)bannerView{
    if (!_bannerView) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_W-2*kMargin,bannerHeight) imageURLStringsGroup:self.bannerArray];
        [SPCommon setShaowForView:_bannerView];
        _bannerView.currentPageDotColor= KMainColor;
        _bannerView.pageDotColor= [UIColor grayColor];
        _bannerView.docUp = YES;
        _bannerView.backgroundColor = HomeBaseColor; _bannerView.bannerImageViewContentMode=UIViewContentModeScaleAspectFill;
        _bannerView.infiniteLoop = YES;
        _bannerView.delegate = self;
        _bannerView.clipsToBounds = YES;
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _bannerView.autoScrollTimeInterval = 3;
    }
    return _bannerView;
}

-(UIView *)categoryView{
    if (!_categoryView) {
        _categoryView  = [[UIView alloc]initWithFrame:CGRectMake(0, bannerHeight+kMargin, SCREEN_W-2*kMargin, categotyH)];
        _categoryView.backgroundColor = KWhiteColor;
        [SPCommon setShaowForView:_categoryView];
        
        CGFloat btnW = (kWindowW-2*kMargin)/3;
        int i= 0;
        for (NSDictionary *dic in self.categoryArr)
        {
            UIView *base = [[UIView alloc]initWithFrame:CGRectMake(btnW*i,0, btnW,80)];
            WeakSelf;
            [base addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                [weakSelf.delegate SPNewDynamicHeaderViewDidSelectedType:@"category" index:i];
            }];
            [_categoryView addSubview:base];
            UIImageView *img  = [[UIImageView alloc]init];
            img.image = [UIImage imageNamed:dic[@"img"]];
            img.userInteractionEnabled = NO;
            img.backgroundColor = KWhiteColor;
            [base addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.width.offset(40);
                make.height.offset(30);
                make.top.offset(20);
            }];
            
            UILabel *bottomLabel = [[UILabel alloc]init];
            bottomLabel.userInteractionEnabled = NO;
            bottomLabel.text = dic[@"name"];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            bottomLabel.font = font(14);
            [base addSubview:bottomLabel];
            [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(20);
                make.top.equalTo(img.mas_bottom).offset(10);
            }];
            i++;
        }
    }
    return _categoryView;
}

-(UIView *)activityView{
    if (!_activityView) {
        _activityView  = [[UIView alloc]initWithFrame:CGRectMake(0, bannerHeight+2*kMargin+categotyH, SCREEN_W-2*kMargin, activityH)];
        _activityView.backgroundColor = [UIColor blueColor];
        [SPCommon setShaowForView:_activityView];
        
        CGFloat btnW = (kWindowW-2*kMargin)/2;
        int i= 0;
        for (NSDictionary *dic in self.activityArr)
        {
            UIView *base = [[UIView alloc]initWithFrame:CGRectMake(i%2*btnW,i/2*60+10, btnW,60)];
            
            [base addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                NSLog(@"%@",@"点击");
            }];
            [_activityView addSubview:base];
            UIImageView *img  = [[UIImageView alloc]init];
            img.userInteractionEnabled = NO;
            img.backgroundColor = KWhiteColor;
            [base addSubview:img];
            img.image = [UIImage imageNamed:dic[@"img"]];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.width.offset(30);
                make.height.offset(30);
                make.left.offset(kMargin);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.userInteractionEnabled = NO;
            title.text = dic[@"name"];
            title.font = font(14);
            [base addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img.mas_right).offset(10);
                make.right.offset(0);
                make.height.offset(20);
                make.top.equalTo(img).offset(0);
            }];
            
            UILabel *subTitle = [[UILabel alloc]init];
            subTitle.userInteractionEnabled = NO;
            subTitle.text = dic[@"subTitle"];
            subTitle.textColor = gray999999;
            subTitle.font = font(12);
            [base addSubview:subTitle];
            [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title).offset(0);
                make.right.offset(0);
                make.height.offset(20);
                make.top.equalTo(title.mas_bottom).offset(5);
            }];
            i++;
        }
    }
    return _activityView;
}


-(void)setBannerImgArr:(NSMutableArray *)bannerImgArr{
    _bannerImgArr = bannerImgArr;
    NSMutableArray *imgArr = @[].mutableCopy;
    for (NSString *url in bannerImgArr)
    {
        [imgArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url]];
    }
    [self.bannerView setImageURLStringsGroup:imgArr];
}
- (void)setTestBannerUrl:(NSString *)testBannerUrl{
    _testBannerUrl = testBannerUrl;
     [self.bannerView setImageURLStringsGroup:@[[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,testBannerUrl]]];
}
#pragma mark - action

#pragma mark 点击cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate SPNewDynamicHeaderViewDidSelectedType:@"categoryClick" index:indexPath.row];
}

#pragma mark  轮播点击事件
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self.delegate SPNewDynamicHeaderViewDidSelectedType:@"bannerClick" index:index];
}

@end
