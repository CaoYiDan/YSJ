//
//  SPMyNeededDetailTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyNeededDetailTableCell.h"
#import "SPKitExample.h"
@implementation SPMyNeededDetailTableCell

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        self.backgroundColor = WC;//RGBCOLOR(239, 239, 239);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 8;
        [self initUI];
        //self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}
- (void)setModel:(SPMineNeededDetailModel *)model{
    
    _model = model;
}
#pragma mark - initUI
- (void)initUI{
    
    self.headIV = [[UIImageView alloc]init];
    //    [self.backView addSubview:self.headIV];
    [self addSubview:self.headIV];
    self.headIV.clipsToBounds = YES;
    self.headIV.layer.cornerRadius = 20;
    
    self.nickNameLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.createTimeLab];
    [self addSubview:self.nickNameLab];
    self.nickNameLab.font = Font(14);
    self.nickNameLab.textAlignment = NSTextAlignmentLeft;
    self.nickNameLab.textColor = [UIColor blackColor];
    
    self.farAwayLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.serGoodLab];
    [self addSubview:self.farAwayLab];
    self.farAwayLab.font = Font(13);
    //self.farAwayLab.numberOfLines = 3;
    self.farAwayLab.textAlignment = NSTextAlignmentLeft;
    self.farAwayLab.textColor = RGBCOLOR(171, 171, 171);
    
    self.modelLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.modelLab];
    [self addSubview:self.modelLab];
    self.modelLab.font = Font(14);
    self.modelLab.textAlignment = NSTextAlignmentLeft;
    self.modelLab.textColor = [UIColor blackColor];
    
    self.serPriceLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.serPriceLab];
    [self addSubview:self.serPriceLab];
    self.serPriceLab.font = Font(14);
    self.serPriceLab.textAlignment = NSTextAlignmentLeft;
    self.serPriceLab.textColor = [UIColor blackColor];
    
    self.delStutasLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.getMoneyStatusLab];
    [self addSubview:self.delStutasLab];
    self.delStutasLab.font = Font(14);
    self.delStutasLab.textAlignment = NSTextAlignmentLeft;
    self.delStutasLab.textColor = [UIColor redColor];
    //认证标识
    self.identiIV = [[UIImageView alloc]init];
    [self addSubview:self.identiIV];
    self.iphoneIV = [[UIImageView alloc]init];
    [self addSubview:self.iphoneIV];
    self.serTimeLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.serTimeLab];
    [self addSubview:self.serTimeLab];
    self.serTimeLab.font = Font(14);
    self.serTimeLab.numberOfLines = 2;
    self.serTimeLab.textAlignment = NSTextAlignmentLeft;
    self.serTimeLab.textColor = [UIColor blackColor];
    
    self.serInfoLab = [[UILabel alloc]init];
    //    [self.backView addSubview:self.serInfoLab];
    [self addSubview:self.serInfoLab];
    self.serInfoLab.font = Font(14);
    self.serInfoLab.numberOfLines = 0;
    //self.serInfoLab.lineBreakMode = NSLineBreakByWordWrapping;
    self.serInfoLab.textAlignment = NSTextAlignmentLeft;
    self.serInfoLab.textColor = [UIColor blackColor];
    //评价或付款
    self.getMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getMoneyBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.getMoneyBtn setTitleColor:WC forState:UIControlStateNormal];
    //    [self.backView addSubview:self.getMoneyBtn];
    [self addSubview:self.getMoneyBtn];
    [self.getMoneyBtn addTarget:self action:@selector(getMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.getMoneyBtn.clipsToBounds = YES;
    self.getMoneyBtn.layer.cornerRadius = 10;
    //修改
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.changeBtn setTitleColor:WC forState:UIControlStateNormal];
    //    [self.backView addSubview:self.changeBtn];
    [self addSubview:self.changeBtn];
    //[self.changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.changeBtn.clipsToBounds = YES;
    self.changeBtn.layer.cornerRadius = 10;
    //发信息
    self.sendMessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendMessageBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.sendMessageBtn setTitleColor:WC forState:UIControlStateNormal];
    //    [self.backView addSubview:self.sendMessageBtn];
    [self addSubview:self.sendMessageBtn];
    [self.sendMessageBtn addTarget:self action:@selector(sendMessageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sendMessageBtn.clipsToBounds = YES;
    self.sendMessageBtn.layer.cornerRadius = 10;
    
    //    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.offset(5);
    //        make.left.offset(5);
    //        make.width.offset(SCREEN_W-10);
    //        make.height.offset(self.frame.size.height-10);
    //    }];
    
    //    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.offset(5);
    //        make.left.offset(5);
    //        make.width.offset(40);
    //        make.height.offset(40);
    //    }];
    //
    //    //成交
    //    [self.delStutasLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.offset(20);
    //        make.right.offset(-20);
    //        make.width.offset(60);
    //        make.height.offset(20);
    //    }];
    //
    //    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.headIV.mas_top).offset(10);
    //        make.left.equalTo(self.headIV.mas_right).offset(5);
    //        make.width.offset(SCREEN_W-160);
    //        make.height.offset(20);
    //    }];
    //    //距离
    ////    [self.farAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
    ////
    ////        make.top.equalTo(self.nickNameLab.mas_bottom);
    ////        make.left.equalTo(self.nickNameLab.mas_left);
    ////        make.width.offset(SCREEN_W-20);
    ////        make.height.offset(20);
    ////    }];
    //
    //    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.headIV.mas_bottom).offset(10);
    //        make.left.equalTo(self.headIV.mas_left);
    //        make.width.offset(SCREEN_W-180);
    //        make.height.offset(20);
    //
    //    }];
    //
    //    [self.serPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.modelLab.mas_bottom).offset(5);
    //        make.left.equalTo(self.headIV.mas_left);
    //        make.width.offset(SCREEN_W-140);
    //        make.height.offset(20);
    //    }];
    //    CGSize maxSize = CGSizeMake(SCREEN_W-30, CGFLOAT_MAX);
    //    NSString * serInfoStr = [NSString stringWithFormat:@"服务介绍: %@",self.model.userIntroduce];
    //    NSLog(@"%@",self.model.userIntroduce);
    //    CGSize textSize = [serInfoStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)} context:nil].size;
    //    [self.serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.serPriceLab.mas_bottom).offset(5);
    //        make.left.equalTo(self.headIV.mas_left);
    //        make.width.offset(SCREEN_W-20);
    //        make.height.offset(textSize.height);
    //    }];
    //
    //    //应聘时间
    //    [self.serTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.serInfoLab.mas_bottom).offset(5);
    //        make.left.equalTo(self.headIV.mas_left);
    //        make.width.offset(SCREEN_W-20);
    //        make.height.offset(20);
    //    }];
    //    //评价或付款
    //    [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.serTimeLab.mas_bottom).offset(20);
    //        make.left.offset(SCREEN_W/2-100);
    //        make.width.offset(80);
    //        make.height.offset(30);
    //
    //    }];
    //
    //    //发信息
    //    [self.sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.serTimeLab.mas_bottom).offset(20);
    //        make.left.offset(SCREEN_W/2+20);
    //        make.width.offset(80);
    //        make.height.offset(30);
    //
    //    }];
    
    //    [self.skillIV mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.getMoneyStatusLab.mas_bottom).offset(10);
    //        make.right.offset(-15);
    //        make.width.offset(30);
    //        make.height.offset(30);
    //    }];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(5);
        make.left.offset(5);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
    //成交
    [self.delStutasLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.right.offset(-20);
        make.width.offset(60);
        make.height.offset(20);
    }];
    
    [self.identiIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.delStutasLab.mas_bottom).offset(20);
        make.right.offset(-20);
        make.width.offset(20);
        make.height.offset(20);
    }];
    
    [self.iphoneIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.identiIV.mas_top);
        make.right.equalTo(self.identiIV.mas_left).offset(5);
        make.width.equalTo(self.identiIV);
        make.height.equalTo(self.identiIV);
    }];
    
    [self.nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_top).offset(10);
        make.left.equalTo(self.headIV.mas_right).offset(5);
        make.width.offset(SCREEN_W-160);
        make.height.offset(20);
    }];
    //距离
    //    [self.farAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.nickNameLab.mas_bottom);
    //        make.left.equalTo(self.nickNameLab.mas_left);
    //        make.width.offset(SCREEN_W-20);
    //        make.height.offset(20);
    //    }];
    
    
    //等级注释
    //    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.top.equalTo(self.headIV.mas_bottom).offset(10);
    //        make.left.equalTo(self.headIV.mas_left);
    //        make.width.offset(SCREEN_W-180);
    //        make.height.offset(20);
    //
    //    }];
    
    [self.serPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_bottom).offset(5);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-140);
        make.height.offset(20);
    }];
    CGSize maxSize = CGSizeMake(SCREEN_W-40, CGFLOAT_MAX);
    NSString * serInfoStr = [NSString stringWithFormat:@"服务介绍: %@",self.model.userIntroduce];
    NSLog(@"%@",self.model.userIntroduce);
    CGSize textSize = [serInfoStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(14)} context:nil].size;
    CGFloat tempHeight = textSize.height +20;
    [self.serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serPriceLab.mas_bottom).offset(5);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(tempHeight);
    }];
    
    //应聘时间
    [self.serTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serInfoLab.mas_bottom).offset(5);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-20);
        make.height.offset(20);
    }];
    //评价或付款
    [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serTimeLab.mas_bottom).offset(20);
        make.left.offset(SCREEN_W/2-100);
        make.width.offset(80);
        make.height.offset(30);
        
    }];
    
    //发信息
    [self.sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serTimeLab.mas_bottom).offset(20);
        make.left.offset(SCREEN_W/2+20);
        make.width.offset(80);
        make.height.offset(30);
        
    }];
    
}

#pragma mark - withMode
- (void)initWithModel:(SPMineNeededDetailModel *)model{
    _model = model;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.headImg]];
    self.nickNameLab.text = model.userName;
    self.iphoneIV.image = [UIImage imageNamed:@"sy_icon_sj"];
    if ([model.identityStatus isEqualToString:CERTIFIED]) {
        self.identiIV.image = [UIImage imageNamed:@"sy_icon_sm"];
    }else{
        
        self.identiIV.image = [UIImage imageNamed:@"sy_icon_smw"];
        
    }
    //self.modelLab.text = [NSString stringWithFormat:@"%@ %@级",model.userPosition,model.userLevel];
    //self.modelLab.textColor = [UIColor redColor];
    //    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.modelLab.text];
    //    NSRange daryGray = NSMakeRange(0,[[noteStr string] rangeOfString:@" "].location);
    //    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:daryGray];
    //    [self.modelLab setAttributedText:noteStr];
    self.serPriceLab.text = [NSString stringWithFormat:@"服务价格: %@ 元%@",model.userPrice,model.userPriceUnit];
    self.serInfoLab.text = [NSString stringWithFormat:@"服务介绍: %@",model.userIntroduce];
    self.serTimeLab.text = [NSString stringWithFormat:@"应聘时间: %@",model.createDateStr];
    if ([model.dealFlag isEqualToString:@"YDEAL"])
    {
        self.delStutasLab.text = @"";//@"成交";
        [self.getMoneyBtn setTitle:@"评价" forState:UIControlStateNormal];
        self.getMoneyBtn.hidden =NO;
        [self.sendMessageBtn setTitle:@"发信息" forState:UIControlStateNormal];
        
    }else
    {
        self.getMoneyBtn.hidden = YES;
        self.delStutasLab.text = @"";//@"未成交";
        [self.sendMessageBtn setTitle:@"发信息" forState:UIControlStateNormal];
    }
}

#pragma mark - 评价或者付款
- (void)getMoneyBtnClick:(UIButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(getMoneyBtnClickForVC:)]) {
        
        [_delegate getMoneyBtnClickForVC:self.model];
    }
}


#pragma mark - sendMessageBtnClickForVC发信息
- (void)sendMessageBtnClick:(UIButton *)btn{
    NSLog(@"%@",self.model.userCode);
    YWPerson *person = [[YWPerson alloc]initWithPersonId:self.model.userCode];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
    //    if ([_delegate respondsToSelector:@selector(sendMessageBtnClickForVC:)]) {
    //
    //        [_delegate sendMessageBtnClickForVC:self.model];
    //    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


