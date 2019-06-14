//
//  YSJHomeWorkTypeListCell.m
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.
#import "ArcLineView.h"
#import "YSJHongBaoCell.h"
#import "YSJGBModel.h"
#import "YSJTeacher_DetailVC.h"
#import "YSJCompany_DetailVC.h"

@implementation YSJHongBaoCell
{
    UILabel *_price;
    UILabel *_name;
    UILabel *_introduction;
    UILabel *_introduction1;
    UILabel *_introduction12;
    UIImageView *_img;
    UIButton *_getBtn;
    
    ArcLineView *_getCountView;
}

- (void)initUI{
    
//    self.contentView.clipsToBounds = YES;
//
//    _img =  [[UIImageView alloc]init];
//    _img.backgroundColor = grayF2F2F2;
//    _img.contentMode = UIViewContentModeScaleAspectFill;
//  _img.image = [UIImage imageNamed:@"合并形状"];
//    [self.contentView addSubview:_img];
//    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//     }];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(18, 18, 60, 30)];
    _price.font = Font(30);
    _price.adjustsFontSizeToFitWidth = YES;
    _price.backgroundColor = [UIColor whiteColor];
    _price.text = @"30";
    _price.textColor = KMainColor;
    [self.contentView addSubview:_price];
    
   UILabel * diYongQuan = [[UILabel alloc]initWithFrame:CGRectMake(10, 48, 76, 22)];
    diYongQuan.font = Font(13);
    diYongQuan.backgroundColor = [UIColor whiteColor];
    diYongQuan.textAlignment = NSTextAlignmentCenter;
    diYongQuan.text = @"抵用券";
    diYongQuan.textColor = black666666;
    [self.contentView addSubview:diYongQuan];
    
    
   
    
    UIButton *btn = [FactoryUI createButtonWithtitle:@"立即领取" titleColor:KWhiteColor imageName:@"" backgroundImageName:@"" target:self selector:@selector(get:)];
    _getBtn = btn;
    btn.layer.cornerRadius = 15.5;
    btn.clipsToBounds = YES;
    btn.backgroundColor = KMainColor;
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.width.offset(76);
        make.height.offset(31);
        make.centerY.offset(-10);
    }];
    
    ArcLineView *getCountView = [[ArcLineView alloc]init];
    getCountView.backgroundColor = KWhiteColor;
    getCountView.starScore =0.8;
    _getCountView = getCountView;
   
    [self.contentView addSubview:getCountView];
    [getCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-5);
        make.width.offset(76);
        make.height.offset(31);
        make.centerY.offset(-10);
    }];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(16);
    _name.backgroundColor = [UIColor whiteColor];
    _name.textColor = KBlackColor;
    _name.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(87);
        make.right.equalTo(btn.mas_left).offset(-2);
        make.height.offset(22);
        make.top.offset(18);
    }];
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(87, 50, 180, 18)];
    _introduction.font = font(13);
    _introduction.textColor = black666666;
    _introduction.adjustsFontSizeToFitWidth =YES;
    _introduction.text = @"haole ，怎么了";
    [self.contentView addSubview:_introduction];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = RGB(249, 249, 249);
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(35);
        make.bottom.offset(0);
    }];
    
    UIView *bottomView2 = [[UIView alloc]init];
    bottomView2.backgroundColor = [UIColor clearColor];
    bottomView2.clipsToBounds = YES;
    [self.contentView addSubview:bottomView2];
    [bottomView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(10);
        make.bottom.equalTo(bottomView.mas_top).offset(5);
    }];
    
    UIView *leftTag = [[UIView alloc]init];
    leftTag.backgroundColor = RGB(240, 240, 240);
    leftTag.layer.cornerRadius = 5  ;
    leftTag.clipsToBounds = YES;
    [bottomView2 addSubview:leftTag];
    [leftTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(-5);
        make.width.offset(10);
        make.height.offset(10);
        make.top.equalTo(bottomView2).offset(0);
    }];
    
    UIImageView *rightTag = [[UIImageView alloc]init];
    rightTag.backgroundColor = RGB(240, 240, 240);
//    rightTag.image = [UIImage imageNamed:@"left"];
    rightTag.layer.cornerRadius = 5  ;
    rightTag.clipsToBounds = YES;
    [bottomView2 addSubview:rightTag];
    [rightTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(5);
        make.width.offset(10);
        make.height.offset(10);
        make.top.equalTo(bottomView2).offset(0);
    }];
    
    _introduction1 = [[UILabel alloc]initWithFrame:CGRectMake(27, 96, 200, 35)];
    _introduction1.font = font(11);
    _introduction1.textColor = gray999999;
     _introduction1.text = @"haole ，怎么了";
    [self.contentView addSubview:_introduction1];
    
    _introduction12 = [[UILabel alloc]initWithFrame:CGRectMake(27, 96+35, 200, 35)];
    _introduction12.font = font(11);
    _introduction12.textColor = gray999999;
  
     _introduction12.text = @"haole ，怎么了";
//    [self.contentView addSubview:_introduction12];
    
   UILabel * _introduction123 = [[UILabel alloc]init];
    _introduction123.font = font(11);
    _introduction123.textColor = gray999999;
   
    _introduction123.text = @"使用规则";
    [self.contentView addSubview:_introduction123];
    [_introduction123 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.height.offset(35);
        make.top.equalTo(_introduction1).offset(0);
    }];
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    self.contentView.backgroundColor = KWhiteColor;
    self.contentView.layer.shadowOffset = CGSizeMake(1, 2);
    self.contentView.layer.shadowOpacity = 0.4;
    self.contentView.layer.shadowColor = [UIColor hexColor:@"27347d"].CGColor;
}

-(void)get:(UIButton *)btn{

    if ([btn.titleLabel.text isEqualToString:@"已领取"]) {
        
        return;
        
    }else if ([btn.titleLabel.text isEqualToString:@"立即使用"]){
        
        if (self.type == HBTypeUse) {
            !self.block?:self.block();
        
        }else{
            //网络请求
            NSMutableDictionary *dic = @{}.mutableCopy;
            [dic setObject:self.model.ctreater forKey:@"phone"];
            
            [[HttpRequest sharedClient]httpRequestPOST:Yuserdiffer parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
                NSLog(@"%@",responseObject);
                if ([responseObject[@"type"] isEqualToString:@"私教"]) {
                    YSJTeacher_DetailVC * vc = [[YSJTeacher_DetailVC alloc]init];
                    vc.teacherID = self.model.ctreater;
                    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
                }else{
                    YSJCompany_DetailVC * vc = [[YSJCompany_DetailVC alloc]init];
                    vc.companyID = self.model.ctreater;
                    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
                }
           
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
    }else if ([btn.titleLabel.text isEqualToString:@"立即领取"]){
    
        //网络请求
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:self.model.redpacket_id forKey:@"redpacket_id"];
        NSLog(@"%@",dic);
        
        [[HttpRequest sharedClient]httpRequestPOST:Yredpacketget parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            
            Toast(@"领取成功");
            
            [_getBtn setTitle:@"已领取" forState:0];
            _getBtn.backgroundColor = KWhiteColor;
            _getBtn.layer.borderColor = KMainColor.CGColor;
            _getBtn.layer.borderWidth = 1.0f;
            [_getBtn setTitleColor:KMainColor forState:0];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }
}

- (void)setFrame:(CGRect)frame{
    
    CGRect newFrame = frame;
    
    newFrame.origin.x = 16;
    //    newFrame.origin.y-=17;
    newFrame.size.width -= 2*16;
    newFrame.size.height-=17;
    
    [super setFrame: newFrame];
}

- (void)setType:(HBType)type{
    _type = type;
    _getCountView.hidden = YES;
}

- (void)setModel:(YSJGBModel *)model{
    
    _model = model;
    
    _price.text = [NSString stringWithFormat:@"¥%@",model.amount];
    [_price setAttributeTextWithString:_price.text range:NSMakeRange(0, 1) WithColour:KMainColor andFont:12];
    _introduction.text = [NSString stringWithFormat:@"有效期到 %@",[model.endtime componentsSeparatedByString:@"00:00:00"][0]];
    _name.text = model.name;
    _introduction1.text = [NSString stringWithFormat:@"满%@元可用",model.gate];
   _introduction12.text = [NSString stringWithFormat:@"有效期到 %@",[model.endtime componentsSeparatedByString:@"00:00:00"][0]];
    
    if (model.is_used==0) {
        
        _price.textColor = [UIColor hexColor:@"9E9E9E"];
        _introduction.text =@"暂不可用";
        _getBtn.hidden = YES;
        
    }else{
        
        _getBtn.hidden = NO;
        _price.textColor = KMainColor;
        _introduction.text = [NSString stringWithFormat:@"有效期到 %@",[model.endtime componentsSeparatedByString:@"00:00:00"][0]];
    }
    
    if (!isEmptyString(model.state)) {
        [_getBtn setTitle:self.type==HBTypeOnlyGet? @"已领取":@"立即使用" forState:0];
        _getBtn.backgroundColor = KWhiteColor;
        _getBtn.layer.borderColor = KMainColor.CGColor;
        _getBtn.layer.borderWidth = 1.0f;
        [_getBtn setTitleColor:KMainColor forState:0];
    }else{
        [_getBtn setTitle:@"立即领取" forState:0];
        _getBtn.backgroundColor = KMainColor;
        _getBtn.layer.borderColor = KMainColor.CGColor;
        _getBtn.layer.borderWidth = 1.0f;
        [_getBtn setTitleColor:KWhiteColor forState:0];
    }
}

@end
