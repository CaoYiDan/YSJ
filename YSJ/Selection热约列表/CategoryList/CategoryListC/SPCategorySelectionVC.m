//
//  SPCategorySelectionVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPNearVC.h"
#import "SPCategorySelectionVC.h"

#import "SPCategoryViewController.h"

@interface SPCategorySelectionVC ()

@property(nonatomic,strong)SPCategorySwichVC *switchvc;

@end

@implementation SPCategorySelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSArray * )titleArrInSwitchView{
    
    return @[@"综合",@"距离"];
    
}

-(UIViewController *)swithchVCForRowAtIndex:(NSInteger)index{
    SPCategoryViewController *vc = [[SPCategoryViewController alloc]init];
    vc.titleString = self.titleString;
    if (index==0) {
        vc.code=0;
    }else if(index==1){
        vc.code = 1;
    }
//    else if (index==2){
//    
//        vc.code =2;
//    }else{
//    
//        vc.code = 3;
//    }
    return vc;
}
- (void)createNav{
    
    self.titleLabel.text = self.titleString;
    self.titleLabel.textColor = [UIColor blackColor];
    
    [self.rightButton setTitle:@"附近" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addRightTarget:@selector(rightButtonClick)];
    
//    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    [leftButton setImage:[UIImage imageNamed:@"back"] forState:0];
//    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}
//返回
-(void)leftButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 附近
- (void)rightButtonClick{
    
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPNearVC *vc = [[SPNearVC alloc]init];
    vc.navigationItem.title = @"附近";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
