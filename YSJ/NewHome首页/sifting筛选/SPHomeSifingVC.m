//
//  SPHomeSifingVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeSifingVC.h"

@interface SPHomeSifingVC ()

@end

@implementation SPHomeSifingVC
{
    UIScrollView *_baseView;
    
    UIButton *_man;
    UIButton *_girl;
    
    UIButton *_age25;
    UIButton *_age35;
    UIButton *_age35More;
    
    NSMutableDictionary *_dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dic = @{}.mutableCopy;
    self.navigationItem.title = @"筛选";
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)createUI{
    
    _baseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -SafeAreaTopHeight-40, SCREEN_W, SCREEN_H)];
    _baseView.contentSize = CGSizeMake(0, SCREEN_H+70);
    [self.view addSubview:_baseView];
    
    UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(kMargin,60+SafeAreaTopHeight, 60, 30)];
    sex.font = kFontNormal_14;
    sex.text = @"性别";
    sex.textAlignment = NSTextAlignmentCenter;
    [_baseView addSubview:sex];
    
    NSArray *sexArr = @[@"男",@"女"];
    int i=0;
    for (NSString *sexText in sexArr) {
        UIButton *sexBtn = [[UIButton alloc]initWithFrame:CGRectMake(80+i*(40+15), 60+SafeAreaTopHeight, 40, 30)];
        sexBtn.backgroundColor = [UIColor whiteColor];
//        [sexBtn setImage:[UIImage imageNamed:@""] forState:0];
        [sexBtn setTitle:sexText forState:0];
        [sexBtn setTitleColor:[UIColor blackColor] forState:0];
        sexBtn.titleLabel.font = font(14);
        sexBtn.tag = i;
        sexBtn.layer.cornerRadius = 15;
        sexBtn.clipsToBounds = YES;
        sexBtn.layer.borderColor = [UIColor blackColor].CGColor;
        sexBtn.layer.borderWidth = 1;
        [sexBtn addTarget:self action:@selector(sexChose:) forControlEvents:UIControlEventTouchDown];
        [_baseView addSubview:sexBtn];
        if (i==0) {
            _man = sexBtn;
        }else{
            _girl = sexBtn;
        }
        i++;
}
    
    UILabel *age= [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 110+SafeAreaTopHeight, 60, 30)];
    age.font = kFontNormal_14;
    age.text = @"年龄";
    age.textAlignment = NSTextAlignmentCenter;
    [_baseView addSubview:age];
    
    NSArray *ageArr = @[@"25以下",@"25~35",@"35以上"];
    int j=0;
    for (NSString *ageText in ageArr) {
        
        UIButton *sexBtn = [[UIButton alloc]initWithFrame:CGRectMake(80+j*(60+15), 110+SafeAreaTopHeight, 60, 30)];
        [sexBtn setTitleColor:[UIColor blackColor] forState:0];
        sexBtn.backgroundColor = [UIColor whiteColor];
        [sexBtn setTitle:ageText forState:0];
        sexBtn.titleLabel.font = font(14);
        sexBtn.tag = j;
        sexBtn.layer.cornerRadius = 15;
        sexBtn.clipsToBounds = YES;
        sexBtn.layer.borderColor = [UIColor blackColor].CGColor;
        sexBtn.layer.borderWidth = 1;
        [sexBtn addTarget:self action:@selector(ageChose:) forControlEvents:UIControlEventTouchDown];
        [_baseView addSubview:sexBtn];

        if (j==0) {
            _age25= sexBtn;
        }else if (j==1){
            _age35 = sexBtn;
        }else{
            _age35More = sexBtn;
        }
        j++;

    }
    
    UIButton *sifting = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_H-60-SafeAreaBottomHeight, SCREEN_W-80, 40)];
    sifting.backgroundColor = PrinkColor;
    [sifting setTitle:@"筛选" forState:0];
    sifting.titleLabel.font = font(14);
    sifting.backgroundColor = PrinkColor;
    sifting.layer.cornerRadius = 5;
    sifting.clipsToBounds = YES;
    [sifting addTarget:self action:@selector(sifting) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:sifting];
}

-(void)sexChose:(UIButton *)btn{
    [btn setTitleColor:PrinkColor forState:0];
    btn.layer.borderColor = PrinkColor.CGColor;
    
    UIButton *anotherBtn = nil;
    if (btn.tag==0) {
        [_dic setObject:@"1" forKey:@"gender"];
        anotherBtn = _girl;
    }else{
        [_dic setObject:@"0" forKey:@"gender"];
        anotherBtn = _man;
    }
    
    [anotherBtn setTitleColor:[UIColor blackColor] forState:0];
    anotherBtn.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)ageChose:(UIButton *)btn{
    
    [btn setTitleColor:PrinkColor forState:0];
    btn.layer.borderColor = PrinkColor.CGColor;
    
    [_dic setObject:btn.titleLabel.text forKey:@"age"];
    
    if (btn.tag==0) {
       
        [self setNotSlelcted:_age35];
        [self setNotSlelcted:_age35More];
    }else if(btn.tag==1){
        [self setNotSlelcted:_age35More];
        [self setNotSlelcted:_age25];
    }else{
        [self setNotSlelcted:_age35];
        [self setNotSlelcted:_age25];
    }
}

-(void)setNotSlelcted:(UIButton *)btn{
    [btn setTitleColor:[UIColor blackColor] forState:0];
    btn.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)sifting{
    [self.delegate SPHomeSifingVCSifting:_dic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
