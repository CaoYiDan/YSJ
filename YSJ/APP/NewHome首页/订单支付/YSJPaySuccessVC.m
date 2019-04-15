//
//  YSJPaySuccessVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/11.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPaySuccessVC.h"

@interface YSJPaySuccessVC ()

@end

@implementation YSJPaySuccessVC



#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单支付";
    [self setUI];
    
    UIButton *finishBtn  = [FactoryUI createButtonWithtitle:@"完成" titleColor:KWhiteColor imageName:nil backgroundImageName:nil target:self selector:@selector(finishClick)];
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:finishBtn];
}

-(void)setUI{
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"拼"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(50);
        make.height.offset(50);
        make.top.equalTo(self.view).offset(70);
    }];
    
    UILabel *statusLab =[[UILabel alloc]init];
    statusLab.text = @"支付成功";
    statusLab.font = font(14);
    [self.view addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img);
        make.height.offset(20);
        make.top.equalTo(img.mas_bottom).offset(10);
    }];
    
    UILabel *priceLab =[[UILabel alloc]init];
    priceLab.text = @"4556";
    priceLab.font = font(14);
    [self.view addSubview:priceLab];
    [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img);
        make.height.offset(20);
        make.top.equalTo(statusLab.mas_bottom).offset(10);
    }];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.equalTo(priceLab.mas_bottom).offset(10);
    }];
    
    //付款方式
    UILabel *payTypeLab =[[UILabel alloc]init];
    payTypeLab.text = @"付款方式";
    payTypeLab.textColor = gray999999;
    payTypeLab.font = font(14);
    [self.view addSubview:payTypeLab];
    [payTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(50);
         make.top.equalTo(bottomLine.mas_bottom).offset(10);
    }];
    
    
    UILabel *payType =[[UILabel alloc]init];
    payType.text = @"微信";
    payType.textColor = gray999999;
    payType.font = font(14);
    [self.view addSubview:payType];
    [payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(50);
        make.top.equalTo(bottomLine.mas_bottom).offset(10);
    }];
    
    UIView *bottomLine1 = [[UIView alloc]init];
    bottomLine1.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.equalTo(payType.mas_bottom).offset(0);
    }];
    
    
    //商家
    UILabel *sellerLab =[[UILabel alloc]init];
    sellerLab.text = @"商家";
    sellerLab.textColor = gray999999;
    sellerLab.font = font(14);
    [self.view addSubview:sellerLab];
    [sellerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(50);
        make.top.equalTo(bottomLine1.mas_bottom).offset(0);
    }];
    
    
    UILabel *seller =[[UILabel alloc]init];
    seller.text = @"中博";
    seller.textColor = gray999999;
    seller.font = font(14);
    [self.view addSubview:seller];
    [seller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(50);
        make.top.equalTo(bottomLine.mas_bottom).offset(10);
    }];
    
    UIView *bottomLine12 = [[UIView alloc]init];
    bottomLine12.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine12];
    [bottomLine12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.equalTo(sellerLab.mas_bottom).offset(0);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

#pragma mark UITableviewDelegate

#pragma mark UITableviewDataSource

#pragma mark CustomDelegate

#pragma mark event response

-(void)finishClick{
    
}
#pragma mark private methods

#pragma mark getters and setters


@end
