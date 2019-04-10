//
//  SPSystemMessageDetailVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSystemMessageDetailVC.h"

@interface SPSystemMessageDetailVC ()

@end

@implementation SPSystemMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self initNav];
    [self initUI];
    // Do any additional setup after loading the view.
}

#pragma mark - initUI
- (void)initUI{

    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10,0, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
    textView.text = [NSString stringWithFormat:@"  %@",self.contentStr];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    textView.textAlignment = NSTextAlignmentNatural;
    [self.view addSubview:textView];
}

#pragma mark - initNav
- (void)initNav{

    self.titleLabel.text = @"系统通知";
    self.titleLabel.textColor = TitleColor;
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
