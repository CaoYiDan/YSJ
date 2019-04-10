//
//  FirstViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView*webView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

/**
 懒加载
 @return webView
 */
- (UIWebView *)webView
{
    if (!_webView){
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kHeaderViewH+kPageMenuH, SCREEN_W,kWindowH-kHeaderViewH-kPageMenuH)];
        _webView.scalesPageToFit = YES;
        _webView.delegate=self;
        [self.tableView addSubview:_webView];

    }
    return _webView;
    
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadWeb
{
    // 1. URL 定位资源,需要资源的地址
    NSURL *url = [NSURL URLWithString:self.url];
    NSLog(@"%@",self.url);
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark 网页加载结束 代理回调
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

-(void)setUrl:(NSString *)url{
    
    _url = url;
    [self loadWeb];
   
}

@end
