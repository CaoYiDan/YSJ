//
//  SPLzsMySkillsTableViewCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsMySkillsTableViewCell.h"

@implementation SPLzsMySkillsTableViewCell
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

//- (instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//
//        //[self initUI];
//
//    }
//    return self;
//}

#pragma mark - initUI
- (void)initUI{

    self.backView = [[UIView alloc]init];
    NSLog(@"%f %f cell的height",self.backView.frame.size.height,self.frame.size.height);
    self.backView.backgroundColor = WC;
    self.backView.clipsToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    
    //[self addSubview:self.backView];
    
    
    
    self.headIV = [[UIImageView alloc]init];
//    [self.backView addSubview:self.headIV];
    [self addSubview:self.headIV];
    self.headIV.clipsToBounds = YES;
    self.headIV.layer.cornerRadius = 4;
    
    self.modelLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.modelLab];
    [self addSubview:self.modelLab];
    self.modelLab.font = Font(13);
    self.modelLab.textAlignment = NSTextAlignmentLeft;
    self.modelLab.textColor = [UIColor blackColor];
    
    self.serPriceLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serPriceLab];
    [self addSubview:self.serPriceLab];
    self.serPriceLab.font = Font(13);
    self.serPriceLab.textAlignment = NSTextAlignmentLeft;
    self.serPriceLab.textColor = [UIColor blackColor];
    
    self.getMoneyStatusLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.getMoneyStatusLab];
    [self addSubview:self.getMoneyStatusLab];
    self.getMoneyStatusLab.font = Font(13);
    self.getMoneyStatusLab.textAlignment = NSTextAlignmentLeft;
    self.getMoneyStatusLab.textColor = [UIColor redColor];
    //诚意金图片
    self.honestMoneyIV = [[UIImageView alloc]init];
    [self addSubview:self.honestMoneyIV];
    
    self.createTimeLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.createTimeLab];
    [self addSubview:self.createTimeLab];
    self.createTimeLab.font = Font(13);
    self.createTimeLab.textAlignment = NSTextAlignmentLeft;
    self.createTimeLab.textColor = [UIColor blackColor];
    
    self.serTimeLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serTimeLab];
    [self addSubview:self.serTimeLab];
    self.serTimeLab.font = Font(13);
    self.serTimeLab.numberOfLines = 2;
    self.serTimeLab.textAlignment = NSTextAlignmentLeft;
    self.serTimeLab.textColor = [UIColor blackColor];
    
    self.serInfoLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serInfoLab];
    [self addSubview:self.serInfoLab];
    self.serInfoLab.font = Font(13);
    self.serInfoLab.numberOfLines = 3;
    self.serInfoLab.textAlignment = NSTextAlignmentLeft;
    self.serInfoLab.textColor = [UIColor blackColor];
    
    self.serGoodLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serGoodLab];
    [self addSubview:self.serGoodLab];
    self.serGoodLab.font = Font(13);
    self.serGoodLab.numberOfLines = 3;
    self.serGoodLab.textAlignment = NSTextAlignmentLeft;
    self.serGoodLab.textColor = [UIColor blackColor];
    
    self.getMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getMoneyBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.getMoneyBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.getMoneyBtn];
    [self addSubview:self.getMoneyBtn];
    [self.getMoneyBtn addTarget:self action:@selector(getMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.getMoneyBtn.clipsToBounds = YES;
    self.getMoneyBtn.layer.cornerRadius = 6;
    //修改
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.changeBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.changeBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.changeBtn];
    [self addSubview:self.changeBtn];
    [self.changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.changeBtn.clipsToBounds = YES;
    self.changeBtn.layer.cornerRadius = 6;
    //删除
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    [self.deleteBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.deleteBtn];
    [self addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.clipsToBounds = YES;
    self.deleteBtn.layer.cornerRadius = 6;
    
//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.offset(5);
//        make.left.offset(5);
//        make.width.offset(SCREEN_W-10);
//        make.height.offset(self.frame.size.height-10);
//    }];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(5);
        make.left.offset(5);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_top);
        make.left.equalTo(self.headIV.mas_right).offset(5);
        make.width.offset(SCREEN_W-140);
        make.height.offset(20);
        
    }];
    
    [self.serPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.modelLab.mas_bottom);
        make.left.equalTo(self.headIV.mas_right).offset(5);
        make.width.offset(SCREEN_W-140);
        make.height.offset(20);
    }];
    
    [self.getMoneyStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.right.offset(-5);
        make.width.offset(80);
        make.height.offset(20);
    }];
    //诚意金
    [self.honestMoneyIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.getMoneyStatusLab.mas_bottom).offset(10);
        make.right.offset(-40);
        make.width.offset(30);
        make.height.offset(40);
    }];
    
    [self.createTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_bottom).offset(10);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-10);
        make.height.offset(20);
    }];
    
    
    NSString * serTimeStr = [NSString stringWithFormat:@"服务时间: %@",self.model.serTime];
    
    CGRect serTimeRect = [serTimeStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat serTimeHeight = serTimeRect.size.height;
    
    [self.serTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.createTimeLab.mas_bottom).offset(10);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-20);
        make.height.offset(serTimeHeight);
    }];
    
    NSString * serInfoStr = [NSString stringWithFormat:@"服务介绍: %@",self.model.serIntro];
    CGRect serInfoRect = [serInfoStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat serInfoRectHeight = serInfoRect.size.height;
    //self.serInfoLab.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serTimeLab.mas_bottom).offset(10);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-20);
        make.height.offset(serInfoRectHeight);
    }];
    
    
    NSString * serGoodStr = [NSString stringWithFormat:@"服务优势: %@",self.model.serContent];
    CGRect serGoodRect = [serGoodStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat serGoodRectHeight = serGoodRect.size.height;
    [self.serGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.serInfoLab.mas_bottom).offset(10);
        make.left.equalTo(self.headIV.mas_left);
        make.width.offset(SCREEN_W-20);
        make.height.offset(serGoodRectHeight);
    }];
    
    [self.skillIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.getMoneyStatusLab.mas_bottom).offset(10);
        make.right.offset(-15);
        make.width.offset(30);
        make.height.offset(30);
    }];
    
//    if ([self.model.status isEqualToString:@"NORMAL"]){
//        
//        [self.getMoneyBtn setTitle:@"发布赚钱" forState:UIControlStateNormal];
//        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-140);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        
//    }else if ([self.model.status isEqualToString:@"STOP"]) {
//        
//        [self.getMoneyBtn setTitle:@"暂不赚钱" forState:UIControlStateNormal];
//        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-140);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//    }else if ([self.model.status isEqualToString:@"IMPERFECT"]) {
//        
//        [self.changeBtn setTitle:@"完善资料赚钱" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-120);
//            make.width.offset(120);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(110);
//            make.height.offset(30);
//        }];
//    }
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (CGFloat)initWithCellHeight:(SPLzsMySkillModel *)model{

    NSString * timeStr = [NSString stringWithFormat:@"服务时间: %@",model.serTime];
    CGRect serTimeRect = [timeStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat serTimeHeight = serTimeRect.size.height;
    //服务介绍
    NSString * infoStr = [NSString stringWithFormat:@"服务介绍: %@",model.serIntro];
    CGRect infoStrRect = [infoStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat infoStrHeight = infoStrRect.size.height;
    //服务介绍
    NSString * goodStr = [NSString stringWithFormat:@"服务介绍: %@",model.serIntro];
    CGRect goodStrRect = [goodStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
    CGFloat goodStrHeight = goodStrRect.size.height;
    NSLog(@"%f",180+serTimeHeight+infoStrHeight+goodStrHeight);
    return 180+serTimeHeight+infoStrHeight+goodStrHeight;
}

- (void)initWithModel:(SPLzsMySkillModel *)model{

//    self.model = model;
//
//    self.backView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_W-10, self.frame.size.height-10)];
//    NSLog(@"%f %f cell的height",self.backView.frame.size.height,self.frame.size.height);
//    self.backView.backgroundColor = WC;
//    self.backView.clipsToBounds = YES;
//    self.backView.layer.cornerRadius = 8;
//    
//    [self addSubview:self.backView];
//    
////    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
////        
////        make.top.offset(5);
////        make.left.offset(5);
////        make.width.offset(SCREEN_W-10);
////        make.height.offset(self.frame.size.height-10);
////    }];
//
//    //头像
//    self.headIV = [[UIImageView alloc]init];
//    [self.backView addSubview:self.headIV];
    
//    self.headIV.clipsToBounds = YES;
//    self.headIV.layer.cornerRadius = 4;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.skillImg]];
    
    if ([model.bailFee doubleValue] >0) {
        NSLog(@"%@",model.bailFee);
        self.honestMoneyIV.image = [UIImage imageNamed:@"bzjrz_y"];
    }else{
        self.honestMoneyIV.image = [UIImage imageNamed:@"bzjrz_w"];
    }
//    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.offset(5);
//        make.left.offset(5);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
    //模特
//    self.modelLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.modelLab];
//    self.modelLab.font = Font(13);
//    self.modelLab.textAlignment = NSTextAlignmentLeft;
//    self.modelLab.textColor = [UIColor blackColor];
    self.modelLab.text = [NSString stringWithFormat:@"%@   %ld级",model.skill,(long)model.skillLevel];
    self.modelLab.textColor = [UIColor redColor];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.modelLab.text];
    NSRange daryGray = NSMakeRange(0,[[noteStr string] rangeOfString:@" "].location);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:daryGray];
    [self.modelLab setAttributedText:noteStr];
//    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.headIV.mas_top);
//        make.left.equalTo(self.headIV.mas_right).offset(5);
//        make.width.offset(SCREEN_W-140);
//        make.height.offset(20);
//        
//    }];
    
    //服务价格
//    self.serPriceLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serPriceLab];
//    self.serPriceLab.font = Font(13);
//    self.serPriceLab.textAlignment = NSTextAlignmentLeft;
//    self.serPriceLab.textColor = [UIColor blackColor];
    self.serPriceLab.text = [NSString stringWithFormat:@"服务价格: %@",model.serPrice];
    
//    [self.serPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.modelLab.mas_bottom);
//        make.left.equalTo(self.headIV.mas_right).offset(5);
//        make.width.offset(SCREEN_W-140);
//        make.height.offset(20);
//    }];
    
    //赚钱状态
//    self.getMoneyStatusLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.getMoneyStatusLab];
//    self.getMoneyStatusLab.font = Font(13);
//    self.getMoneyStatusLab.textAlignment = NSTextAlignmentLeft;
//    self.getMoneyStatusLab.textColor = [UIColor redColor];
    
    if ([model.status isEqualToString:@"NORMAL"]) {
        self.getMoneyStatusLab.text = @"正在赚钱";
    }else if ([model.status isEqualToString:@"STOP"]) {
        self.getMoneyStatusLab.text = @"暂不赚钱";
    }else if ([model.status isEqualToString:@"IMPERFECT"]) {
        self.getMoneyStatusLab.text = @"待完善";
    }
    
    
//    [self.getMoneyStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.offset(20);
//        make.right.offset(-5);
//        make.width.offset(80);
//        make.height.offset(20);
//    }];
    
    //创建时间
//    self.createTimeLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.createTimeLab];
//    self.createTimeLab.font = Font(13);
//    self.createTimeLab.textAlignment = NSTextAlignmentLeft;
//    self.createTimeLab.textColor = [UIColor blackColor];
    self.createTimeLab.text = [NSString stringWithFormat:@"创建时间: %@",model.updatedAt];
    
//    [self.createTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.headIV.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-10);
//        make.height.offset(20);
//    }];
    
    //服务时间
//    self.serTimeLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serTimeLab];
//    self.serTimeLab.font = Font(13);
//    
//    self.serTimeLab.numberOfLines = 2;
//    self.serTimeLab.textAlignment = NSTextAlignmentLeft;
//    self.serTimeLab.textColor = [UIColor blackColor];
    self.serTimeLab.text = [NSString stringWithFormat:@"服务时间: %@",model.serTime];
//    CGRect serTimeRect = [self.serTimeLab.text boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serTimeHeight = serTimeRect.size.height;
//    self.serTimeLab.lineBreakMode = NSLineBreakByTruncatingTail;
//    [self.serTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.createTimeLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serTimeHeight);
//    }];
    
    //服务介绍
//    self.serInfoLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serInfoLab];
//    self.serInfoLab.font = Font(13);
//    self.serInfoLab.numberOfLines = 3;
//    
//    self.serInfoLab.textAlignment = NSTextAlignmentLeft;
//    self.serInfoLab.textColor = [UIColor blackColor];
    self.serInfoLab.text = [NSString stringWithFormat:@"服务介绍: %@",model.serIntro];
//    CGRect serInfoRect = [self.serInfoLab.text boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serInfoRectHeight = serInfoRect.size.height;
//    self.serInfoLab.lineBreakMode = NSLineBreakByTruncatingTail;
//    [self.serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.serTimeLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serInfoRectHeight);
//    }];
    
    //服务优势
//    self.serGoodLab = [[UILabel alloc]init];
//    [self.backView addSubview:self.serGoodLab];
//    self.serGoodLab.font = Font(13);
    self.serGoodLab.text = [NSString stringWithFormat:@"服务优势: %@",model.serContent];
//    CGRect serGoodRect = [self.serGoodLab.text boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serGoodRectHeight = serGoodRect.size.height;
//    [self.serGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.serInfoLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serGoodRectHeight);
//    }];
    
//    self.serGoodLab.numberOfLines = 3;
//    self.serGoodLab.textAlignment = NSTextAlignmentLeft;
//    self.serGoodLab.textColor = [UIColor blackColor];
//    self.serGoodLab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //技能认证
//    self.skillIV = [[UIImageView alloc]init];
//    self.skillIV.image = [UIImage imageNamed:@""];
//    [self.backView addSubview:self.skillIV];
    
//    [self.skillIV mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.getMoneyStatusLab.mas_bottom).offset(10);
//        make.right.offset(-15);
//        make.width.offset(30);
//        make.height.offset(30);
//    }];
    //赚钱按钮
//    self.getMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.getMoneyBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
//    [self.getMoneyBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.getMoneyBtn];
//    [self.getMoneyBtn addTarget:self action:@selector(getMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.getMoneyBtn.clipsToBounds = YES;
//    self.getMoneyBtn.layer.cornerRadius = 6;
//    //修改
//    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.changeBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
//    [self.changeBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.changeBtn];
//    [self.changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.changeBtn.clipsToBounds = YES;
//    self.changeBtn.layer.cornerRadius = 6;
    //删除
//    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.deleteBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
//    [self.deleteBtn setTitleColor:WC forState:UIControlStateNormal];
//    [self.backView addSubview:self.deleteBtn];
//    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.deleteBtn.clipsToBounds = YES;
//    self.deleteBtn.layer.cornerRadius = 6;
//    
    if ([model.status isEqualToString:@"NORMAL"]){
        
        [self.getMoneyBtn setTitle:@"暂不赚钱" forState:UIControlStateNormal];
        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.offset(SCREEN_W/2-140);
            make.width.offset(80);
            make.height.offset(30);
        }];
        
        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
            make.width.offset(80);
            make.height.offset(30);
        }];
        
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.equalTo(self.changeBtn.mas_right).offset(15);
            make.width.offset(80);
            make.height.offset(30);
        }];
        
        
    }else if ([model.status isEqualToString:@"STOP"]) {
        
        [self.getMoneyBtn setTitle:@"发布赚钱" forState:UIControlStateNormal];
        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.offset(SCREEN_W/2-140);
            make.size.mas_offset(CGSizeMake(80, 30));
            //make.height.offset(30);
        }];
        
        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
            make.width.offset(80);
            make.height.offset(30);
        }];
        
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.equalTo(self.changeBtn.mas_right).offset(15);
            make.width.offset(80);
            make.height.offset(30);
        }];
        
    }else if ([model.status isEqualToString:@"IMPERFECT"]) {
        
        [self.changeBtn setTitle:@"完善资料赚钱" forState:UIControlStateNormal];
        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.offset(SCREEN_W/2-120);
            make.width.offset(120);
            make.height.offset(30);
        }];
        
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
            make.left.equalTo(self.changeBtn.mas_right).offset(15);
            make.width.offset(110);
            make.height.offset(30);
        }];
    }
    
    
}

//- (void)layoutSubviews{

//    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.offset(5);
//        make.left.offset(5);
//        make.width.offset(SCREEN_W-10);
//        make.height.offset(self.frame.size.height-10);
//    }];
//    
//    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.offset(5);
//        make.left.offset(5);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
//    
//    [self.modelLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.headIV.mas_top);
//        make.left.equalTo(self.headIV.mas_right).offset(5);
//        make.width.offset(SCREEN_W-140);
//        make.height.offset(20);
//        
//    }];
//    
//    [self.serPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.modelLab.mas_bottom);
//        make.left.equalTo(self.headIV.mas_right).offset(5);
//        make.width.offset(SCREEN_W-140);
//        make.height.offset(20);
//    }];
//    
//    [self.getMoneyStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.offset(20);
//        make.right.offset(-5);
//        make.width.offset(80);
//        make.height.offset(20);
//    }];
//    
//    [self.createTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.headIV.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-10);
//        make.height.offset(20);
//    }];
//    
//    
//    NSString * serTimeStr = [NSString stringWithFormat:@"服务时间: %@",self.model.serTime];
//    
//    CGRect serTimeRect = [serTimeStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serTimeHeight = serTimeRect.size.height;
//    
//    [self.serTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.createTimeLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serTimeHeight);
//    }];
//    
//    NSString * serInfoStr = [NSString stringWithFormat:@"服务介绍: %@",self.model.serIntro];
//    CGRect serInfoRect = [serInfoStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serInfoRectHeight = serInfoRect.size.height;
//    //self.serInfoLab.lineBreakMode = NSLineBreakByTruncatingTail;
//    [self.serInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.serTimeLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serInfoRectHeight);
//    }];
//    
//    
//    NSString * serGoodStr = [NSString stringWithFormat:@"服务优势: %@",self.model.serContent];
//    CGRect serGoodRect = [serGoodStr boundingRectWithSize:CGSizeMake(SCREEN_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Font(13)} context:nil];
//    CGFloat serGoodRectHeight = serGoodRect.size.height;
//    [self.serGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.serInfoLab.mas_bottom).offset(10);
//        make.left.equalTo(self.headIV.mas_left);
//        make.width.offset(SCREEN_W-20);
//        make.height.offset(serGoodRectHeight);
//    }];
//    
//    [self.skillIV mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.getMoneyStatusLab.mas_bottom).offset(10);
//        make.right.offset(-15);
//        make.width.offset(30);
//        make.height.offset(30);
//    }];
//    
//    if ([_model.status isEqualToString:@"NORMAL"]){
//        
//        [self.getMoneyBtn setTitle:@"发布赚钱" forState:UIControlStateNormal];
//        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-140);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        
//    }else if ([_model.status isEqualToString:@"STOP"]) {
//        
//        [self.getMoneyBtn setTitle:@"暂不赚钱" forState:UIControlStateNormal];
//        [self.getMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-140);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.changeBtn setTitle:@"修改" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.getMoneyBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(80);
//            make.height.offset(30);
//        }];
//        
//    }else if ([_model.status isEqualToString:@"IMPERFECT"]) {
//        
//        [self.changeBtn setTitle:@"完善资料赚钱" forState:UIControlStateNormal];
//        [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.offset(SCREEN_W/2-120);
//            make.width.offset(120);
//            make.height.offset(30);
//        }];
//        
//        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.top.equalTo(self.serGoodLab.mas_bottom).offset(20);
//            make.left.equalTo(self.changeBtn.mas_right).offset(15);
//            make.width.offset(110);
//            make.height.offset(30);
//        }];
//    }

//}

#pragma mark - getMoneyBtnClick
- (void)getMoneyBtnClick:(UIButton *)btn{
    
    if ([btn.titleLabel.text isEqualToString:@"发布赚钱"]) {
        
        NSDictionary * dict = @{@"id":self.model.ID,@"lucCode":self.model.lucCode,@"code":self.model.code,@"status":@"NORMAL"};
        NSLog(@"%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:ChangeStatusOfSkillAndMoney parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            NSLog(@"%@",responseObject);
            [btn setTitle:@"暂不赚钱" forState:UIControlStateNormal];
            self.getMoneyStatusLab.text = @"正在赚钱";
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
    }else{
        
        NSDictionary * dict = @{@"id":self.model.ID,@"lucCode":self.model.lucCode,@"code":self.model.code,@"status":@"STOP"};
        [[HttpRequest sharedClient]httpRequestPOST:ChangeStatusOfSkillAndMoney parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            NSLog(@"%@",responseObject);
            [btn setTitle:@"发布赚钱" forState:UIControlStateNormal];
            self.getMoneyStatusLab.text = @"暂不赚钱";
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
    }
}

#pragma mark - changeBtnClick
- (void)changeBtnClick:(UIButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(changeBtnClickForVC:)]) {
        
        [_delegate changeBtnClickForVC:self.model];
    }
//    if ([btn.titleLabel.text isEqualToString:@"修改"]) {
//        
//    }else if ([btn.titleLabel.text isEqualToString:@"完善资料赚钱"]){
//    
//        if ([_delegate respondsToSelector:@selector(finishTextWithChangeClick:)]) {
//            
//            [_delegate finishTextWithChangeClick:self.model];
//        }
//    }
    
}


#pragma mark - deleteBtnClick
- (void)deleteBtnClick:(UIButton *)btn{

    if ([_delegate respondsToSelector:@selector(deleteBtnClickForVC:)]) {
        
        [_delegate deleteBtnClickForVC:self.model];
    }
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
