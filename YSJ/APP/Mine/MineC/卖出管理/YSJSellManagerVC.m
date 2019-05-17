//
//  ViewController.m
//  VTMagicView
//
//  Created by tianzhuo on 14-11-11.
//  Copyright (c) 2014年 tianzhuo. All rights reserved.

#import "YSJSellManagerVC.h"
#import "MenuInfo.h"
#import "YSJChilderVCForBuyManager.h"

@interface YSJSellManagerVC ()

@property (nonatomic, strong)  NSArray *menuList;

@property (nonatomic, assign)  BOOL autoSwitch;

@end

@implementation YSJSellManagerVC
{
    NSInteger *selectedIndex;
    NSArray *chanlesArr;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"卖出管理";
    
    [self setMyMarginView];
    
    [self addNotification];
    
    [self generateTestData];
    
    [self.magicView reloadData];
    
    chanlesArr = @[@"",@"",@"",@""];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification
- (void)addNotification {
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (MenuInfo *send in _menuList) {
        [titleList addObject:send.title];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    
    static NSString *itemIdentifier = @"item";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:KBlack333333 forState:UIControlStateNormal];
        [menuItem setTitleColor:KBlack333333 forState:UIControlStateSelected];
        menuItem.titleLabel.font = Font(14);
    }
    // 默认会自动完成赋值
    MenuInfo *menuInfo = _menuList[itemIndex];
    [menuItem setTitle:menuInfo.title forState:UIControlStateNormal];
    //    NSArray *arr = @[@"政策法规",@"导游业务",@"全国导基",@"地方导基",@"服务能力"];
    //    menuItem.titleLabel.adjustsFontSizeToFitWidth = YES;
    //    [menuItem setTitle:arr[itemIndex] forState:UIControlStateSelected];
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    MenuInfo *menuInfo = _menuList[pageIndex];
    
    NSString *gridId = @"identifer";
    gridId =  [NSString stringWithFormat:@"%ld---identifier",pageIndex];
    
    YSJChilderVCForBuyManager *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[YSJChilderVCForBuyManager alloc] init];
        viewController.orderType = OrderTypeSell;
    }
    viewController.type = pageIndex;
    return viewController;

    
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidAppear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    NSLog(@"didSelectItemAtIndex:%ld", (long)itemIndex);
}

#pragma mark - actions
- (void)subscribeAction {
    NSLog(@"subscribeAction");
    
    [self.magicView setHeaderHidden:!self.magicView.isHeaderHidden duration:0.35];
}

#pragma mark - functional methods

- (void)generateTestData {
    
    NSArray *arr = @[@"全部",@"待授课",@"已完成",@"退款"];
    
    NSMutableArray *menuList = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < arr.count; index++) {
        
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:arr[index]];
        menu.index = index;
        [menuList addObject:menu];
    }
    
    _menuList = menuList;
}

- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBACOLOR(169, 37, 37, 0.6) forState:UIControlStateSelected];
    [rightButton setTitleColor:RGBCOLOR(169, 37, 37) forState:UIControlStateNormal];
    [rightButton setTitle:@"+" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    rightButton.center = self.view.center;
    self.magicView.rightNavigatoinItem = rightButton;
}

-(void)setMyMarginView{
    
    self.magicView.navigationColor = KWhiteColor;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.headerHeight = 0;
    self.magicView.navigationHeight = 44;
    self.magicView.needPreloading = NO;
    self.magicView.headerHidden = NO;
    self.magicView.sliderExtension = 1;
    self.magicView.sliderHeight = 3;
    
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    self.magicView.itemScale = 1.0;
    self.magicView.itemSpacing = 30.f;
    self.magicView.sliderColor = KMainColor;
    self.magicView.backgroundColor = KWhiteColor;
}
@end
