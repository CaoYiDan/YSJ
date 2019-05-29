//
//  SPActivityWebVC.m

#import "YSJPlatformRulesWebVC.h"

@interface YSJPlatformRulesWebVC ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView*webView;

@end

@implementation YSJPlatformRulesWebVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleLab.textColor = KWhiteColor;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.rule2;
    titleLab.font = font(16);
    self.navigationItem.titleView = titleLab;
    
    [self getData];
    
    //显示菊花加载，有一个缓冲加载的界面
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:self.rule1 forKey:@"rule1"];
    [dic setObject:self.rule2 forKey:@"rule2"];
    [[HttpRequest sharedClient]httpRequestPOST:YRules parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
       self.url = [[NSString stringWithFormat:@"%@%@",@"http://39.98.47.98:8002",responseObject[@"url"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        

        NSLog(@"%@",self.url);
        
        [self loadWeb];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight)];
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
