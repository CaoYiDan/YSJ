//
//  SPSecton0Cell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSection2MoreTextCell.h"

@implementation SPSection2MoreTextCell
{
    UILabel *_textLab;
    UILabel *_subLab;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setUI];
    }
    return self;
}

-(void)setUI{
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100,30)];
    _textLab.font = kFontNormal_14;
    [self.contentView addSubview:_textLab];
    
    _subLab = [[UILabel alloc]init];
    _subLab.font = font(14);
    _subLab.numberOfLines = 0;
    _subLab.textAlignment= NSTextAlignmentLeft;
    _subLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:_subLab];
    [_subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.top.offset(30);
        make.bottom.offset(0);
    }];
}

-(void)setText:(NSString *)text subText:(NSString *)subText{
    _textLab.text = text;
    _subLab.text = subText;
}

@end


