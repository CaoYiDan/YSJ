//
//  SPLzsGetAddressTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsGetAddressTableCell.h"
//第三方角标
#import "UIView+Frame.h"
#import "WZLBadgeImport.h"

@implementation SPLzsGetAddressTableCell

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
    [self.btnIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.right.offset(-15);
        make.width.offset(50);
        make.height.offset(25);
        
    }];
    
    //self.communicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //[self.communicateBtn setTitleColor:WC forState:UIControlStateNormal];
    //[self.contentView addSubview:self.communicateBtn];
    
    //[self.communicateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    
        //make.top.offset(20);
        //make.right.offset(-15);
        //make.width.offset(50);
        //make.height.offset(25);
        
    //}];
    
    //[self.communicateBtn setBackgroundColor:RGBCOLOR(250, 28, 81)];
    //self.userInteractionEnabled = NO;
    //[self.communicateBtn addTarget:self action:@selector(communicateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //self.communicateBtn.clipsToBounds = YES;
    //self.communicateBtn.layer.cornerRadius = 4;
    
    
}



#pragma mark -  赋值Model
- (void)initWithModel:(SPLzsGetAddressModel *)model withSection:(NSInteger )section{
    
    //NSInteger value ;//= [self.topRightGoodStr integerValue];
    //[self.headIV showBadgeWithStyle:WBadgeStyleNumber value:value animationType:WBadgeAnimTypeNone];
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:@""]];
    
    self.titleLab.text = @"";
    self.subtilteLab.text = @"";
    
}
- (void)initWithDict:(NSMutableDictionary *)dict withSection:(NSInteger )section{

    if (section==0) {
        
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar"]]];
        self.btnIV.image = [UIImage imageNamed:@"gtlb_an_lt"];
        self.titleLab.text = dict[@"nickName"];
        self.subtilteLab.text = [NSString stringWithFormat:@"%@   %@",dict[@"contactName"],dict[@"distance"]];
        //[self.communicateBtn setTitle:@"聊天" forState:UIControlStateNormal];
        
        
    }else if (section==1){
    
        self.headIV.image = [UIImage imageNamed:@"boy_image"];
        self.btnIV.image = [UIImage imageNamed:@"gtlb_an_yq"];
        self.titleLab.text = dict[@"contactName"];
        self.subtilteLab.text = dict[@"mobile"];
        //[self.communicateBtn setTitle:@"邀请" forState:UIControlStateNormal];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
