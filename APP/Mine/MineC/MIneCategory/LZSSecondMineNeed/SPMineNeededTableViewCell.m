//
//  SPMineNeededTableViewCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMineNeededTableViewCell.h"

@implementation SPMineNeededTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = WC;
        [self initUI];
    }
    return self;
}

#pragma mark - initUI
- (void)initUI{

    //技能需求
    self.needSkillLab = [[UILabel alloc]init];
    [self addSubview:self.needSkillLab];
    self.needSkillLab.textColor = [UIColor blackColor];
    self.needSkillLab.textAlignment = NSTextAlignmentLeft;
    self.needSkillLab.font = Font(14);
    
    [self.needSkillLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(20);
        make.left.offset(15);
        make.width.offset(SCREEN_W/2);
        make.height.offset(20);
    }];
    
    //诚意金
    self.honestMoneyLab = [[UILabel alloc]init];
    [self addSubview:self.honestMoneyLab];
    self.honestMoneyLab.textColor = [UIColor blackColor];
    self.honestMoneyLab.textAlignment = NSTextAlignmentRight;
    self.honestMoneyLab.font = Font(14);
    
    [self.honestMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.right.offset(-15);
        make.width.offset(SCREEN_W/2);
        make.height.offset(20);
    }];
    
    //发布时间
    self.needTimeLab = [[UILabel alloc]init];
    [self addSubview:self.needTimeLab];
    self.needTimeLab.textColor = [UIColor blackColor];
    self.needTimeLab.textAlignment = NSTextAlignmentLeft;
    self.needTimeLab.font = Font(14);
    
    [self.needTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.needSkillLab.mas_bottom).offset(10);
        make.left.equalTo(self.needSkillLab.mas_left);
        make.width.offset(SCREEN_W-80);
        make.height.equalTo(self.needSkillLab.mas_height);
    }];
    
    //需求描述
    self.needInfoLab = [[UILabel alloc]init];
    [self addSubview:self.needInfoLab];
    self.needInfoLab.textColor = [UIColor blackColor];
    self.needInfoLab.textAlignment = NSTextAlignmentLeft;
    self.needInfoLab.font = Font(14);
    
    [self.needInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.needTimeLab.mas_bottom).offset(10);
        make.left.equalTo(self.needTimeLab.mas_left);
        make.width.offset(SCREEN_W-80);
        make.height.equalTo(self.needTimeLab.mas_height);
    }];
    
    UIView * lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.needInfoLab.mas_bottom).offset(10);
        make.left.equalTo(self.needInfoLab.mas_left);
        make.width.offset(SCREEN_W-30);
        make.height.offset(0.5);
    }];
    lineView.backgroundColor = RGBCOLOR(231, 231, 231);
    
    //闪约
    self.flashDateIV = [[UIImageView alloc]init];
    [self addSubview:self.flashDateIV];
    
     [self.flashDateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.top.equalTo(self.honestMoneyLab.mas_bottom).offset(1);
         make.right.offset(-20);
         make.width.offset(40);
         make.height.offset(40);
         
         
     }];
    
    
    //成交
    self.needFinishLab = [[UILabel alloc]init];
    [self addSubview:self.needFinishLab];
    self.needFinishLab.textColor = RGBCOLOR(136, 136, 136);
    self.needFinishLab.textAlignment = NSTextAlignmentLeft;
    self.needFinishLab.font = Font(14);
    
    [self.needFinishLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.flashDateIV.mas_bottom).offset(5);
        make.left.equalTo(self.flashDateIV.mas_left);
        make.width.offset(60);
        make.height.equalTo(self.needTimeLab.mas_height);
    }];
    
    
    
}

- (void)initWithModel:(SPMineNeededModel *)model{

    self.needSkillLab.text = [NSString stringWithFormat:@"需求技能: %@",model.skill];
    
    if ([model.bailFee doubleValue]>0 ) {
        self.honestMoneyLab.text = [NSString stringWithFormat:@"已交诚意金: %@元",model.bailFee];
    }else{
        //self.honestMoneyLab.text = [NSString stringWithFormat:@"已交诚意金: %@元",model.bailFee];
    }
    
    self.needTimeLab.text = [NSString stringWithFormat:@"发布时间: %@",model.createDateStr];
    self.needInfoLab.text = [NSString stringWithFormat:@"需求描述: %@",model.content];
    if ([model.flushFlag integerValue]==0) {
        self.flashDateIV.image = [UIImage imageNamed:@"wd_xq_sy"];
    }
    if ([model.dealFlag isEqualToString:@"YDEAL"]) {
    //成交
        self.needFinishLab.text = @"";//@"成交";
        
    }else if ([model.dealFlag isEqualToString:@"NODEAL"]){
    
        //未成交
        self.needFinishLab.text = @"";//@"未成交";
        
    }
    
    for (int i =0; i<model.userList.count; i++)
    {
        
        UIImageView * userIV = [[UIImageView alloc]init];
        [self addSubview:userIV];
        userIV.clipsToBounds = YES;
        userIV.layer.cornerRadius = 15;
        [userIV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.needInfoLab.mas_bottom).offset(15);
            make.left.offset(15+30*i+10*i);
            make.width.offset(30);
            make.height.offset(30);
            
        }];
        [userIV sd_setImageWithURL:[NSURL URLWithString:model.userList[i][@"headImg"]]];
    }
}

#define SINGLE_LINE_HEIGHT  (1/[UIScreen mainScreen].scale)  // 线的高度
#define  COLOR_LINE_GRAY [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1]  //分割线颜色 #e0e0e0

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, COLOR_LINE_GRAY.CGColor); //  COLOR_LINE_GRAY 为线的颜色
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, SINGLE_LINE_HEIGHT)); //SINGLE_LINE_HEIGHT 为线的高度
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
