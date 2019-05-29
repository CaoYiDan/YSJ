//
//  LzsOtherViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/21.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "LzsOtherViewController.h"

@interface LzsOtherViewController (){
    
    UIWebView * _webView;
}
@property (nonatomic,copy)NSMutableString * contenStr;
@end

@implementation LzsOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

#pragma mark - loadData
- (void)loadData{
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    
    if ([self.titleStr isEqualToString:@"关于我们"]) {
        
        [dic setObject:@"ABOUT" forKey:@"type"];
        
    }else if ([self.titleStr isEqualToString:@"帮助中心"]){
        
        [dic setObject:@"HELP" forKey:@"type"];
    }
    
    [[HttpRequest sharedClient]httpRequestPOST:GetContentUrl parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        NSMutableString * str = [[NSMutableString alloc]init];
        [str appendString:responseObject[@"data"][@"content"]];
        //NSString*st =[self.contenStr stringByReplacingOccurrencesOfString:@"p" withString:@"/p"];
        NSLog(@"%@",self.contenStr);
        [_webView loadHTMLString:str baseURL:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - createUI
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SafeAreaTopHeight)];
    topView.backgroundColor = MAINCOLOR;
    [self.view addSubview:topView];
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(10, SafeAreaStateHeight+4, 40, 40);
    [returnBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnBtn];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-40, SafeAreaStateHeight, 80, 44)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(10,SafeAreaTopHeight+10, SCREEN_W-20, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight-10)];
    
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
