//
//  BaseViewController.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
}

- (void)createRootNav{
    
    
}

- (void)addLeftTarget:(SEL)selector{
    
    [self.leftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightTarget:(SEL)selector{
    
    [self.rightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
//    self.extendedLayoutIncludesOpaqueBars = YES;
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

@end
