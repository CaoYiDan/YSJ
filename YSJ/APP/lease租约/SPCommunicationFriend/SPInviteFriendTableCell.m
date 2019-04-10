//
//  SPInviteFriendTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPInviteFriendTableCell.h"

@implementation SPInviteFriendTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    
    //头像
    self.headIV = [[UIImageView alloc]init];
    
    self.headIV.layer.cornerRadius = 25;
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
        make.left.offset(15);
        make.width.offset(50);
        make.height.offset(50);
    }];
    //self.headIV.badgeBgColor = RGBCOLOR(250, 28, 81);
    //self.headIV.badgeCenterOffset = CGPointMake(10,10);
    
    //
    self.titleLab = [[UILabel alloc]init];
    
    self.titleLab.textColor = RGBA(51, 51, 51, 1);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview: self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(13);
        make.left.equalTo(self.headIV.mas_right).offset(10);
        make.width.offset(SCREEN_W-160);
        make.height.offset(20);
    }];
    
    //
    self.subtilteLab = [[UILabel alloc]init];
    
    self.subtilteLab.textColor = RGBA(131, 131, 131, 1);
    self.subtilteLab.textAlignment = NSTextAlignmentLeft;
    self.subtilteLab.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview: self.subtilteLab];
    
    [self.subtilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLab.mas_bottom).offset(3);
        make.left.equalTo(self.headIV.mas_right).offset(10);
        make.width.offset(SCREEN_W-160);
        make.height.offset(20);
    }];

    self.btnIV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.btnIV];
    self.btnIV.image = [UIImage imageNamed:@"gtlb_an_lt"];
    [self.btnIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.right.offset(-15);
        make.width.offset(50);
        make.height.offset(25);
        
    }];
    
    
}

#pragma mark - communicateBtnClick聊天按钮
- (void)communicateBtnClick:(UIButton * )btn{

    
}

#pragma mark -  赋值Model
- (void)initWithModel:(SPIviteModel *)model{

    //NSInteger value ;//= [self.topRightGoodStr integerValue];
    //[self.headIV showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeNone];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    self.titleLab.text = model.nickName;
    self.subtilteLab.text = model.distance;
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
