//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplicationCompany_SecondVC.h"
#import "YSJOrderDeatilVC.h"
#import "YSJPopCourserCellView.h"
#import "YSJFactoryForCellBuilder.h"
#import "YSJOrderModel.h"
#import "YSJBottomMoreButtonView.h"

#define cellH 76

@interface YSJOrderDeatilVC ()<YSJBottomMoreButtonViewDelegate>

@end

@implementation YSJOrderDeatilVC
{
    UIScrollView  *_scroll;

    YSJFactoryForCellBuilder *_builder;
    
    UIView *_tag;

    //中间object
    UIImageView *_iconImg;
    UILabel *_userName;
    UILabel *_status;
    UIImageView *_img;
    UILabel *_name;
    UILabel *_introduction;
    UILabel *_price;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self getListRequestisScu:^(BOOL isScu) {
        [self initUI];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 获取数据

-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    [[HttpRequest sharedClient]httpRequestPOST:YCourseUserBuyDeatil parameters:@{@"token":@"MTU1ODA4NTMzMy40MTUyMzU1OjA0YWI2ZTBkNzIyYmZkODRhYjIxNzIzMGQ1ZmRmNGQ0MmFkOGYxNzI=",@"id":self.model.orderId} progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //        requestisScu(YES);
        NSLog(@"%@",responseObject);
        self.model = [YSJOrderModel mj_objectWithKeyValues:responseObject];
        NSLog(@"%.2f",self.model.real_amount);
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - UI

-(void)initUI{
    
    [self setBaseView];
    
    [self topView];
    
    [self setMiddleView];
    
    [self setBottomView];
    
}

-(void)setBaseView{
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scroll.backgroundColor = KWhiteColor;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
    [self.view addSubview:_scroll];
}


-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
   
    if ([self.model.order_status isEqualToString:@"待付款"]) {
         topImg.image = [UIImage imageNamed:@"step3_1"];
    }else if ([self.model.order_status isEqualToString:@"待授课"]) {
       topImg.image = [UIImage imageNamed:@"step3_2"];
    }else if ([self.model.order_status isEqualToString:@"交易完成"]) {
       topImg.image = [UIImage imageNamed:@"step3_3"];
    }else if ([self.model.order_status containsString:@"退款"]) {
         topImg.image = [UIImage imageNamed:@"step3_3"];
    }else if([self.model.order_status containsString:@"交易成功"]){
         topImg.image = [UIImage imageNamed:@"step3_4"];
    }else{
        topImg.image = [UIImage imageNamed:@"step3_4"];
    }
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:topImg];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    _tag = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
    }];
    
    _tag = bottomLine;
}

-(void)setMiddleView{
    
    _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 132, 24, 24)];
    _iconImg.backgroundColor =[UIColor blueColor];
    _iconImg.layer.cornerRadius =  12;
    _iconImg.clipsToBounds = YES;
    [_scroll addSubview:_iconImg];
    
    _userName = [[UILabel alloc]init];
    _userName.font = Font(16);
    _userName.text = @"sennenen";
    _userName.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(10);
        make.height.offset(20);
        make.centerY.equalTo(_iconImg).offset(0);
    }];
    
    
    UIView *bottomLine0 = [[UIView alloc]init];
    bottomLine0.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine0];
    [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.top.equalTo(_iconImg.mas_bottom).offset(15);
    }];
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 132+35+17, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [_scroll addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    _introduction = [[UILabel alloc]init];
    _introduction.backgroundColor = KWhiteColor;
    _introduction.textColor = gray9B9B9B;
    _introduction.font = font(12);
    [_scroll addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        
        make.height.offset(14);
         make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(_img.mas_bottom).offset(25);
    }];
    
    _tag = bottomLine;
    
    int i = 0;
    NSArray *arr = @[@"课程总价",@"课时数",@"优惠券"];
    NSArray *contentArr = @[[NSString stringWithFormat:@"¥%d",self.model.amount],[NSString stringWithFormat:@"%d节课",self.model.times],@"0"];
    
    for (NSString *str in arr) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.font = font(13);
        lab.text = str;
        lab.textColor = gray999999;
        lab.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            
            make.height.offset(30);
        make.top.equalTo(_tag.mas_bottom).offset(10);
        }];
        
        UILabel *lab2 = [[UILabel alloc]init];
        lab2.font = font(13);
        lab2.textAlignment = NSTextAlignmentRight;
        lab2.text = contentArr[i];
        lab2.textColor = gray999999;
        lab2.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kWindowW-112);
            
            make.height.offset(30);
            make.width.offset(100); make.centerY.equalTo(lab);
        }];
        
        _tag = lab;
        
        i++;
    }
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(_tag).offset(10);
    }];
   
    
    //订单总价
    UILabel *orderPriceLab = [[UILabel alloc]init];
    orderPriceLab.font = font(14);
    orderPriceLab.textColor = [UIColor hexColor:@"444444"];
    orderPriceLab.text = @"订单总价";
    orderPriceLab.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:orderPriceLab];
    [orderPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(30);
        make.top.equalTo(bottomLine2.mas_bottom).offset(10);
    }];
    
    
    //订单总价
    UILabel *orderPrice = [[UILabel alloc]init];
    orderPrice.font = font(16);
    orderPrice.textAlignment = NSTextAlignmentRight;
    orderPrice.textColor = yellowEE9900;
    orderPrice.text  = [NSString stringWithFormat:@"¥%.2f",self.model.real_amount];
    orderPrice.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:orderPrice];
    [orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.left.offset(kWindowW-100-12);
        make.height.offset(30);
        make.top.equalTo(bottomLine2.mas_bottom).offset(10);
    }];
    
    YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
    if (self.orderType == OrderTypeBuy) {
        
        bottomView.moreColorBtnArr = [self getArrForBuy];
        
    }else if (self.orderType == OrderTypeSell){
        bottomView.moreColorBtnArr = [self getArrForSell];
    }
  
    bottomView.model = self.model;
    [_scroll addSubview:bottomView];
    bottomView.delegate = self;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(45+6);
        make.top.equalTo(orderPrice.mas_bottom).offset(10);
    }];
    
    _tag = bottomView;
    
    [self setOrderModel];
    
}
-(void)setOrderModel{
    
    if (self.model.pic_url.count!=0) {
        [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,self.model.pic_url[0]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    }
    
    if (isEmptyString(self.model.sub_order_id)) {
        _iconImg.image = [UIImage imageNamed:@"jigoulogo"];
    }else{
        _iconImg.image = [UIImage imageNamed:@"sijiaologo"];
    }
    
    _userName.text = self.model.name;
    
    _status.text = self.model.order_status;
    
    _name.text = self.model.title;
    
    _introduction.text = [NSString stringWithFormat:@" %@",self.model.title];
    _price.text = [NSString stringWithFormat:@"¥%.2f",self.model.real_amount];
    
}
-(void)setBottomView{
    
    //订单信息
    UILabel *orderMessage = [[UILabel alloc]init];
    orderMessage.font = font(16);
    orderMessage.textColor = KBlack333333;
    orderMessage.backgroundColor = [UIColor whiteColor];
    orderMessage.text = @"订单信息";
    [_scroll addSubview:orderMessage];
    [orderMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(30);
        make.top.equalTo(_tag.mas_bottom).offset(10);
    }];
    _tag = orderMessage;
    
    int i = 0;
    
    NSArray *arr = @[];
    NSArray *contentArr = @[];
    
    if ([self.model.order_status isEqualToString:@"待付款"]) {
        
        arr = @[@"买家账号",@"订单编号",@"下单时间"];
        contentArr = @[[NSString stringWithFormat:@"%@",self.model.phone],[NSString stringWithFormat:@"%@",self.model.orderId],[NSString stringWithFormat:@"%@",[SPCommon getTimeFromTimestamp:self.model.create_time]]];
        
    }else{
        
        arr = @[@"买家账号",@"订单编号",@"支付方式",@"下单时间"];
        contentArr = @[[NSString stringWithFormat:@"%@",self.model.phone],[NSString stringWithFormat:@"%@",self.model.orderId],[NSString stringWithFormat:@"%@",self.model.checktype],[NSString stringWithFormat:@"%@",[SPCommon getTimeFromTimestamp:self.model.create_time]]];
    }
   
    for (NSString *str in arr) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.font = font(13);
        lab.text = str;
        lab.textColor = gray999999;
        lab.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            
            make.height.offset(30);
            make.top.equalTo(_tag.mas_bottom).offset(10);
        }];
        
        UILabel *lab2 = [[UILabel alloc]init];
        lab2.font = font(13);
        lab2.text = contentArr[i];
        lab2.textAlignment = NSTextAlignmentRight;
        lab2.textColor = gray999999;
        lab2.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(200);
            make.left.offset(kWindowW-212);
            make.height.offset(30);
            make.centerY.equalTo(lab);
        }];
        
        _tag = lab;
        
        i++;
    }
}

#pragma mark - action

-(void)next{
    
    NSArray *keyArr = @[@"name",@"otherphone",@"datetime",@"address",@"sale_item"];
    
    int i = 0 ;
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in [_builder getAllContent]) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            [dic setObject:value forKey:keyArr[i]];
        }
        i++;
    }
    
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YcompanyStep1 parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        pushClass(YSJApplicationCompany_SecondVC);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(NSArray *)getArrForSell{
    
    NSArray *arr = @[];
    
    if ([self.model.order_status isEqualToString:@"未授课"]) {
        arr = @[@{@"title":@"确认授课完成",@"type":@(1)},@{@"title":@"联系买家教",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"交易完成"]) {
        arr = @[@{@"title":@"查看打款进度",@"type":@(1)},@{@"title":@"查看评价",@"type":@(0)},@{@"title":@"联系买家",@"type":@(0)}];
    }else if ([self.model.order_status containsString:@"未退款"]) {
        arr = @[@{@"title":@"确认退款",@"type":@(1)},@{@"title":@"联系买家教",@"type":@(0)},@{@"title":@"拒绝退款",@"type":@(0)}];
    }else if([self.model.order_status isEqualToString:@"已退款"]){
        arr = @[@{@"title":@"联系买家",@"type":@(0)}];
    }
    
    return arr;
}

-(NSArray *)getArrForBuy{
    
    NSArray *arr = @[];
    
    if ([self.model.order_status isEqualToString:@"待付款"]) {
        arr = @[@{@"title":@"去支付",@"type":@(1)},@{@"title":@"取消订单",@"type":@(0)},@{@"title":@"联系私教",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"待授课"]) {
        arr = @[@{@"title":@"确认授课完成",@"type":@(1)},@{@"title":@"联系私教",@"type":@(0)},@{@"title":@"申请退款",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"交易完成"]) {
        arr = @[@{@"title":@"评价",@"type":@(1)},@{@"title":@"联系私教",@"type":@(0)}];
    }else if ([self.model.order_status containsString:@"退款"]) {
        
    }else if ([self.model.order_status containsString:@"交易成功"]) {
        arr = @[@{@"title":@"联系私教",@"type":@(0)}];
    }
    
    return arr;
}


-(void)bottomMoreButtonViewClickWithIndex:(NSInteger)index andTitle:(NSString *)title{
   
}

@end
