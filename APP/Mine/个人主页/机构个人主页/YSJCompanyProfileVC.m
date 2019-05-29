//
//  ViewController.m
//  VTMagicView
//
//  Created by tianzhuo on 14-11-11.
//  Copyright (c) 2014年 tianzhuo. All rights reserved.

#import "YSJCompanyProfileVC.h"
#import "MenuInfo.h"
#import "YSJUserModel.h"
#import "YSJProfileHeaderV.h"
#import "YSJChildCompanyLeftVC.h"
#import "YSJChildProfileRightPhotosVC.h"
#import "YSJChilderVCForBuyManager.h"

@interface YSJCompanyProfileVC ()

@property (nonatomic, strong)  NSArray *menuList;

@property (nonatomic, assign)  BOOL autoSwitch;

@property (nonatomic,strong) YSJProfileHeaderV *headerV;
@end

@implementation YSJCompanyProfileVC
{
    NSInteger *selectedIndex;
    NSArray *chanlesArr;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setBaseView];
    
    self.view.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    
    [self getData];
    
    chanlesArr = @[@"",@"",@"",@""];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:User_Company forKey:@"type"];
    [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.model = [YSJUserModel mj_objectWithKeyValues:responseObject];
        
        [self.view addSubview:self.headerV];
        
        [self setMyMarginView];
        
        [self addNotification];
        
        [self generateTestData];
        
        [self setBack];
        
        [self.magicView reloadData];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
    
    if (itemIndex==0) {
        [menuItem setImage:[UIImage imageNamed:@"NewFeeds0"] forState:0];
        [menuItem setImage:[UIImage imageNamed:@"NewFeeds1"] forState:UIControlStateSelected];
    }else{
        [menuItem setImage:[UIImage imageNamed:@"Photos0"] forState:0];
        [menuItem setImage:[UIImage imageNamed:@"Photos1"] forState:UIControlStateSelected];
    }
    
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    
    
    NSString *gridId = @"identifer";
    gridId =  [NSString stringWithFormat:@"%ld---ide",pageIndex];
    
    if (pageIndex==0) {
        
        YSJChildCompanyLeftVC *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = [[YSJChildCompanyLeftVC alloc] init];
        }
        viewController.model = self.model;
        return viewController;
    }else{
        YSJChildProfileRightPhotosVC *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = [[YSJChildProfileRightPhotosVC alloc] init];
        }
        viewController.code = @"2321";
        return viewController;
    }
    
    return [[UIViewController alloc]init];
    
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    
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
    
    NSArray *arr = @[@"",@""];
    
    
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
    
    self.magicView.navigationColor = [UIColor clearColor];
    self.magicView.layoutStyle = VTLayoutStyleDivide;
    self.magicView.switchStyle = VTSwitchStyleDefault;
    self.magicView.headerHeight = 280;
    self.magicView.navigationHeight = 68;
    self.magicView.needPreloading = NO;
    self.magicView.headerHidden = NO;
    self.magicView.sliderExtension = 1;
    self.magicView.sliderHeight = 3;
    self.magicView.separatorColor = [UIColor clearColor];
    self.magicView.dataSource = self;
    self.magicView.delegate = self;
    self.magicView.itemScale = 1.0;
    self.magicView.itemSpacing = 30.f;
    self.magicView.sliderColor = KMainColor;
    self.magicView.backgroundColor = KWhiteColor;
}

-(void)setBaseView{
    
    UIView *base1 = [[UIView alloc]initWithFrame:CGRectMake(0, 280, kWindowW, 68)];
    base1.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    [self.view insertSubview:base1 atIndex:0];
    
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(kMargin, 280, kWindowW-24, kWindowH-280)];
    base.layer.cornerRadius = 8;
    base.clipsToBounds = YES;
    base.backgroundColor = KWhiteColor;
    [self.view insertSubview:base atIndex:1];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [base addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.top.offset(67);
    }];
}

- (YSJProfileHeaderV *)headerV{
    
    if (!_headerV) {
        _headerV = [[YSJProfileHeaderV alloc]initWithFrame:CGRectMake(0, 0, kWindowW,280)];
         _headerV.identifier = self.identifier;
        _headerV.companyModel = self.model;
    }
    return _headerV;
}

-(void)setBack{
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, SafeAreaStateHeight, 70, 44);
    
    button.contentHorizontalAlignment = UIViewContentModeLeft;
    [self.view addSubview:button];
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
