//
//  ViewController.m
//  LS_Small_Switch
//
//  Created by 融合互联-------lisen on 17/6/22.
//  Copyright © 2017年 RTWM. All rights reserved.
//

#import "SPMyAppointmentVC.h"
#import "LS_SwitchVC.h"
#import "SPReserveMineViewController.h"
@interface SPMyAppointmentVC ()

@property(nonatomic,strong)LS_SwitchVC *switchvc;

@end

@implementation SPMyAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(NSArray*)titleArrInSwitchView{
    return @[@"我的关注",@"关注我的"];
}

-(UIViewController *)swithchVCForRowAtIndex:(NSInteger)index{
    SPReserveMineViewController *vc = [[SPReserveMineViewController alloc]init];
    if (index==0) {
        vc.code=0;
    }else{
        vc.code = 1;
    }
    return vc;
}

@end
