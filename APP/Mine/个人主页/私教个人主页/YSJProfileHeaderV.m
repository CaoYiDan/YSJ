//
//  YSJProfileHeaderV.m
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJUserModel.h"
#import "YSJProfileHeaderV.h"
#import "YSJTagsView.h"
#import "GTBProfileVC.h"

@implementation YSJProfileHeaderV
{
    UILabel *_name;
    UIImageView *_img;
    YSJTagsView *_introductionView;
    
    UIButton *_editBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    
    /** 背景图片 */
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, SafeAreaTopHeight+120)];
    bgImg.clipsToBounds = YES;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    bgImg.image = [UIImage imageNamed:@"headerbg_my"];
    bgImg.userInteractionEnabled = YES;
    [self addSubview:bgImg];
    
    CGFloat imgWid = 80;
    CGFloat imgH = 80;
  
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(kMargin, SafeAreaStateHeight+40+20, kWindowW-24, 180)];
    downView.layer.cornerRadius = 8;
    downView.clipsToBounds = YES;
    downView.backgroundColor = KWhiteColor;
    [self addSubview:downView];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(16);
    _name.text = @"";
    [downView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.height.offset(20);
        make.top.offset(imgH/2+10);
    }];
    
    //介绍
    _introductionView = [[YSJTagsView alloc]init];
    _introductionView.backgroundColor = KWhiteColor;
    [downView addSubview:_introductionView];
    [_introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_name).offset(0);
        make.height.offset(30);
        make.width.offset(120); make.top.equalTo(_name.mas_bottom).offset(5);
    }];
    
    
    UIButton *sendMessage = [[UIButton alloc]init];
    [sendMessage setTitle:@"编辑资料" forState:0];
    [sendMessage setTitleColor:KWhiteColor forState:UIControlStateNormal];
    sendMessage.backgroundColor =KMainColor;
    sendMessage.layer.cornerRadius = 15;
    sendMessage.clipsToBounds = YES;
    _editBtn = sendMessage;
    sendMessage.titleLabel.font = font(14);
    [sendMessage addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    [downView addSubview:sendMessage];
    [sendMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_introductionView.mas_bottom).offset(13);
        make.width.offset(106);
        make.height.offset(30);
        make.centerX.offset(0);
    }];
    NSLog(@"%@",self.identifier);
    
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 0, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = imgH/2;
    _img.clipsToBounds = YES;
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(imgWid);
        make.height.offset(imgH);
        make.top.equalTo(self).offset(SafeAreaStateHeight+20);
    }];
}

-(void)setIdentifier:(NSString *)identifier{
    
    _identifier = identifier;
    
    if ([self.identifier isEqualToString:User_Normal]) {
       
        _editBtn.hidden = NO;
        
    }else{
        
        _editBtn.hidden = YES;
    }

}

- (void)setCompanyModel:(YSJUserModel *)companyModel{
    
    _companyModel = companyModel;
    
    _name.text =companyModel.name;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,companyModel.venue_pic];
    
    ImgWithUrl(_img,url);
    
    _introductionView.tagsArr = [companyModel.lables componentsSeparatedByString:@","];
    
}

- (void)setModel:(YSJUserModel *)model{
    
    _model = model;
    
    _name.text =model.nickname;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo];
    
    ImgWithUrl(_img,url);
    
    if (_introductionView.tagsArr.count==0) {
        _introductionView.tagsArr = [model.lables componentsSeparatedByString:@","];
        
    }
    
}

-(void)sendMessage{
    
    GTBProfileVC *vc = [[GTBProfileVC alloc]init];
    vc.model = self.model;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}
@end
