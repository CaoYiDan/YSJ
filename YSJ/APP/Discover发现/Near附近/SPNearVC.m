//
//  ViewController.m
//  仿陌陌点点切换
//
//  Created by zjwang on 16/3/28.
//  Copyright © 2016年 Xsummerybc. All rights reserved.
//

#import "SPNearVC.h"
#import "SPNearSifingVC.h"
#import "SPNearModel.h"
#import "CardView.h"
#import "SPShareView.h"
#import "ZLSwipeableView.h"
#import "SPProfileVC.h"

#import "RegisterViewController.h"
static CGFloat maxImgWid = 80;

@interface SPNearVC ()<ZLSwipeableViewDelegate,cardDelegate,ZLSwipeableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic) NSUInteger colorIndex;
@property (nonatomic) NSUInteger curentIndex;//当前展示的index
@property (nonatomic, strong) NSArray *titles;
@property(nonatomic,strong)UIImageView *likeImg;
@property(nonatomic,strong)NSMutableDictionary *siftingDict;
@property(nonatomic,strong)UILabel *noMoreLab;
@property(nonatomic,strong)UIScrollView*baseScrollView;
@property(nonatomic,strong)SPShareView *shareView;

@end

@implementation SPNearVC

//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
//        _shareView.shareImg = self..image;
    }
    return _shareView;
}

-(UIScrollView *)baseScrollView{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//        [self.view addSubview:_baseScrollView];
        _baseScrollView.contentSize= CGSizeMake(SCREEN_W+1, 0);
        _baseScrollView.userInteractionEnabled = YES;
    }
    return _baseScrollView;
}

-(UILabel*)noMoreLab{
    if (!_noMoreLab) {
        UILabel *noMore = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 100, 40)];
        
        noMore.textAlignment = NSTextAlignmentCenter;
        noMore.backgroundColor = [UIColor redColor];
        noMore.text = @"没有更多了";
        noMore.userInteractionEnabled = YES;
//        _noMoreLab.center = self.view.center;
        
    }
    return _noMoreLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.baseScrollView];

    [self baseConfig];
    
    self.siftingDict = @{}.mutableCopy;
    
    [self.view addSubview:self.noMoreLab];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //根据筛选信息 请求附近的人
    [self loadNearPerson];
    
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    if ([[StorageUtil getIfQuit] isEqualToString:@"1"]) {
        
        [self baseConfig];
        
        [StorageUtil saveIfQuit:@"0"];
    }
}

//-(void)goToLogin{
//    RegisterViewController *vc = [[RegisterViewController alloc]init];
//    [[SPCommon getCurrentVC] presentViewController:vc animated:YES completion:nil];
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)baseConfig{
    
    self.view.backgroundColor = BASEGRAYCOLOR;
    self.colorIndex = 0;
    self.curentIndex = 0;
    self.siftingDict = [[NSMutableDictionary alloc]init];
    //注册筛选的按钮的点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(siftingNotification:) name:NotificationSiftingForNear object:nil];
}

#pragma  mark - -----------------请求数据-----------------

#pragma  mark  获取最新的筛选信息

-(void)getHistorySifting{
    
    if (isEmptyString([StorageUtil getCode])) {
        
        self.siftingDict = @{}.mutableCopy;
        //根据筛选信息 请求附近的人
        [self loadNearPerson];
        return;
    }
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlHistorySifting parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.siftingDict = isEmptyString(responseObject[@"data"])?@{}.mutableCopy:(NSMutableDictionary*)responseObject[@"data"];
        
        //根据筛选信息 请求附近的人
        [self loadNearPerson];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark   根据筛选信息 请求附近的人

-(void)loadNearPerson{
    
    NSMutableDictionary *dic = self.siftingDict.mutableCopy;
    NSLog(@"%@",dic);

    [dic setObject:isEmptyString([StorageUtil getUserAddresssDict][@"city"])?@"":[StorageUtil getUserAddresssDict][@"city"] forKey:@"city"];
    
    [dic setObject:[SPCommon getLonDic] forKey:@"location"];

    [dic setObject:@"1" forKey:@"pageNum"];
    [dic setObject:@"40" forKey:@"pageSize"];
    [dic setObject:[StorageUtil getCode] forKey:@"userCode"];

    [[HttpRequest sharedClient]httpRequestPOST:kUrlSearchUser parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.listArr = [SPNearModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self configSwipeableView];
        
        [self reloadSwipeableView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        
    }];
}

-(void)configSwipeableView{
    
    [self.baseScrollView addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
 self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)reloadSwipeableView{
    self.curentIndex = 0;
    self.colorIndex = 0;
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionHorizontal;
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}

#pragma mark - ZLSwipeableViewDelegate
//现在是左滑不做处理，右滑关注
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    
    if (direction == ZLSwipeableViewDirectionLeft) {
        //左滑动 不喜欢
//        [self likeOrNotLike:2];
    }else if ( direction == ZLSwipeableViewDirectionRight){
        //右滑动 关注
        [self likeOrNotLike:1];
    }
    
    _curentIndex++;
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    //移动结束，回复最小尺寸
    _likeImg.mj_size= CGSizeMake(30, 30);
    //将图片置空
    [_likeImg setImage:[UIImage imageNamed:@""]];
    //移除
    [_likeImg removeFromSuperview];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    
    //添加是否喜欢的图片
    [view addSubview:self.likeImg];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    if (translation.x>0) {//喜欢
        [_likeImg setImage:[UIImage imageNamed:@"n_like"]];
        _likeImg.originX = 10;
    }else{//不喜欢
        [_likeImg setImage:[UIImage imageNamed:@"n_nolike"]];
        _likeImg.originX = SCREEN_W-60-maxImgWid-10;
    }
    //是否是达到最大的图片尺寸
    CGFloat wid =  30+fabs(translation.x)>maxImgWid?maxImgWid:30+fabs(translation.x);
    //动画变化图片尺寸
    [UIView animateWithDuration:0.1 animations:^{
        _likeImg.mj_size= CGSizeMake(wid, wid);
    }];
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
    //移动结束，回复最小尺寸
    _likeImg.mj_size= CGSizeMake(30, 30);
    //将图片置空
    [_likeImg setImage:[UIImage imageNamed:@""]];
    //移除
    [_likeImg removeFromSuperview];
}
// up down left right
- (void)handle:(UIButton *)sender
{
    HandleDirectionType type = sender.tag;
    switch (type) {
        case HandleDirectionOn:
            [self.swipeableView swipeTopViewToUp];
            break;
        case HandleDirectionDown:
            [self.swipeableView swipeTopViewToDown];
            break;
        case HandleDirectionLeft:
            [self.swipeableView swipeTopViewToLeft];
            break;
            
        case HandleDirectionRight:
            [self.swipeableView swipeTopViewToRight];
            break;
        default:
            break;
    }
}

- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}


#pragma mark - ZLSwipeableViewDataSource 数据来源

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {


    if (self.colorIndex >= self.listArr.count  ) {
        return nil;
    }
    
    //
    SPNearModel *user = self.listArr[self.colorIndex];
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    
    if (IS_IPHONE_X) {
        view.frame = CGRectMake(swipeableView.originX, swipeableView.originY-20, swipeableView.frameWidth, swipeableView.frameHeight-150);
    }else
    {
        
    }
    
    view.backgroundColor = [UIColor whiteColor];
    view.model = user;
    view.delegate = self;
    view.userInteractionEnabled = YES;
    view.tag = 110;
    NSLog(@"%lu",self.colorIndex);
    // ++
    self.colorIndex++;
    return view;
}

#pragma  mark - -----------------卡片交互-----------------
//点击分享
-(void)clickShareWithImage:(UIImage *)shareImg{
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view addSubview:self.shareView];
        self.shareView.shareImg = shareImg;
        self.shareView.hidden = NO;
        self.shareView.originY = 0;
    }];
}

//点击卡片 进入详情
-(void)cardViewClick{
    SPProfileVC*vc =[[SPProfileVC alloc]init];
    SPNearModel *user = self.listArr[self.curentIndex];
    vc.titleName = user.nickName;
    vc.code = user.code;
//    vc.haveLikeBtn = YES;
//    WeakSelf;
//    vc.likeOrNo = ^(NSInteger feel){
//        if (feel == 2) {//不喜欢
//            [weakSelf.swipeableView swipeTopViewToLeft];
//        }else if (feel == 1){//喜欢
//            [weakSelf.swipeableView swipeTopViewToRight];
//        }
//    };
        [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];

}

-(void)likeOrNotLike:(NSInteger) feel{
    
    if (self.curentIndex>=self.listArr.count-1 || self.listArr.count == 0) {
        self.swipeableView.allowedDirection = ZLSwipeableViewDirectionNone;
        return;
    }
    SPNearModel *curentCard = self.listArr[self.curentIndex];
    
    NSDictionary * dict = @{@"followerCode":[StorageUtil getCode],@"userCode":curentCard.code};
    
    [[HttpRequest sharedClient]httpRequestPOST:FollowUrl parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

#pragma  mark - -----------------action-----------------
//筛选通知
-(void)siftingNotification:(NSNotification *)notify{
    self.siftingDict = notify.object;
    [self loadNearPerson];
}

#pragma  mark  进入详情

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    if ([touch view].tag == 110) {
        
            }
}

#pragma  mark - -----------------setter-----------------
//是否喜欢
-(UIImageView *)likeImg{
    if (!_likeImg) {
        _likeImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-60-50, 10, 30, 30)];
    }
    return _likeImg;
}

-(NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (ZLSwipeableView *)swipeableView
{
    if (_swipeableView == nil) {
        _swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectMake(30, 30, SCREEN_W-60, SCREEN_H -100)];
        _swipeableView.allowedDirection =ZLSwipeableViewDirectionHorizontal;
    }
    return _swipeableView;
}


@end
