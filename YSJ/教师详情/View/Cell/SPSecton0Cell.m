//
//  SPSecton0Cell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/17.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSecton0Cell.h"

@implementation SPSecton0Cell
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
    _textLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, self.frameHeight)];
    _textLab.font = kFontNormal_14;
    [self.contentView addSubview:_textLab];

    _subLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin+100, 0, SCREEN_W-100-kMargin, self.frameHeight)];
    _subLab.font = kFontNormal_14;
    _subLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:_subLab];
}

-(void)setText:(NSString *)text subText:(NSString *)subText{
    _textLab.text = text;
    _subLab.text = subText;
}

@end
