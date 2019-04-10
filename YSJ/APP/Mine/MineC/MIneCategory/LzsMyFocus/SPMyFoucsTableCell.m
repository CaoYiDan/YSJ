//
//  SPMyFoucsTableCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyFoucsTableCell.h"

@implementation SPMyFoucsTableCell


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
    
    self.headIV.layer.cornerRadius = 20;
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
        make.left.offset(15);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
    //
    self.titleLab = [[UILabel alloc]init];
    
    self.titleLab.textColor = RGBA(51, 51, 51, 1);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview: self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(20);
        make.left.equalTo(self.headIV.mas_right).offset(10);
        make.width.offset(SCREEN_W-180);
        make.height.offset(25);
    }];
    
    self.focusStatusIV = [[UIImageView alloc]init];
    
    //self.focusStatusIV.layer.cornerRadius = 20;
    //self.focusStatusIV.clipsToBounds = YES;
    [self.contentView addSubview:self.focusStatusIV];
    
    [self.focusStatusIV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
        make.right.offset(-15);
        make.width.offset(40);
        make.height.offset(40);
    }];
    
}

- (void)refreshUI:(HomeModel *)model withCode:(NSInteger)code{

    self.titleLab.text = model.nickName;
    
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    
    if (!code) {
        
        if (model.followEachOther) {
            self.focusStatusIV.image = [UIImage imageNamed:@"wd_ech_"];//相互关注
        }else{
            
            self.focusStatusIV.image = [UIImage imageNamed:@"wd_ewfou_"];//我关注的
            
        }
    }else{
    
        if (model.followEachOther) {
            self.focusStatusIV.image = [UIImage imageNamed:@"wd_ech_"];//相互关注
        }else{
            
            self.focusStatusIV.image = [UIImage imageNamed:@"wd_eation_1"];//关注我的
            
        }
    }
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
