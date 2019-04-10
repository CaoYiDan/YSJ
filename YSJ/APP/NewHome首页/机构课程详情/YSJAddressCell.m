//
//  YSJAddressCell.m
//  SmallPig
//
//  Created by xujf on 2019/4/1.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJAddressCell.h"

@implementation YSJAddressCell
{
    UILabel *title;
    UILabel *address;
    UIButton *distance;
}
- (void)initUI{
    
    title = [FactoryUI createLabelWithFrame:CGRectMake(20, 10, 150, 20) text:@"" textColor:[UIColor blackColor] font:font(15)];
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
    
    address = [FactoryUI createLabelWithFrame:CGRectMake(20, 10+25, kWindowW-100, 30) text:@"" textColor:gray999999 font:font(13)];
    address.numberOfLines = 0;
    address.textAlignment = NSTextAlignmentLeft;
    [self addSubview:address];
    
    distance = [FactoryUI createButtonWithtitle:@"" titleColor:gray999999 imageName:@"dizhi-2" backgroundImageName:nil target:nil selector:nil];
    [self addSubview:distance];
    [distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        
        make.height.offset(30);
        make.top.equalTo(address.mas_bottom).offset(8);
    }];
    
    UIButton *message = [FactoryUI createButtonWithtitle:@"" titleColor:gray999999 imageName:@"xiaoxia" backgroundImageName:nil target:self selector:@selector(sendMessage)];
   
    [self addSubview:message];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(40);
        make.height.offset(40);
        make.centerY.offset(0);
    }];
}

-(void)setTitle:(NSString *)titleStr address:(NSString *)addressStr distance:(NSString *)distanceStr{
    
    if (isEmptyString(distanceStr)) return;
    
    title.text = titleStr;
    
    address.text = addressStr;
    
    [distance setTitle:[NSString stringWithFormat:@" %@km",distanceStr] forState:0];
}

-(void)sendMessage{
    
}
@end
