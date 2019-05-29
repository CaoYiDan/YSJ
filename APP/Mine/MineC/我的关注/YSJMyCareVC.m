//
//  ViewController.m
//  VTMagicView
//
//  Created by tianzhuo on 14-11-11.
//  Copyright (c) 2014年 tianzhuo. All rights reserved.

#import "YSJMyCareVC.h"
#import "MenuInfo.h"
#import "YSJChildForCareVC.h"

@interface YSJMyCareVC ()

@property (nonatomic, strong)  NSArray *menuList;

@property (nonatomic, assign)  BOOL autoSwitch;

@end

@implementation YSJMyCareVC
{
    NSInteger *selectedIndex;
    NSArray *chanlesArr;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"关注";
    
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
        [menuItem setTitleColor:gray999999 forState:UIControlStateNormal];
        [menuItem setTitleColor:KMainColor forState:UIControlStateSelected];
        menuItem.titleLabel.font = Font(16);
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
    
    NSString *gridId = @"identifer";
    gridId =  [NSString stringWithFormat:@"%ld---identifier",pageIndex];
    
    YSJChildForCareVC *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[YSJChildForCareVC alloc] init];
    }
    
    viewController.type = pageIndex==0?@"私教":@"机构";
    
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
    NSArray *arr = @[];
    
    if ([self.identifier isEqualToString:User_Normal]) {
        arr = @[@"私教",@"机构"];
    }else if ([self.identifier isEqualToString:User_Teacher]) {
       
    }else if ([self.identifier isEqualToString:User_Company]) {
       
    }
    
    NSMutableArray *menuList = [[NSMutableArray alloc] init];
    
    for(int index = 0; index < arr.count; index++) {
        
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:arr[index]];
        menu.index = index;
        [menuList addObject:menu];
    }
    _menuList = menuList;
}

-(void)setMyMarginView{
    
    self.magicView.navigationColor = KWhiteColor;
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.headerHeight = 0;
    self.magicView.navigationHeight = 56;
    self.magicView.needPreloading = NO;
    self.magicView.headerHidden = NO;
    self.magicView.sliderExtension = 20;
    self.magicView.sliderHeight = 3;
    
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    self.magicView.itemScale = 1.0;
    self.magicView.itemSpacing = 30.f;
    self.magicView.sliderColor = KMainColor;
    self.magicView.backgroundColor = KWhiteColor;
}
@end
