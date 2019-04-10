//
//  MFLiveCell.m
//  MoFang
//
//  Created by xujf on 2018/9/13.
//  Copyright © 2018年 ZBZX. All rights reserved.
//

#import "MFTeacherCell.h"

@interface MFTeacherCell ()

@property(strong,nonatomic)UIImageView * icon_Img;
@property(strong,nonatomic)UILabel * teacher;
@property(strong,nonatomic)UILabel *content;
@property(strong,nonatomic)UILabel * detailContent;@property (nonatomic,strong) UIButton *leftTime;
@property (nonatomic,strong) UIImageView *rightImg;

@end

@implementation MFTeacherCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
         self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUI{
    
    self.icon_Img = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.icon_Img.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.icon_Img];
    self.icon_Img.backgroundColor = KWhiteColor;
    self.icon_Img.layer.cornerRadius = 19.5;
    self.icon_Img.clipsToBounds = YES;
    
    self.icon_Img.layer.borderWidth = 1.0;
    self.icon_Img.image = [UIImage imageNamed:@""];
    [self.icon_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(39);
        make.height.offset(39);
        make.top.offset(11);
    }];
    
    self.teacher = [[UILabel alloc] initWithFrame:CGRectZero];
    self.teacher.font = Font(14);
    self.teacher.textAlignment = NSTextAlignmentLeft;
    self.teacher.text = @"";
    [self.contentView addSubview:self.teacher];
    [self.teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon_Img.mas_right).offset(10);
//        make.right.offset(-10);
        make.height.offset(11);
        make.top.offset(11);
    }];
    
    _content = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:[UIColor blackColor] font:Font(13)];
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teacher);
        
        make.height.offset(30);
        make.top.equalTo(self.teacher.mas_bottom).offset(5);
    }];
    
    _detailContent = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:gray999999 font:Font(12)];
    [self.contentView addSubview:_detailContent];
    _detailContent.numberOfLines = 3;
    [_detailContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teacher);
        
//        make.height.offset(30);
        make.width.offset(kWindowW-70); make.top.equalTo(_content.mas_bottom).offset(5);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];

    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
}

@end
