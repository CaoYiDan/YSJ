//
//  ViewController.m

#import "AppDelegate.h"
#import "YSJTeacherDetailVC.h"
#import "YSJTeacherHeaderView.h"

#import "MFPayFinishModel.h"
#import "APViewController.h"
#import "PlayViewController.h"
#import "SPPageMenu.h"
#import "MFDetailLiveModel.h"
#import "MFNewLiveModel.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "HttpRequest.h"
//#import "AFHTTPRequestOperation.h"
#import "AFNetworking.h"
@interface MFDetailLiveVC () <SPPageMenuDelegate,UIScrollViewDelegate,NSXMLParserDelegate,ZHAsyncSocketDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MyHeaderView *headerView;
@property (nonatomic, strong) SPPageMenu *pageMenu;

@property (nonatomic, assign) CGFloat lastPageMenuY;

@property (nonatomic, assign) CGPoint lastPoint;

@property (nonatomic,strong) UIView *bottomV;
@end

@implementation MFDetailLiveVC
{
    MFDetailLiveModel *_detailModel;
    NSString *_flag;
    BOOL _buy;
}
#pragma mark - 声明周期
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 如果你是自定义导航栏，将下面这两行代码打开，再设置kNaviH为一个你想要的导航栏高度
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"课程详情";
    
    self.lastPageMenuY = kHeaderViewH;
    
    [self socketContent];
    
    //接收支付成功的通知，更改订单课程的状态。
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeOrderSucceed) name:@"ChangeOrderSucceeForLive" object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}




#pragma mark - 初始化UI

-(void)initUI{
    
    // 添加一个全屏的scrollView
    [self.view addSubview:self.scrollView];
    
    // 添加分页菜单
    [self.view addSubview:self.pageMenu];
    
    // 添加3个子控制器
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    
    [self addChildViewController:firstVc];
    
    // 先把headerView添加到第一个子控制器上
    firstVc.headerView = self.headerView;
    
    firstVc.url = _detailModel.link;
    
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    secondVc.classroomArr = _detailModel.schedule;
    [self addChildViewController:secondVc];
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.classroomArr = _detailModel.information;
    [self addChildViewController:thirdVC];
    
    // 先将第一个子控制的view添加到scrollView上去
    [self.scrollView addSubview:self.childViewControllers[0].view];
    
    // 监听子控制器中scrollView正在滑动所发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subScrollViewDidScroll:) name:ChildScrollViewDidScrollNSNotification object:nil];
    // 监听自控制器的刷新状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshState:) name:ChildScrollViewRefreshStateNSNotification object:nil];
    
    [self setBottomUI];
}
#pragma mark - 获取数据
-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    
    [dic setObject:self.model.into forKey:@"id"];
    
    [[HttpRequest sharedClient]postWithUrl:KLivecontent body:dic success:^(NSDictionary *response) {
        
        self->_detailModel = [MFDetailLiveModel mj_objectWithKeyValues:response];
        //将
        self->_detailModel.ifBuy = self->_buy;
        //初始化UI
        [self initUI];
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)setBottomUI{
    
    //如果是审核状态，不展示购买信息，则修改为 已 支付状态
    if ([[StorageUtil getIfCheckIng]isEqualToString:@"1"]) {
        _detailModel.ifBuy = YES;
    }
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    bottomView.backgroundColor = KBackgroundColor;
    [self.view addSubview:bottomView];
    self.bottomV = bottomView;
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(49+kBotttomHeight);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    UIButton *buyBtn = [FactoryUI createButtonWithtitle:_detailModel.ifBuy?self.model.liveType==0?@"未开播":@"开始学习":@"购买" titleColor:KWhiteColor imageName:nil backgroundImageName:nil target:self selector:@selector(buyClick)];
    buyBtn.backgroundColor = self.model.buy?KMainColor:KYellowColor;
    [bottomView addSubview:buyBtn];
    buyBtn.titleLabel.font = Font(15);
    buyBtn.frame = CGRectMake(kWindowW-96, 0, 96, 49);
    
    UILabel *totalMoneyLabel = [FactoryUI createLabelWithFrame:CGRectZero text:[NSString stringWithFormat:@"合计金额:¥%@",self.model.price] textColor:KYellowColor font:Font(12)];
    
    [bottomView addSubview:totalMoneyLabel];
    [totalMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buyBtn.left).offset(0);
        make.width.offset(160);
        make.height.offset(49);
        make.top.offset(0);
    }];
    
    totalMoneyLabel.attributedText =  [totalMoneyLabel procesString:@"合计金额：" withcolour:[UIColor hexColor:@"999999"] withfont:12 with:[NSString stringWithFormat:@"¥%@",self.model.price] withcolour:KYellowColor withfont:23];
    
    //如果已经购买，则隐藏购买按钮，显示 开始学习 按钮
    if (_detailModel.ifBuy)
    {
        totalMoneyLabel.hidden = YES;
        
        buyBtn.originX = 0;
        
        buyBtn.frameWidth = kWindowW;
        
    }
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(void)buyClick{
    
    if (_detailModel.ifBuy)//已购买 进入直播间
    {
        if (self.model.liveType==0) {
            ToastError(@"暂未开播");
            
        }else{
            
            AppDelegate * app = [UIApplication sharedApplication].delegate;
            app.shouldChangeOrientation = YES;
            PlayViewController *vc = [[PlayViewController alloc]init];
            vc.isLivePlay = YES;
            vc.liveUrl = _detailModel.livelink;
            vc.classroom = self.model.roomid;
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
    }else//未购买
    {
        //支付跳转
        APViewController *vc = [[APViewController alloc]init];
        vc.price = _model.price;
        vc.payType = @"直播";
        vc.className =self.model.into;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

#pragma mark - 通知
// 子控制器上的scrollView已经滑动的代理方法所发出的通知
- (void)subScrollViewDidScroll:(NSNotification *)noti {
    
    // 取出当前正在滑动的tableView
    UIScrollView *scrollingScrollView = noti.userInfo[@"scrollingScrollView"];
    CGFloat offsetDifference = [noti.userInfo[@"offsetDifference"] floatValue];
    
    CGFloat distanceY;
    
    BaseViewControllera *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
    
    // 取出的scrollingScrollView并非是唯一的，当有多个子控制器上的scrollView同时滑动时都会发出通知来到这个方法，所以要过滤
    if (scrollingScrollView == baseVc.scrollView && baseVc.isFirstViewLoaded == NO) {
        // 让分页菜单跟随scrollView滑动
        CGRect pageMenuFrame = self.pageMenu.frame;
        
        if (pageMenuFrame.origin.y >= kNaviH) {
            // 往上滑
            if (offsetDifference > 0) {
                
                if (((scrollingScrollView.contentOffset.y+self.pageMenu.frame.origin.y)>=kHeaderViewH) || scrollingScrollView.contentOffset.y < 0) {
                    // 分页菜单的y值等于当前正在滑动且显示在屏幕范围内的的scrollView的contentOffset.y的改变量(这是最难的点)
                    pageMenuFrame.origin.y += -offsetDifference;
                    if (pageMenuFrame.origin.y <= kNaviH) {
                        pageMenuFrame.origin.y = kNaviH;
                    }
                    
                }
            } else { // 往下滑
                if ((scrollingScrollView.contentOffset.y+self.pageMenu.frame.origin.y)-kNaviH<kHeaderViewH) {
                    pageMenuFrame.origin.y = -scrollingScrollView.contentOffset.y+kHeaderViewH+kNaviH;
                }
            }
        }
        self.pageMenu.frame = pageMenuFrame;
        
        // 配置头视图的y值
        [self adjustHeaderY];
        
        // 记录分页菜单的y值改变量
        distanceY = pageMenuFrame.origin.y - self.lastPageMenuY;
        self.lastPageMenuY = self.pageMenu.frame.origin.y;
        
        // 让其余控制器的scrollView跟随当前正在滑动的scrollView滑动
        [self followScrollingScrollView:scrollingScrollView distanceY:distanceY];
        
    }
    baseVc.isFirstViewLoaded = NO;
}

// 所有子控制器上的特定scrollView同时联动
- (void)followScrollingScrollView:(UIScrollView *)scrollingScrollView distanceY:(CGFloat)distanceY{
    BaseViewControllera *baseVc = nil;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        baseVc = self.childViewControllers[i];
        if (baseVc.scrollView == scrollingScrollView) {
            continue;
        } else {
            // 除去当前正在滑动的 scrollView之外，其余scrollView的改变量等于分页菜单的改变量
            CGPoint contentOffSet = baseVc.scrollView.contentOffset;
            contentOffSet.y += -distanceY;
            baseVc.scrollView.contentOffset = contentOffSet;
        }
    }
}

// 此方法是难点
- (void)adjustHeaderY {
    // 取出当前子控制器
    BaseViewControllera *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
    CGRect headerFrame = self.headerView.frame;
    // 将pageMenu的frame转换到当前正在滑动的scrollView上去（这一步很关键）
    CGRect pageMenuFrameInScrollView = [self.pageMenu convertRect:self.pageMenu.bounds toView:baseVc.scrollView];
    // 每个tableView的头视图的y值都等于pageMenu的y值减去头部高度，这是为了保证头部的底部永远跟pageMenu的顶部紧贴
    headerFrame.origin.y = pageMenuFrameInScrollView.origin.y-kHeaderViewH;
    self.headerView.frame = headerFrame;
}

- (void)refreshState:(NSNotification *)noti {
    BOOL state = [noti.userInfo[@"isRefreshing"] boolValue];
    // 正在刷新时禁止self.scrollView滑动
    self.scrollView.scrollEnabled = !state;
    // 正在刷新时禁止触发分页菜单的item事件，爱奇艺app中没有处理这个地方，所以当刷新时爱奇艺本身有一个bug，这里我就处理一下
    self.pageMenu.userInteractionEnabled = !state;
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (!self.childViewControllers.count) {return;}
    
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        // 如果动画为NO,会立即调用scrollViewDidScroll，scrollViewDidScroll中做了一个很重要的操作：调整headerView的y值，如果先调scrollViewDidScroll,然后继续来到此方法走完剩余代码，走到targetViewController.headerView = self.headerView这一行时，内部把头视图的origin都归0了，所以有时会导致headerView的origin为(0,0)的情况,我解释一下origin为(0,0)的现象:比如往上滑动第一个tableView，滑动100个像素，停，这时横向滑动scrollView切换到第二个tableView，往下滑动tableView，滑动100个像素，第二个tableView恢复到了原始位置，当然分页菜单也回到了原始位置，头视图亦如此，那么这时，切换回第一个talbeView，分页菜单已经回到了原始位置，但是此时如果将headerView的origin归0，headerView的位置是跟第一个tableView的头视图的origin一致的，也就是说headerView跟分页菜单分离了，我们要的是headerView跟分页菜单pageMenu紧紧贴住，这也是要adjustHeaderY的原因
        // 要解决上面这个问题，归根结底是要先走完本方法，再去走scrollViewDidScroll，有一种办法是设置动画为YES，如果有动画，不会那么快的调用scrollViewDidScroll，至少有一个动画时间，但是具体多长不太清楚。第二种方法就是将其放在主线程，但是这种办法其实也不是特别牢靠，异步到底谁先走也没有个定数
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
        });
    } else {
        // 动画为YES，会迟一些走scrollViewDidScroll
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
        });
        
    }
    BaseViewControllera *targetViewController = self.childViewControllers[toIndex];
    if (self.scrollView.dragging || self.scrollView.decelerating || self.scrollView.contentOffset.x/kScreenW == self.pageMenu.selectedItemIndex) {
        // 这次赋值作用很大，有2点:第一:切换了headerView的父视图;第二:将headerView的x,y值都归0了
        targetViewController.headerView = self.headerView;
    }
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    // 是第一次加载控制器的view，这个属性是为了防止下面的偏移量的改变导致走scrollViewDidScroll
    targetViewController.isFirstViewLoaded = YES;
    
    targetViewController.view.frame = CGRectMake(kScreenW*toIndex, 0, kScreenW, kScreenH);
    UIScrollView *s = targetViewController.scrollView;
    CGPoint contentOffset = s.contentOffset;
    contentOffset.y = -self.pageMenu.frame.origin.y+kHeaderViewH+kNaviH;
    
    if (contentOffset.y >= kHeaderViewH) {
        contentOffset.y = kHeaderViewH;
    }
    s.contentOffset = contentOffset;
    [self.scrollView addSubview:targetViewController.view];
    
}

#pragma mark - scrollViewDelegate----(self.scrollView的代理方法)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.scrollView) {
        // 将当前控制器的view带到最前面去，这是为了防止下一个控制器的view挡住了头部
        BaseViewControllera *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
        if ([baseVc isViewLoaded]) {
            [self.scrollView bringSubviewToFront:baseVc.view];
        }
        
        // 这个条件的意思是，因为手指滑动
        if (scrollView.dragging || scrollView.decelerating) {
            // 横向切换tableView时头部不要跟随tableView偏移,tableView往东，headerView就往西
            CGRect headerFrame = self.headerView.frame;
            headerFrame.origin.x = scrollView.contentOffset.x-kScreenW*self.pageMenu.selectedItemIndex;
            self.headerView.frame = headerFrame;
            
        } else { // 如果不是手指滑动,通过点击pageMenu上的item而导致的滑动。这里先将headerView加到self.view上，目的是过渡一下，如果不过渡，当点击的是相邻item时，改变scrollView的偏移量使用了动画参数，这个动画会导致切换headerView父视图时会有一个轻微的闪跳现象
            CGRect rectInView = [self.headerView convertRect:self.headerView.bounds toView:self.view];
            rectInView.origin.x = 0;
            [self adjustHeaderY];
            [self.view addSubview:self.headerView];
            self.headerView.frame = rectInView;
            
            if (scrollView.contentOffset.x/kScreenW == self.pageMenu.selectedItemIndex) {
                [self.headerView removeFromSuperview];
                baseVc.headerView = self.headerView;
                [self adjustHeaderY];
            }
        }
        
        // 如果scrollView的内容很少，在屏幕范围内，则自动回落
        if (scrollView.contentOffset.x/kScreenW == self.pageMenu.selectedItemIndex) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (baseVc.scrollView.contentSize.height < kScreenH && [baseVc isViewLoaded]) {
                    [baseVc.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            });
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self adjustHeaderY];
    }
    BaseViewControllera *baseVc = self.childViewControllers[self.pageMenu.selectedItemIndex];
    // 这个方法是因为手指拖拽了scrollView松开手指，结束减速时调用，如果是因为代码改变scrollView偏移量不会来到这个方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (baseVc.scrollView.contentSize.height < kScreenH && [baseVc isViewLoaded]) {
            [baseVc.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    });
}

- (void)btnAction:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"退下吧" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma - lazy

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, kNaviH, kScreenW, kScreenH-bottomMargin);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenW*4, 0);
    }
    return _scrollView;
}

- (MyHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[MyHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenW, kHeaderViewH);
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.model = self.model;
    }
    return _headerView;
}

- (SPPageMenu *)pageMenu {
    
    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame)+kNaviH, kScreenW, kPageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
        
        [_pageMenu setItems:@[@"课程介绍",@"课程表",@"老师介绍"] selectedItemIndex:0];
        _pageMenu.delegate = self;
        _pageMenu.itemTitleFont = Font(15);
        _pageMenu.selectedItemTitleColor = [UIColor blackColor];
        _pageMenu.unSelectedItemTitleColor = [UIColor blackColor];
        _pageMenu.tracker.backgroundColor = KMainColor;
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        _pageMenu.bridgeScrollView = self.scrollView;
        _pageMenu.bridgeScrollView.bounces = YES;
        _pageMenu.bridgeScrollView.contentSize = CGSizeMake(kWindowW*3, 0);
    }
    return _pageMenu;
}

#pragma mark - 网络请求
-(void)socketContent{
    [[ZHAsyncSocket sharedInstance] beginAndsetPort:MainPort];
    [ZHAsyncSocket sharedInstance].delagate = self;
    //    HudDarkShow;
}

#pragma mark - socket 代理
//链接成功
-(void)ZHAsyncSocketDelagateDidConnectWithProt:(UInt16)prot{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getUserPhone] forKey:@"username"];
    [dic setObject:@"1803" forKey:@"sessionType"];
    
    [dic setObject:self.model.into forKey:@"MthodID"];
    
    NSLog(@"%@",dic);
    
    [[ZHAsyncSocket sharedInstance] sendJsonDic:dic WithTag:-1];
}

//获取主服务器的返回数据
-(void)ZHAsyncSocketDelagateDidReadData:(NSDictionary *)dic{
    
    NSLog(@"%@",dic);
    
    if ([dic[returnType] isEqualToString:@"00"])
    {
        _buy = YES;//已购买
    }else{
        _buy = NO;//未购买
    }
    
    [self getData];
}

#pragma mark - 获取时间戳（T+时间戳）
-(NSString *)p_getOrderNum{
    
    NSDateFormatter* formatter2 = [NSDateFormatter new];
    [formatter2 setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeT = [NSString stringWithFormat:@"T%@",[formatter2 stringFromDate:[NSDate date]]];
    return timeT;
}
#pragma mark - 支付成功后 更改订单状态
-(void)changeOrderSucceed{
    
    [[MFPayFinishModel sharedInstance]socktContentForQuestionPayWithUserName:[StorageUtil getUserPhone] className:self.model.into orderNum:[self p_getOrderNum] Complete:^(NSMutableDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        if ([dic[returnType] isEqualToString:@"00"])
        {
            Toast(@"购买成功");
            
            _detailModel.ifBuy = YES;
            
            for (UIView *vi in self.bottomV.subviews) {
                [vi removeFromSuperview];
            }
            
            [self setBottomUI];
            
        }else
        {
            ToastError(@"购买失败，请联系客服");
        }
    }];
}
@end


