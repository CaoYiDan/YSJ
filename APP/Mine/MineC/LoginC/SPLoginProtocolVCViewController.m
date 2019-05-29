//
//  SPLoginProtocolVCViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLoginProtocolVCViewController.h"

@interface SPLoginProtocolVCViewController (){
    
    UIWebView * _webView;
}

@end

@implementation SPLoginProtocolVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

#pragma mark - createUI
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    topView.backgroundColor = MAINCOLOR;
    [self.view addSubview:topView];
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(10, 25, 30, 30);
    [returnBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnBtn];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-60, 27,120, 30)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10,74, SCREEN_W-20, SCREEN_H)];
    
    //自适应屏幕大小
    _webView.scalesPageToFit = YES;
    
    [self.view addSubview: _webView];
    
    //    if ([self.titleStr isEqualToString:@"关于我们"]) {
    //        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10,74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
    //        textView.text = self.contenStr;
    //        textView.textColor = [UIColor blackColor];
    //        textView.font = [UIFont systemFontOfSize:15];
    //        textView.textAlignment = NSTextAlignmentNatural;
    //        [self.view addSubview:textView];
    //    }else if ([self.titleStr isEqualToString:@"帮助中心"]){
    //
    //        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
    //
    //        textView.text = self.contenStr;
    //        textView.textColor = [UIColor blackColor];
    //        textView.font = [UIFont systemFontOfSize:15];
    //        textView.textAlignment = NSTextAlignmentNatural;
    //        [self.view addSubview:textView];
    //    }else if ([self.titleStr isEqualToString:@"意见反馈"]){
    //
    //        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
    //        textView.text = self.contenStr;
    //
    //        textView.textColor = [UIColor blackColor];
    //        textView.font = [UIFont systemFontOfSize:15];
    //        textView.textAlignment = NSTextAlignmentNatural;
    //        [self.view addSubview:textView];
    //    }
    
    
}
- (void)returnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -  loadData
- (void)loadData{

    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        
    [dic setObject:@"AGREEMENT" forKey:@"type"];
        
    
    
    [[HttpRequest sharedClient]httpRequestPOST:GetContentUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        NSMutableString * str = [[NSMutableString alloc]init];
        [str appendString:responseObject[@"data"][@"content"]];
        //NSString*st =[self.contenStr stringByReplacingOccurrencesOfString:@"p" withString:@"/p"];
        //NSLog(@"%@",self.contenStr);
        [_webView loadHTMLString:str baseURL:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
