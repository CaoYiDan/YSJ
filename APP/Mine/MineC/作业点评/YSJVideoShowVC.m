//
//  SPActivityWebVC.m

#import "YSJVideoShowVC.h"

@interface YSJVideoShowVC ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView*webView;

@end

@implementation YSJVideoShowVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadWeb];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(kWindowW-60, kWindowH-KBottomHeight-80, 55, 40)];
    [back addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [back setTitle:@"返回" forState:0];
    [self.view addSubview:back];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, kWindowH)];
        _webView.delegate=self;
        [_webView sizeToFit];
        [_webView setScalesPageToFit:YES];
        [self.view addSubview:_webView];
    }
    return _webView;
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadWeb
{
    
    NSURL *url = [NSURL URLWithString:self.url];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

#pragma mark 网页加载结束 代理回调

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    [_webView stringByEvaluatingJavaScriptFromString:js];
    [_webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code  == -999) {
        return;
    }
}
@end
