//
//  SPMineWalletDetailCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/12/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMineWalletDetailCell.h"

@implementation SPMineWalletDetailCell

- (void)initWithModel:(SPLzsMineWalletDetailModel *)model{
    
    //
    self.titleLab = [[UILabel alloc]init];
    //self.titleLab.text = @"发布技能,保证金支付 假数据";
    self.titleLab.text = model.title;
    self.titleLab.textColor = RGBA(51, 51, 51, 1);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview: self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
        make.left.offset(15);
        make.width.offset(SCREEN_W-50);
        make.height.offset(20);
    }];
    //
    //NSString * feeStr = [model.tradeFee stringv]
    self.moneyLab = [[UILabel alloc]init];
    self.moneyLab.text = [NSString stringWithFormat:@"%@ %@ 元",model.blOperate,model.tradeFee];
    self.moneyLab.textColor = RGBA(53, 53, 53, 1);
    self.moneyLab.textAlignment = NSTextAlignmentRight;
    self.moneyLab.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview: self.moneyLab];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(30);
        make.right.offset(-15);
        make.width.offset(160);
        make.height.equalTo(self.titleLab.mas_height);
    }];
    
    //
    self.timeTilteLab = [[UILabel alloc]init];
    
    self.timeTilteLab.textColor = [UIColor lightGrayColor];
    self.timeTilteLab.textAlignment = NSTextAlignmentLeft;
    self.timeTilteLab.font = [UIFont boldSystemFontOfSize:12];
    self.timeTilteLab.text = model.createTime;//@"2016-10-10 10:10:10";
    [self.contentView addSubview: self.timeTilteLab];
    
    [self.timeTilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(10);
        make.left.offset(15);
        make.width.offset(SCREEN_W- 180);
        make.height.offset(10);
    }];

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
