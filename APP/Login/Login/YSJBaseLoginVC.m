//
//  YSJBaseLoginVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/15.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJBaseLoginVC.h"

@interface YSJBaseLoginVC ()

@end

@implementation YSJBaseLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //渐变背景色
    [self.view.layer addSublayer:[UIColor setGradualChangingColor:self.view fromColor:@"FF8960" toColor:@"FF62A5"]];
    
    /** 背景图片 */
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,SafeAreaStateHeight, kWindowW, imgH)];
    bgImg.clipsToBounds = YES;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
   
    bgImg.image = [UIImage imageNamed:@"bg"];
    bgImg.userInteractionEnabled = YES;
    [self.view addSubview:bgImg];
    
}


@end
