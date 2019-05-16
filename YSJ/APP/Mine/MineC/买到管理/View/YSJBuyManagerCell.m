//
//  YSJTeacherCell.m
//  SmallPig

//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.

//  YSJHomeTableViewCell.m
//  SmallPig

#import "YSJBuyManagerCell.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJOrderModel.h"
#import "YSJEvaluateVC.h"
#import "YSJOrderDeatilVC.h"
@interface YSJBuyManagerCell ()<YSJBottomMoreButtonViewDelegate>

@end

@implementation YSJBuyManagerCell

{
    UIImageView *_iconImg;
    UILabel *_userName;
    UILabel *_status;
    
    UIImageView *_img;
    
    UILabel *_name;
    
    UILabel *_introduction;
    
    UILabel *_price;
    
    YSJBottomMoreButtonView *_bottomBtnView;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initUI{
    
    _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 15, 24, 24)];
    _iconImg.backgroundColor =[UIColor blueColor];
    _iconImg.layer.cornerRadius =  12;
    _iconImg.clipsToBounds = YES;
    [self.contentView addSubview:_iconImg];
    
    _userName = [[UILabel alloc]init];
    _userName.font = Font(16);
    _userName.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_userName];
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImg.mas_right).offset(10);
        make.height.offset(20);
        make.centerY.equalTo(_iconImg).offset(0);
    }];
    
    
    _status = [[UILabel alloc]init];
    _status.font = Font(13);
    _status.textColor = [UIColor hexColor:@"FF6700"];
    _status.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_status];
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(20);
        make.centerY.equalTo(_iconImg).offset(0);
    }];
    
    UIView *bottomLine0 = [[UIView alloc]init];
    bottomLine0.backgroundColor = grayF2F2F2;
    [self.contentView addSubview:bottomLine0];
    [bottomLine0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.top.offset(54);
    }];
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 55+17, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    _introduction = [[UILabel alloc]init];
    _introduction.backgroundColor = KWhiteColor;
    _introduction.textColor = gray9B9B9B;
    _introduction.font = font(12);
    [self addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    _price = [[UILabel alloc]init];
    _price.font = font(16);
    _price.textColor = yellowEE9900;
    _price.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(_introduction.mas_bottom).offset(7);
    }];
    
    YSJBottomMoreButtonView *bottomView = [[YSJBottomMoreButtonView alloc]init];
    
    _bottomBtnView = bottomView;
    [self.contentView addSubview:bottomView];
    bottomView.delegate = self;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(45+6);
        make.bottom.offset(0);
    }];
}
 
-(void)setModel:(YSJOrderModel *)model{
    
    _model = model;
    
    if (model.pic_url.count!=0) {
         [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.pic_url[0]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    }
   
    if (isEmptyString(model.sub_order_id)) {
        _iconImg.image = [UIImage imageNamed:@"jigoulogo"];
    }else{
        _iconImg.image = [UIImage imageNamed:@"sijiaologo"];
    }
    
    
    _userName.text = model.name;
    
    _status.text = model.order_status;
    
    _name.text = model.title;
    
    _introduction.text = [NSString stringWithFormat:@" %@",model.title];
    _price.text = [NSString stringWithFormat:@"¥%.2f",model.real_amount];
  
    [self setBottomBtn];
}

-(void)setBottomBtn{
    
   
    if (self.orderType == OrderTypeBuy) {
        
        _bottomBtnView.moreColorBtnArr = [self getArrForBuy];
        
    }else if (self.orderType == OrderTypeSell){
        _bottomBtnView.moreColorBtnArr = [self getArrForSell];
    }
    
    _bottomBtnView.model  = self.model;
}

-(NSArray *)getArrForSell{
    
    NSArray *arr = @[];
    
    if ([self.model.order_status isEqualToString:@"未授课"]) {
        arr = @[@{@"title":@"确认授课完成",@"type":@(1)},@{@"title":@"联系买家教",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"交易完成"]) {
        arr = @[@{@"title":@"查看打款进度",@"type":@(0)},@{@"title":@"查看评价",@"type":@(1)}];
    }else if ([self.model.order_status containsString:@"未退款"]) {
        arr = @[@{@"title":@"确认退款",@"type":@(1)},@{@"title":@"联系买家教",@"type":@(0)}];
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
        arr = @[@{@"title":@"确认授课完成",@"type":@(1)},@{@"title":@"联系私教",@"type":@(0)},@{@"title":@"查看",@"type":@(0)}];
    }else if ([self.model.order_status isEqualToString:@"交易完成"]) {
        arr = @[@{@"title":@"评价",@"type":@(1)},@{@"title":@"查看",@"type":@(0)},@{@"title":@"删除",@"type":@(0)}];
    }else if ([self.model.order_status containsString:@"退款"]) {
        arr = @[@{@"title":@"查看",@"type":@(0)}];
    }else if ([self.model.order_status containsString:@"交易成功"]) {
        arr = @[@{@"title":@"联系私教",@"type":@(0)}];
    }
    
    return arr;
}
    
-(void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView *vi in _bottomBtnView.subviews)
    {
        if ([vi isKindOfClass:[UIButton class]]) {
              [vi removeFromSuperview];
        }
      
    }
}

@end
