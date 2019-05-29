//
//  YSJTeacherCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//


#import "YSJCourseModel.h"

#import "XHStarRateView.h"

#import "YSJMyCareCell.h"

@implementation YSJMyCareCell

{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_teacherType;
    UIButton *renzheng;
    UILabel *_getOrderCount;//接单数量 和评分
    UILabel *_price;
    UILabel *_introduction;
    XHStarRateView *_starRateView;
    UIButton *_careBtn;
}

#pragma mark - init

- (void)initUI{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(16);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    renzheng = [[UIButton alloc]init];
    renzheng.backgroundColor = KWhiteColor;
    renzheng.layer.cornerRadius = 4;
    renzheng.clipsToBounds = YES;
    [renzheng setTitleColor:gray9B9B9B forState:UIControlStateNormal];
    [renzheng setImage:[UIImage imageNamed:@"ic_verified"] forState:0];
    renzheng.titleLabel.font = font(12);
    [self addSubview:renzheng];
    [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name.mas_right).offset(5);
        make.width.offset(12);
        make.height.offset(14);
        make.centerY.equalTo(_name);
    }];
    
    _distance = [[UILabel alloc]init];
    _distance.font = Font(12);
    _distance.textColor = gray999999;
    _distance.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_name);
        make.height.offset(30);
    }];
    
    //评分
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 40, 70, 30) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
    _starRateView = starRateView;
    starRateView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:starRateView];
    
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.width.offset(70);
        make.height.offset(30);
        make.top.equalTo(_name.mas_bottom).offset(6);
    }];
    
    _getOrderCount = [[UILabel alloc]init];
    _getOrderCount.font = font(12);
    _getOrderCount.textAlignment = NSTextAlignmentCenter;
    _getOrderCount.textColor = gray999999;
    _getOrderCount.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_getOrderCount];
    [_getOrderCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_starRateView.mas_right).offset(5);
        make.height.offset(20);
        make.centerY.equalTo(_starRateView);
    }];
    
    //上课类型
    _teacherType = [[UILabel alloc]init];
    _teacherType.font = font(12);
    _teacherType.textAlignment = NSTextAlignmentCenter;
    _teacherType.textColor = gray999999;
    _teacherType.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_teacherType];
    [_teacherType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.top.equalTo(_starRateView.mas_bottom).offset(7);
    }];
    
   
    //介绍
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(12);
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = KWhiteColor;
    _introduction.numberOfLines = 2;
    [self.contentView addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.right.offset(-kMargin); make.top.equalTo(_starRateView.mas_bottom).offset(7);
    }];
    
    UIButton *careBtn = [FactoryUI createButtonWithtitle:@"+关注" titleColor:KWhiteColor imageName:nil backgroundImageName:@"loginbg" target:self selector:@selector(care:)];
    careBtn.layer.cornerRadius = 4;
    careBtn.clipsToBounds = YES;
    [careBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [careBtn setTitle:@"已关注" forState:UIControlStateSelected];
    _careBtn = careBtn;
    [self.contentView addSubview:careBtn];
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(58);
        make.height.offset(24);
        make.centerY.offset(0);
    }];
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

-(void)care:(UIButton *)btn{
    
    NSDictionary * dict = @{@"token":[StorageUtil getId],@"teacherID":self.model.teacher_phone};
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:YCare parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        btn.selected = !btn.isSelected;
        if (btn.isSelected) {
            Toast(@"关注成功");
        }else{
            Toast(@"取消关注");
        }
        [self setCareBtnStatus:btn.selected];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void)setModel:(YSJCourseModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"bg"]];
   
    [_starRateView setStarLeave:model.reputation];
    _name.text = model.nickname;
    
    [renzheng setTitle:[NSString stringWithFormat:@"%.1f",model.reputation] forState:0];
    
    _getOrderCount.text = [NSString stringWithFormat:@"%.1f分   已售%@",model.reputation,model.dealcount];

    _introduction.text = model.sale_item;
 
    [self setCareBtnStatus:YES];
  
}

-(void)setCareBtnStatus:(BOOL)status{
    
    if (status) {
        _careBtn.selected = YES;
        [_careBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _careBtn.layer.borderColor = [UIColor hexColor:@"E6E6E6"].CGColor;
        _careBtn.layer.borderWidth = 1.0f;
        [_careBtn setTitleColor:[UIColor hexColor:@"A5A5A5"] forState:0];
    }else{
        _careBtn.selected = NO;
        _careBtn.layer.borderWidth = 0.0f;
         [_careBtn setTitleColor:KWhiteColor forState:0];
        [_careBtn setBackgroundImage:[UIImage imageNamed:@"loginbg"] forState:UIControlStateNormal];
    }
}
@end
