//
//  ROCBaseNavigationController.m
//  Ticketing
//
//  Created by 融合互联-------lisen on 16/11/1.
//  Copyright © 2016年 RHHL. All rights reserved.
//
#import "UIImage+Color.h"
#import "SPBaseNavigationController.h"

@implementation SPBaseNavigationController
-(void)viewDidLoad{
    [super viewDidLoad];
    /* 设置title的字体颜色*/
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KWhiteColor}];
    //设施导航控制器导航栏的背景图片(遮盖后面的过度黑影（系统自带）)
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:KMainColor] forBarMetrics:UIBarMetricsDefault];
    
    //渐变背景色
//    [self.navigationBar.layer addSublayer:[UIColor setGradualChangingColor:self.view fromColor:@"FF8960" toColor:@"FF62A5"]];
    
    //去掉黑线
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(-30, 0, 70, 44);
        
        button.contentHorizontalAlignment = UIViewContentModeLeft;
      
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    
    [super pushViewController:viewController animated:animated];
}

-(void)back:(UIButton*)btn{
    [self popViewControllerAnimated:YES];
}

@end
