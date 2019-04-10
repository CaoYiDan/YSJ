//
//  SPActivityWebVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPActivityWebVC.h"

@interface SPActivityWebVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*webView;

@end

@implementation SPActivityWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.titleName;
    titleLab.font = font(16);
    self.navigationItem.titleView = titleLab;
    
    //加载网页
    [self loadWeb];
    
    //显示菊花加载，有一个缓冲加载的界面
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _webView.delegate=self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadWeb
{
    // 1. URL 定位资源,需要资源的地址
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?id=%@",ActivityUrl,self.code]];
    NSURL *url = [NSURL URLWithString:self.url];

    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark 网页加载结束 代理回调
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}



@end
