//
//  YSJPayForOrderVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/2.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "WXApi.h"
#import "YSJPayForOrderVC.h"
#import <AlipaySDK/AlipaySDK.h>
@interface YSJPayForOrderVC ()<WXApiDelegate,UITextFieldDelegate>

@end

@implementation YSJPayForOrderVC
{
    UIScrollView *_scrollView;
    
    UIView *_section0View;
    UIView *_section1View;
    UIView *_section2View;
    UIView *_section3View;

    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *renzheng;
    UILabel *_getOrderCount;//接单数量 和评分
    UILabel *_price;
    UILabel *_oldPrice;
    UILabel *_introductionView;
    
    UITextField *_countTextFiled;
    
    UITextField *_phoneTextFiled;
    
    UILabel *_orderPrice;
    UILabel *_needPayPrice;
    UILabel *_youHuiQuan;
    
    UIImageView *_zhiImg;
    UIImageView *_weiImg;
    NSString *_payType;
}

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单支付";
    _payType = @"zhi";
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = KWhiteColor;
    [self.view addSubview:_scrollView];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(0, 800);
    
    _section0View = [[UIView alloc]init];
    _section0View.backgroundColor = KWhiteColor;
    [_scrollView addSubview:_section0View];
    [_section0View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(120);
        make.top.offset(0);
    }];
    
    _section1View = [[UIView alloc]init];
    _section1View.backgroundColor = KWhiteColor;
    [_scrollView addSubview:_section1View];
    [_section1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(55*3+6);
        make.top.equalTo(_section0View.mas_bottom).offset(0);
    }];
    
    _section2View = [[UIView alloc]init];
    _section2View.backgroundColor = KWhiteColor;
    [_scrollView addSubview:_section2View];
    [_section2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(55*2);
        make.top.equalTo(_section1View.mas_bottom).offset(0);
    }];
    
    _section3View = [[UIView alloc]init];
    _section3View.backgroundColor = KWhiteColor;
    [_scrollView addSubview:_section3View];
    [_section3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(55*3+6);
        make.top.equalTo(_section2View.mas_bottom).offset(0);
    }];
    
    [self setSection0];
    [self setSection1];
    [self setSection2];
    [self setSection3];
    [self setPayBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)setSection0{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [_section0View addSubview:_img];
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [_section0View addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
   
    
    _distance = [[UILabel alloc]init];
    _distance.font = Font(12);
    _distance.textColor = gray999999;
    _distance.textAlignment = NSTextAlignmentRight;
    [_section0View addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_name);
        make.height.offset(30);
    }];
    
    
    //上课类型
    _teacherType = [[UILabel alloc]init];
    _teacherType.font = font(12);
    _teacherType.textAlignment = NSTextAlignmentCenter;
    _teacherType.textColor = gray999999;
    _teacherType.backgroundColor = [UIColor whiteColor];
    [_section0View addSubview:_teacherType];
    [_teacherType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(20);
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = yellowEE9900;
    _price.backgroundColor = KWhiteColor;
    [_section0View addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.top.equalTo(_teacherType.mas_bottom).offset(5);
        //        make.height.offset(30);
    }];
    
    _oldPrice = [[UILabel alloc]init];
    _oldPrice.font = font(12);
    _oldPrice.textAlignment = NSTextAlignmentRight;
    _oldPrice.textColor = gray999999;
    _oldPrice.backgroundColor = KWhiteColor;
    [_section0View addSubview:_oldPrice];
    [_oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_price.mas_right).offset(10);
        make.bottom.equalTo(_price).offset(0);
    }];
}

-(void)setSection1{
    
   //课时数量
   UILabel *leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 140, 55)];
    leftText.font = font(16);
    leftText.text = @"课时数量";
    [_section1View addSubview:leftText];
    
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchDown];
    [addBtn setImage:[UIImage imageNamed:@"+"] forState:0];
    [_section1View addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(28);
        make.height.offset(24);
        make.top.offset(55/2-12);
    }];
    
    UITextField *countFiled = [[UITextField alloc]init];
    _countTextFiled = countFiled;
    countFiled.backgroundColor = RGB(242, 242, 242);
    countFiled.text = @"1";
    countFiled.textAlignment = NSTextAlignmentCenter;
    [_section1View addSubview:countFiled];
    [countFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addBtn.mas_left).offset(-5);
        make.width.offset(48);
        make.height.offset(24);
        make.top.offset(55/2-12);
    }];
    
    UIButton *minusBtn = [[UIButton alloc]init];
    [minusBtn addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchDown];
    [minusBtn setImage:[UIImage imageNamed:@"-"] forState:0];
    [_section1View addSubview:minusBtn];
    
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countFiled.mas_left).offset(-5);
        make.width.offset(28);
        make.height.offset(24);
        make.top.offset(55/2-12);
    }];
    
    //手机号
    UILabel *leftText2 = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 55, 140, 55)];
    leftText2.font = font(16);
    leftText2.text = @"手机号";
    [_section1View addSubview:leftText2];
    
    
    UITextField *phoneFiled = [[UITextField alloc]init];
    _phoneTextFiled = phoneFiled;
    phoneFiled.backgroundColor = KWhiteColor;
    
    phoneFiled.font = font(12);
    phoneFiled.placeholder = @"请输入用于通知的号码";
    phoneFiled.textAlignment = NSTextAlignmentCenter;
    [_section1View addSubview:phoneFiled];
    [phoneFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(144);
        make.height.offset(24);
        make.centerY.equalTo(leftText2).offset(0);
    }];
    
    //订单总价
   UILabel *_leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin,55*2, 140,55)];
    _leftText.font = font(16);
    _leftText.text = @"订单总价";
    [_section1View addSubview:_leftText];
    
   UILabel *_rightText = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW-100 , 55*2, 88,55)];
    _orderPrice = _rightText;
    _rightText.textAlignment = NSTextAlignmentRight;
    _rightText.textColor = yellowEE9900;
    _rightText.font = font(16);
    _rightText.text = @"388";
    [_section1View addSubview:_rightText];
    
    
    UIView *bottomLine0 = [[UIView alloc]init];
    bottomLine0.backgroundColor = grayF2F2F2;
    [_section1View addSubview:bottomLine0];
    [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.top.offset(55);
    }];
    
    UIView *bottomLine01 = [[UIView alloc]init];
    bottomLine01.backgroundColor = grayF2F2F2;
    [_section1View addSubview:bottomLine01];
    [bottomLine01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.top.offset(55*2);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_section1View addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(6);
        make.bottom.offset(0);
    }];
}

-(void)add{
    
}

-(void)minus{
    
}

-(void)setSection2{
    
    //优惠券
    {
    UILabel *_leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin,0, 140,55)];
    _leftText.font = font(16);
    _leftText.text = @"优惠券";
    [_section2View addSubview:_leftText];
    
    UILabel *_rightText = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW-100 , 0, 88,55)];
    _orderPrice = _rightText;
    _rightText.textAlignment = NSTextAlignmentRight;
    _rightText.textColor = yellowEE9900;
    _rightText.font = font(16);
    _rightText.text = @"388";
    [_section2View addSubview:_rightText];
    
    
    UIView *bottomLine0 = [[UIView alloc]init];
    bottomLine0.backgroundColor = grayF2F2F2;
    [_section2View addSubview:bottomLine0];
    [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.top.offset(55);
    }];
    }
    
    //小计
    {
        UILabel *_leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin,55, 140,55)];
        _leftText.font = font(16);
        _leftText.text = @"小计";
        [_section2View addSubview:_leftText];
        
        UILabel *_rightText = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW-100 , 55, 88,55)];
        _orderPrice = _rightText;
        _rightText.textAlignment = NSTextAlignmentRight;
        _rightText.textColor = yellowEE9900;
        _rightText.font = font(16);
        _rightText.text = @"388";
        [_section2View addSubview:_rightText];
        
        UIView *bottomLine0 = [[UIView alloc]init];
        bottomLine0.backgroundColor = grayF2F2F2;
        [_section2View addSubview:bottomLine0];
        [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(1);
            make.top.offset(55*2-1);
        }];
    }
}

-(void)setSection3{
    {
        UILabel * leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 140,55)];
        leftText.font = font(16);
        leftText.text = @"支付方式";
        [_section3View addSubview:leftText];
    }
    //支付宝支付
    {
   UIImageView *_payImg =[[UIImageView alloc]init];
    [_section3View addSubview:_payImg];
    _payImg.image = [UIImage imageNamed:@"zhi"];
    [_payImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(28);
        make.height.offset(24);
        make.top.offset(55/2-12+55);
    }];
        
        UILabel * leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin+40, 55, 140,55)];
        leftText.font = font(14);
        leftText.text = @"支付宝";
        [_section3View addSubview:leftText];
        
    
  UIImageView *_rightImg =[[UIImageView alloc]init];
   [_section3View addSubview:_rightImg];
    _zhiImg =  _rightImg ;
    _rightImg.image = [UIImage imageNamed:@"选中"];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(15);
        make.height.offset(15);
        make.centerY.equalTo(leftText).offset(0);
    }];
        
        UIView *bottomLine0 = [[UIView alloc]init];
        bottomLine0.backgroundColor = grayF2F2F2;
        [_section3View addSubview:bottomLine0];
        [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(1);
            make.top.offset(55*2-1);
        }];
        
        UIButton *btn = [FactoryUI createButtonWithFrame:CGRectMake(0, 55, kWindowW, 55) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:self selector:@selector(zhi)];
        btn.backgroundColor = [UIColor clearColor];
        [_section3View addSubview:btn];
 }
    //微信支付
    {
        UIImageView *_payImg =[[UIImageView alloc]init];
        [_section3View addSubview:_payImg];
        _payImg.image = [UIImage imageNamed:@"wei"];
        [_payImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.width.offset(28);
            make.height.offset(24);
            make.top.offset(55*2+55/2-12);
        }];
        
        UILabel * leftText = [[UILabel alloc]initWithFrame:CGRectMake(kMargin+40, 55*2, 140,55)];
        leftText.font = font(14);
        leftText.text = @"微信支付";
        [_section3View addSubview:leftText];
        
        
        UIImageView *_rightImg =[[UIImageView alloc]init];
        [_section3View addSubview:_rightImg];
        _rightImg.image = [UIImage imageNamed:@"未选择"];
         _weiImg = _rightImg;
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-kMargin);
            make.width.offset(15);
            make.height.offset(15);
            make.centerY.equalTo(leftText).offset(0);
        }];
        
        UIView *bottomLine0 = [[UIView alloc]init];
        bottomLine0.backgroundColor = grayF2F2F2;
        [_section3View addSubview:bottomLine0];
        [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(1);
            make.top.offset(55*3-1);
        }];
        
        UIButton *btn = [FactoryUI createButtonWithFrame:CGRectMake(0, 55*2, kWindowW, 55) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:self selector:@selector(wei)];
        btn.backgroundColor = [UIColor clearColor];
        [_section3View addSubview:btn];
    }
}

-(void)zhi{
    _payType = @"zhi";
    _zhiImg.image  = [UIImage imageNamed:@"选中"];
     _weiImg.image  = [UIImage imageNamed:@"未选择"];
}

-(void)wei{
    _payType = @"wei";
    _weiImg.image  = [UIImage imageNamed:@"选中"];
    _zhiImg.image  = [UIImage imageNamed:@"未选择"];
}
-(void)setPayBtn{
    UIButton *btn = [FactoryUI createButtonWithFrame:CGRectZero title:@"确认支付" titleColor:nil imageName:nil backgroundImageName:nil target:self selector:@selector(payClick)];
    btn.backgroundColor = KMainColor;

    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.width.offset(kWindowW-40);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-5);
    }];
}

-(void)payClick{
//    [self WXPayWithDict:@{}];
    
//    [[AlipaySDK defaultService] payOrder:@"fd" fromScheme:@"smallpigalipay" callback:^(NSDictionary *resultDic)
//     {
//
//     }];
}

#pragma  mark  从后台获取签名String

-(void)getOrderStringFromJava
{

    
    showMBP;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    
    
    [dic setObject:_payType forKey:@"payChannel"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlForPay parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj)
     {
         hidenMBP;
         
         if ([_payType isEqualToString:WXPay])
         {
             
             [self WXPayWithDict:responseObject[@"data"][@"data"]];
             
         }else if ([_payType isEqualToString:AliPay])
         {
             
             [[AlipaySDK defaultService] payOrder:responseObject[@"data"][@"data"] fromScheme:@"smallpigalipay" callback:^(NSDictionary *resultDic)
              {
                  
              }];
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"服务器错误");
         hidenMBP;
     }];
}

#pragma  mark  调用微信客户端

-(void)WXPayWithDict:(NSDictionary*)credential{
    
    NSString* timeStamp = [NSString stringWithFormat:@"%@",[credential objectForKey:@"timestamp"]];
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [credential objectForKey:@"partnerid"];
    request.prepayId= [credential objectForKey:@"prepayid"];
    request.package = @"Sign=WXPay";
    request.nonceStr= [credential objectForKey:@"noncestr"];
    request.timeStamp= [timeStamp intValue];
    request.sign= [credential objectForKey:@"sign"];
    [WXApi sendReq:request];
}
-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                Toast(@"充值成功！");
                break;
                
            default:
                Toast(@"充值失败。");
                break;
        }
    }
}
@end
