//
//  SPTestViewController.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/11/3.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPTestViewController.h"
#import "SPPerfecSexVC.h"
@interface SPTestViewController ()

@end

@implementation SPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SPPerfecSexVC *vc = [[SPPerfecSexVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
