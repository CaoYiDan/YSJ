//
//  LGEvaluateViewController.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/25.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "LGTextView.h"
#import <IQKeyboardManager.h>
#import "SPEvaluateEditVC.h"



@interface SPEvaluateEditVC ()<UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property(nonatomic,weak)LGTextView *textView;

@end

@implementation SPEvaluateEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];//导航设置
    [[IQKeyboardManager sharedManager]setEnable:YES];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self commitBtn];
}

#pragma  mark - setter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        _scrollView.contentSize=CGSizeMake(0, SCREEN_W+100);
    }
    return _scrollView;
}

//上半部分创建
- (UIView *)topView{
    if (!_topView) {
        _topView =[[UIView alloc]initWithFrame:CGRectMake(0,10, SCREEN_W, 160)];
        _topView.backgroundColor = [UIColor whiteColor];
        [self topUI];
        //        [self mostText];
    }
    return _topView;
}

- (void)topUI{
    
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 1)];
//    line1.backgroundColor = BASEGRAYCOLOR;
//    [self.topView addSubview:line1];
    
    LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(5, 1, SCREEN_W-10, 150)];
    self.textView = textView;
    textView.delegate = self;
    textView.font  = font(16);
    textView.placeholder = @"写下您的评价";
    textView.placeholderColor = [UIColor grayColor];
    [self.topView addSubview:textView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 170, SCREEN_W-20, 1)];
    line.backgroundColor = BASEGRAYCOLOR;
    [self.topView addSubview:line];
    
    [self mostText];
}

-(void)mostText{
    UILabel*maxLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-100, 150, 90, 20)];
    maxLab.text = @"最多500字";
    maxLab.font = font(14);
    maxLab.textAlignment = NSTextAlignmentCenter;
    maxLab.textColor = [UIColor grayColor];
    [self.topView addSubview:maxLab];
}

-(void)commitBtn{
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,IS_IPHONE_X?[UIScreen mainScreen].bounds.size.height-34-60-88:SCREEN_H-60, SCREEN_W-40, 35)];
    commitBtn.layer.borderColor = MyBlueColor.CGColor;
    commitBtn.layer.borderWidth = 1.0f;
    [commitBtn setTitle:@"提交" forState:0];
    commitBtn.titleLabel.font = font(14);
    commitBtn.layer.cornerRadius = 17.5;
    commitBtn.clipsToBounds = YES;
    [commitBtn setTitleColor:MyBlueColor forState:0];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:commitBtn];
}

-(void)commit{
    if (_textView.text.length==0) {
        Toast(@"请写下您的评论");
        return;
    }
    
    NSMutableDictionary *contentDict= [[NSMutableDictionary alloc]init];
    [contentDict setObject:_textView.text forKey:@"content"];
    [contentDict setObject:self.mainCode forKey:@"beCommentedCode"];
    [contentDict setObject:self.beCommented forKey:@"beCommented"];
    [contentDict setObject:[StorageUtil getCode] forKey:@"commentor"];
    [contentDict setObject:self.mainCode forKey:@"mainCode"];
    [contentDict setObject:self.type forKey:@"type"];
    NSLog(@"%@",contentDict);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlFeedComment parameters:contentDict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        Toast(@"评论成功");
        !self.evaluateEditVCBlock?:self.evaluateEditVCBlock();
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
}

//navigation
- (void)setNav{
    self.titleLabel.text = @"评价";
}

#pragma mark - textViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self countWord:textView.text]>=500) {
        
        [[[iToast makeText:(@"您已超出了最大输入字符限制")] setGravity:iToastGravityTop]                      show];
        return NO;
    }
    return YES;
}

-(int)countWord:(NSString *)s
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

#pragma  mark 提交

- (void)onRightButton{
  
    
}

@end
