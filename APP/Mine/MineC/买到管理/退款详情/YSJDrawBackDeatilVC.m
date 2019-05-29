//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJDrawBackModel.h"
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplicationCompany_SecondVC.h"
#import "YSJDrawBackDeatilVC.h"
#import "YSJPopCourserCellView.h"
#import "YSJFactoryForCellBuilder.h"
#import "YSJOrderModel.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJOrderCourseView.h"
#import "YSJCountDownView.h"

@interface YSJDrawBackDeatilVC ()<YSJBottomMoreButtonViewDelegate>
@property (nonatomic,strong) YSJDrawBackModel *drawModel;
@end

@implementation YSJDrawBackDeatilVC
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
    
    self.title = @"退款详情";
    
    [self getListRequestisScu:^(BOOL isScu) {
        [self initUI];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)dealloc
{
    NSLog(@"徐璈会");
}
#pragma mark - 获取数据

-(void)getListRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSLog(@"%@",@{@"token":[StorageUtil getId],@"order_id":self.model.order_id});
    [[HttpRequest sharedClient]httpRequestPOST:YCourseQuery parameters:@{@"token":[StorageUtil getId],@"order_id":self.model.order_id} progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        //requestisScu(YES);
        NSLog(@"%@",responseObject);
        self.drawModel = [YSJDrawBackModel mj_objectWithKeyValues:responseObject[@"courses"]];
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
    
    //下拉显示的颜色view
    UIImageView *topV = [[UIImageView alloc]initWithFrame:CGRectMake(0, -500, kWindowW, 500)];
    topV.backgroundColor = [UIColor hexColor:@"FF6960"];
    [_scroll addSubview:topV];
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 110)];
    topImg.backgroundColor = [UIColor hexColor:@"FF6960"];
    //渐变背景色
    [topImg.layer addSublayer:[UIColor setGradualChangingColor:topImg fromColor:@"FF6960" toColor:@"FF6680"]];
    [_scroll addSubview:topImg];
    
    UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(34,20, kWindowW-40, 30)];
    status.font = font(16);
    status.textColor =KWhiteColor;
    [topImg addSubview:status];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(34, 50, 100, 30)];
    time.font = font(12);
    time.textColor =KWhiteColor;
    [topImg addSubview:time];
    
    if ([self.drawModel.drop_status isEqualToString:@"待退款"]) {
        
        if (self.orderType == OrderTypeBuy) {
            
            status.text = @"请等待私教处理";
            time.text = @"";
            
            YSJCountDownView *lefttime = [[YSJCountDownView alloc]initWithFrame:CGRectMake(34, 50, 300, 30)];
            lefttime.leftTime = self.drawModel.left_time;
            [topImg addSubview:lefttime];
            
            _tag = topImg;
            
            [self setWaitBeSureForBuyUI];
            
        }else if(self.orderType == OrderTypeSale){
            
            status.text = @"退款未处理";
            time.text = @"";
            
            _tag = topImg;
            
            [self setBackMoneyAndPathUI];
        }
        
    }else if([self.drawModel.drop_status isEqualToString:@"退款成功"]) {
        
        status.text = @"退款成功";
        time.text = @"";
        
        [self setBackMoneyAndPathUI];
        
    }else if([self.drawModel.drop_status isEqualToString:@"退款失败"]) {
        
        if (self.orderType == OrderTypeBuy) {
            
            status.text = @"退款失败";
            time.text = @"对方拒绝退款";
            
            _tag = topImg;
            
            [self setFailUIForBuy];
            
        }else if(self.orderType == OrderTypeSale){
            
            status.text = @"已拒绝";
            time.text = @"您已拒绝退款";
            
            _tag = topImg;
            
            [self setFailUIForSale];
        }
    }
}

-(void)setMiddleView{
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(_tag.mas_bottom).offset(-1);
    }];
    
    //退款信息
    UILabel *orderPriceLab = [[UILabel alloc]init];
    orderPriceLab.font = font(16);
    orderPriceLab.textColor = [UIColor hexColor:@"333333"];
    orderPriceLab.text = @"退款信息";
    orderPriceLab.backgroundColor = [UIColor whiteColor];
    [_scroll addSubview:orderPriceLab];
    [orderPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.height.offset(30);
    make.top.equalTo(bottomLine.mas_bottom).offset(10);
    }];
    
    YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 200, kWindowW, 102)];
    view.model = self.model;
    [_scroll addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(102);
        make.top.equalTo(orderPriceLab.mas_bottom).offset(0);
    }];
    _tag = view;
    
    if ([self.drawModel.drop_status isEqualToString:@"待退款"] && self.orderType == OrderTypeSale) {
        
        YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
        [_scroll addSubview:bottomView];
        bottomView.delegate = self;
        bottomView.moreColorBtnArr = @[@{@"title":@"确认退款",@"type":@(1)},@{@"title":@"拒绝退款",@"type":@(0)},@{@"title":@"联系买家",@"type":@(0)}];
        bottomView.model = self.model;
        bottomView.orderType  = self.orderType;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.offset(kWindowW);
            make.height.offset(45+6);
            make.top.equalTo(view.mas_bottom).offset(-1);
        }];
        
        _tag = bottomView;
    }
    
    if ([self.drawModel.drop_status isEqualToString:@"退款失败"] && self.orderType == OrderTypeBuy) {
        
        YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
        [_scroll addSubview:bottomView];
        bottomView.delegate = self;
        bottomView.moreColorBtnArr = @[@{@"title":@"联系卖家",@"type":@(0)}];
        bottomView.model = self.model;
        bottomView.orderType  = self.orderType;
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.offset(kWindowW);
            make.height.offset(45+6);
            make.top.equalTo(view.mas_bottom).offset(-1);
        }];
        
        _tag = bottomView;
    }
}

-(void)setBottomView{
    
    int i = 0;
    NSArray *arr = @[];
    NSArray *contentArr = @[];
    if([self.drawModel.drop_status isEqualToString:@"退款失败"]) {
        arr = @[@"退款原因",@"退款金额",@"买家账号",@"订单编号",@"支付方式"];
        NSLog(@"%@",self.model.checktype);
        contentArr = @[self.drawModel.cause,[NSString stringWithFormat:@"¥%.2f",self.model.real_amount],self.model.phone,self.model.order_id,@"支付宝"];
    }else{
        arr = @[@"退款原因",@"退款金额",@"买家账号",@"订单编号",@"支付方式",@"退款时间"];
        NSLog(@"%@",self.model.checktype);
       contentArr = @[self.drawModel.cause,[NSString stringWithFormat:@"¥%.2f",self.model.real_amount],self.model.phone,self.model.order_id,@"支付宝",[SPCommon getTimeFromTimestamp:self.drawModel.time]];
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
        lab2.textAlignment = NSTextAlignmentRight;
        lab2.text = contentArr[i];
        lab2.textColor = gray999999;
        lab2.backgroundColor = [UIColor whiteColor];
        [_scroll addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kWindowW-212);
            
            make.height.offset(30);
            make.width.offset(200); make.centerY.equalTo(lab);
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


-(NSArray *)getBottomBtnArr{
    
    NSArray *arr = @[];
    
    if ([self.model.order_status isEqualToString:@"待付款"]) {
        arr = @[@{@"title":@"去支付",@"type":@(1)},@{@"title":@"取消订单",@"type":@(0)},@{@"title":@"联系私教",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"待授课"]) {
        arr = @[@{@"title":@"授课完成",@"type":@(1)},@{@"title":@"联系私教",@"type":@(0)},@{@"title":@"申请退款",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"待评价"]) {
        arr = @[@{@"title":@"评价",@"type":@(1)},@{@"title":@"删除",@"type":@(0)}];
    }else if ([self.model.order_status containsString:@"退款"]) {
        //        arr = @[@{@"title":@"查看",@"type":@(0)}];
    }else{
        //        arr = @[@{@"title":@"查看",@"type":@(0)}];
    }
    return arr;
}

#pragma mark - 退款失败-卖家UI

-(void)setFailUIForSale{
    
    UILabel *tip1 = [[UILabel alloc]init];
    tip1.text = @"您已拒绝了对方的退款请求";
    tip1.font = font(14);
    tip1.textColor = KBlack333333;
    
    [_scroll addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-20);
        make.height.offset(58);
        make.top.equalTo(_tag.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(tip1).offset(0);
    }];
    
//    UILabel *tip2 = [[UILabel alloc]init];
//    tip2.numberOfLines = 2;
//    tip2.text = @"如果对方拒绝，您可以再次发起退款。\n您也可以联系客服";
//    tip2.font = font(14);
//    tip2.textColor = gray999999;
//
//    [_scroll addSubview:tip2];
//    [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(kMargin);
//        make.width.offset(kWindowW-20);
//        make.height.offset(92);
//        make.top.equalTo(bottomLine.mas_bottom).offset(0);
//    }];
//
    _tag = bottomLine;
}

#pragma mark - 退款失败 -买家UI

-(void)setFailUIForBuy{
    
    UILabel *tip1 = [[UILabel alloc]init];
    tip1.text = @"对方拒绝了您的退款";
    tip1.font = font(14);
    tip1.textColor = KBlack333333;
    
    [_scroll addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-20);
        make.height.offset(58);
        make.top.equalTo(_tag.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(tip1).offset(0);
    }];
    
    UILabel *tip2 = [[UILabel alloc]init];
    tip2.numberOfLines = 2;
    tip2.text = @"如果对方拒绝，您可以再次发起退款。\n您也可以联系客服";
    tip2.font = font(14);
    tip2.textColor = gray999999;
    
    [_scroll addSubview:tip2];
    [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-20);
        make.height.offset(92);
        make.top.equalTo(bottomLine.mas_bottom).offset(0);
    }];
    
    _tag = tip2;
}

#pragma mark 待处理- 买家UI

-(void)setWaitBeSureForBuyUI{
    
    UILabel *tip1 = [[UILabel alloc]init];
    tip1.text = @"您已成功发起退款申请，请耐心等待私教处理。";
    tip1.font = font(14);
    tip1.textColor = KBlack333333;
    
    [_scroll addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-20);
        make.height.offset(58);
        make.top.equalTo(_tag.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.width.offset(kWindowW);
        make.height.offset(1);
        make.bottom.equalTo(tip1).offset(0);
    }];
    
    UILabel *tip2 = [[UILabel alloc]init];
    tip2.numberOfLines = 2;
    tip2.text = @"私教同意或者超时未处理，系统将退款给您\n如果商家拒绝，您可以再次发起退款。";
    tip2.font = font(14);
    tip2.textColor = gray999999;
    
    [_scroll addSubview:tip2];
    [tip2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-20);
        make.height.offset(92);
        make.top.equalTo(bottomLine.mas_bottom).offset(0);
    }];
    
    _tag = tip2;
}

#pragma mark  设置UI退款金额 和 路径 UI
-(void)setBackMoneyAndPathUI{
    
    YSJRightYellowCell *backMoney = [[YSJRightYellowCell alloc]initWithFrame:CGRectMake(0, 110, kWindowW, 74) cellH:74 title:@"退款金额" rightText:[NSString stringWithFormat:@"¥%.2f",self.model.real_amount]];
    [_scroll addSubview:backMoney];
    
    //退款方式
    YSJRightGrayCell *backType = [[YSJRightGrayCell alloc]initWithFrame:CGRectMake(0, 110+74, kWindowW, 74) cellH:74 title:@"退款路径" rightText:[NSString stringWithFormat:@"%@",self.model.checktype]];
    [_scroll addSubview:backType];
    
    _tag = backType;
}

-(void)bottomMoreButtonViewClickWithIndex:(NSInteger)index andTitle:(NSString *)title{
    
}
@end
