//
//  LittleItemCell.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 16/12/13.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "YSJActivityCell.h"

@interface YSJActivityCell ()
/**<##>图片*/
@property(nonatomic,strong)UIImageView*itemImageView;
/**<##>标题Name*/
@property(nonatomic,strong)UILabel*itemName;
/**副<##>标题Name*/
@property(nonatomic,strong)UILabel*subItemName;

@end
@implementation YSJActivityCell

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    //图片
    CGFloat iconW = 60;
    self.itemImageView=[[UIImageView alloc]init]                    ;
    self.itemImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.itemImageView];
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(iconW);
        make.height.offset(iconW);
        make.centerY.offset(0);
    }];
    
    //标题
    self.itemName= [[UILabel alloc]initWithFrame:CGRectMake(iconW+10,15, self.frameWidth-iconW, 25)];
    self.itemName.font = font(14);
    self.itemName.text= @"";
    self.itemName.adjustsFontSizeToFitWidth=YES;
    self.itemName.backgroundColor = [UIColor blackColor];
    self.itemName.textColor = [UIColor grayColor];
    self.itemName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemName];
    
    //副标题
    self.subItemName= [[UILabel alloc]initWithFrame:CGRectMake(iconW+10,15+35 , self.frameWidth, 20)];
    self.subItemName.font = font(13);
    self.subItemName.text= @"";
    self.subItemName.adjustsFontSizeToFitWidth=YES;
    self.subItemName.backgroundColor = [UIColor clearColor];
    self.subItemName.textColor = [UIColor grayColor];
    self.subItemName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemName];
    
}

-(void)click{
    NSLog(@"可以点击");
}

-(void)setDic:(NSDictionary *)dic{
    self.itemImageView = [UIImage imageNamed:dic[@"img"]];
    self.itemName.text = dic[@"name"];
    self.subItemName.text = dic[@"subTitle"];
}
@end
