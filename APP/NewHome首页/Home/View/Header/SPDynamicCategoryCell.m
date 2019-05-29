//
//  LittleItemCell.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 16/12/13.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "SPDynamicCategoryCell.h"

@interface SPDynamicCategoryCell ()
/**<##>图片*/
@property(nonatomic,strong)UIImageView*itemImageView;
/**<##>标题Name*/
@property(nonatomic,strong)UILabel*itemName;
/**右上角已发布<##>图标*/
@property(nonatomic,strong)UIImageView*havePublishedImg;
@end
@implementation SPDynamicCategoryCell
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
    CGFloat iconW = 42*(SCREEN_W/375);
    self.itemImageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.frameWidth-iconW)/2, 10, iconW, iconW)];
    self.itemImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.itemImageView];

    //标题
    self.itemName= [[UILabel alloc]initWithFrame:CGRectMake(0, iconW+10, self.frameWidth, 20)];
    self.itemName.font = font(13);
    self.itemName.text= @"";
    self.itemName.adjustsFontSizeToFitWidth=YES;
    self.itemName.backgroundColor = [UIColor clearColor];
    self.itemName.textColor = [UIColor grayColor];
    self.itemName.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.itemName];

    self.havePublishedImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frameWidth-42, 0,42,15)];
    [self.havePublishedImg setImage:[UIImage imageNamed:@"fb_zq_"]];
    self.havePublishedImg.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.havePublishedImg];
    self.havePublishedImg.hidden = YES;
}

-(void)click{
    NSLog(@"可以点击");
}

-(void)setImg:(NSString *)img withName:(NSString *)name{
    self.itemName.text = name;
    self.itemImageView.image = [UIImage imageNamed:img];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
}

@end
