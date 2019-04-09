//
//  LittleItemCell.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 16/12/13.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "SPProfileSkillCell.h"

@interface SPProfileSkillCell ()
/**<##>图片*/
@property(nonatomic,strong)UIImageView*itemImageView;
/**<##>标题Name*/
@property(nonatomic,strong)UILabel*itemName;
/**选中的下划线*/
@property(nonatomic,strong)UIView*selectedLine;
@end
@implementation SPProfileSkillCell
{
    NSArray*_itemNameArr;
}

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
    CGFloat iconW = 40;
    self.itemImageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.frameWidth-iconW)/2, 10, iconW, iconW)];
    //    self.itemImageView.layer.cornerRadius = 8;
    //    self.itemImageView.clipsToBounds = YES;
    self.itemImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.itemImageView];
    
    //标题
    self.itemName= [[UILabel alloc]initWithFrame:CGRectMake(0, iconW+10, self.frameWidth, 20)];
    self.itemName.font = font(14);
    self.itemName.text= @"旅游";
    self.itemName.adjustsFontSizeToFitWidth=YES;
    self.itemName.backgroundColor = [UIColor clearColor];
    self.itemName.textColor = [UIColor grayColor];
    self.itemName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemName];
    
    //下划线
    self.selectedLine = [[UIView alloc]initWithFrame:CGRectMake(5,70, self.frameWidth-10, 2)];
    self.selectedLine.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.selectedLine];
    self.selectedLine.hidden= YES;
}

-(void)click{
    NSLog(@"可以点击");
}

-(void)setDict:(NSDictionary *)dict{
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"imgUrl"]]];
    self.itemName .text = dict[@"name"];
}

-(void)setImgUrl:(NSString *)imgUrl withName:(NSString *)name code:(NSString *)code{
    
    self.itemName.text = name;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.selectedLine.hidden = !selected;
}

@end

