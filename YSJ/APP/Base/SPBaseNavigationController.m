
#import "UIImage+Color.h"

#import "SPBaseNavigationController.h"

@implementation SPBaseNavigationController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    /* 设置title的字体颜色*/
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:KWhiteColor}];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor hexColor:@"FF8960"].CGColor, (__bridge id)[UIColor hexColor:@"FF6960"].CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(.0, 1.0);
    gradientLayer.frame = backView.frame;
    [backView.layer addSublayer:gradientLayer];
    
    //设施导航控制器导航栏的背景图片(遮盖后面的过度黑影（系统自带）)
    [self.navigationBar setBackgroundImage:[self convertViewToImage:backView] forBarMetrics:UIBarMetricsDefault];
    
    //渐变背景色

    //去掉黑线
    [self.navigationBar setShadowImage:[UIImage new]];
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSLog(@"%@",viewController);
    
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
