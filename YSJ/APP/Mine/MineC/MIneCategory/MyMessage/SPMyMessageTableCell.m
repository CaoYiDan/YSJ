//
//  SPMyMessageTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyMessageTableCell.h"

@implementation SPMyMessageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initWithModel:(SPMyMessageModel *)model withType:(NSInteger)number{

    //头像
    self.headIV = [[UIImageView alloc]init];
    
    self.headIV.layer.cornerRadius = 25;
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.left.offset(10);
        make.width.offset(50);
        make.height.offset(50);
    }];
    
    //
    self.titleLab = [[UILabel alloc]init];
    
    self.titleLab.textColor = RGBA(51, 51, 51, 1);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview: self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(10);
        make.left.equalTo(self.headIV.mas_right).offset(26);
        make.width.offset(SCREEN_W-150);
        make.height.offset(25);
    }];
    //
    self.subtilteLab = [[UILabel alloc]init];
    
    self.subtilteLab.textColor = RGBA(153, 153, 153, 1);
    self.subtilteLab.textAlignment = NSTextAlignmentLeft;
    self.subtilteLab.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview: self.subtilteLab];
    
    [self.subtilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(0);
        make.left.equalTo(self.headIV.mas_right).offset(26);
        make.width.offset(SCREEN_W-160);
        make.height.equalTo(self.titleLab.mas_height);
    }];
    
    //
    self.timeTilteLab = [[UILabel alloc]init];
    
    self.timeTilteLab.textColor = RGBA(153, 153, 153, 1);
    self.timeTilteLab.textAlignment = NSTextAlignmentRight;
    self.timeTilteLab.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview: self.timeTilteLab];
    
    [self.timeTilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_top);
        make.right.offset(-10);
        make.width.offset(180);
        make.height.equalTo(self.titleLab.mas_height);
    }];
    
    self.otherHeadIV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.otherHeadIV];
    
    [self.otherHeadIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_top);
        make.right.offset(-10);
        make.width.equalTo(self.headIV.mas_width);
        make.height.equalTo(self.headIV.mas_height);
    }];
    
    //
    self.markIV = [[UIImageView alloc]init];
    
    //self.headIV.layer.cornerRadius = 10;
    //self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.markIV];
    
    [self.markIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headIV.mas_top);
        make.left.equalTo(self.headIV.mas_right).offset(-15);
        make.width.offset(20);
        make.height.offset(20);
        
    }];
    
    //NSLog(@"%@%@",model.avatar,model.nickName);
    //xttz_sz 大图 tx_red 小红点
    
    if (number==1) {//1为系统通知
        
        self.titleLab.text = @"系统通知";//model.sender;
        self.subtilteLab.text = model.content;
        if (!model.readed) {
            self.markIV.image = [UIImage imageNamed:@"tx_red"];
        }
        self.timeTilteLab.text = model.sendTime;
        
        self.headIV.image = [UIImage imageNamed:@"xttz_sz"];
        
    NSLog(@"%@%@%@%@%@",model.sender,model.code,model.type,model.content,model.sendTime);
    }else if (number==2){//2为互动通知
    
        self.titleLab.text = model.content;
        //self.subtilteLab.text = model.content;
        self.subtilteLab.text = model.sendTime;
        if (!model.readed) {
            self.markIV.image = [UIImage imageNamed:@"tx_red"];
        }
        //self.timeTilteLab.text = model.sendTime;
        [self.otherHeadIV sd_setImageWithURL:[NSURL URLWithString:model.image]];
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"imagePlaceHold"]];
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

@end
