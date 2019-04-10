//
//  SPLzsMyFocusViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/15.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsMyFocusViewController.h"
#import "SPReserveMineViewController.h"
#import "SPSecondMineFocusVC.h"
@interface SPLzsMyFocusViewController ()
@property (nonatomic,strong) SPLzsSwichVC *  switchvc;
@end

@implementation SPLzsMyFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(NSArray*)titleArrInSwitchView{
    return @[@"我关注的",@"我的粉丝"];
}

-(UIViewController *)swithchVCForRowAtIndex:(NSInteger)index{
    //SPReserveMineViewController *vc = [[SPReserveMineViewController alloc]init];
    SPSecondMineFocusVC *vc = [[SPSecondMineFocusVC alloc]init];
    if (index==0) {
        vc.code=0;
    }else{
        vc.code = 1;
    }
    return vc;
}


@end
