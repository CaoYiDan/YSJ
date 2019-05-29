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
#import "YSJGetMoneyVC.h"
#import "YSJPopCourserCellView.h"
#import "YSJFactoryForCellBuilder.h"
#import "YSJOrderModel.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJOrderCourseView.h"
#import "YSJDrawBackModel.h"
@interface YSJGetMoneyVC ()<YSJBottomMoreButtonViewDelegate>

@property (nonatomic,strong) YSJDrawBackModel *drawModel;

@end

@implementation YSJGetMoneyVC
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
    
    self.title = @"收款详情";
    
     [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 110)];
    topImg.backgroundColor = [UIColor hexColor:@"FF6960"];
    [_scroll addSubview:topImg];
    
    UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kWindowW, 30)];
    status.textAlignment =NSTextAlignmentCenter;
    status.font = font(24);
    status.text = [NSString stringWithFormat:@"+%.2f元",self.model.real_amount];
    status.textColor =KWhiteColor;
    [topImg addSubview:status];
    
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, kWindowW, 30)];
    time.font = font(12);
    time.textAlignment = NSTextAlignmentCenter;
    time.text = @"收款金额";
    time.textColor =KWhiteColor;
    [topImg addSubview:time];
    
    if ([self.model.sub_status isEqualToString:@"打款中"]) {
        status.text  = @"打款中";
        time.text = @"打款进行中，请耐心等待";
    }
    
    YSJRightYellowCell *backMoney = [[YSJRightYellowCell alloc]initWithFrame:CGRectMake(0, 110, kWindowW, 74) cellH:74 title:@"收款金额" rightText:[NSString stringWithFormat:@"¥%.2f",self.model.real_amount]];
    [_scroll addSubview:backMoney];
    
    //收款路径
    YSJRightGrayCell *backType = [[YSJRightGrayCell alloc]initWithFrame:CGRectMake(0, 110+74, kWindowW, 74) cellH:74 title:@"收款路径" rightText:@"支付宝"];
    [_scroll addSubview:backType];
    
    _tag = backType;
}

-(void)setMiddleView{
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(_tag.mas_bottom).offset(0);
    }];
    
    //退款信息
    UILabel *orderPriceLab = [[UILabel alloc]init];
    orderPriceLab.font = font(16);
    orderPriceLab.textColor = [UIColor hexColor:@"333333"];
    orderPriceLab.text = @"收款信息";
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
    
}

-(void)setBottomView{
    
    int i = 0;

    NSArray *arr = @[@"买家账号",@"订单编号",@"支付方式",@"下单时间"];
    NSArray *contentArr = @[[NSString stringWithFormat:@"%@",self.model.phone],[NSString stringWithFormat:@"%@",self.model.orderId],@"支付宝 ",[NSString stringWithFormat:@"%@",[SPCommon getTimeFromTimestamp:self.model.create_time]]];
    
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

-(void)bottomMoreButtonViewClickWithIndex:(NSInteger)index andTitle:(NSString *)title{
    
}
@end
