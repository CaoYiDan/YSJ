//
//  SPRechargeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPRechargeCell.h"
#import "UILabel+Extension.h"
#import "SPRechargeModel.h"
@implementation SPRechargeCell
{
    UILabel *_textLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.frameWidth-20, self.frameHeight-20)];
    
    textLabel.backgroundColor = [UIColor whiteColor];
    textLabel.numberOfLines = 2;
    textLabel.layer.borderColor = [UIColor grayColor].CGColor;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.layer.borderWidth = 1.0f;
    textLabel.layer.cornerRadius = 5;
    textLabel.clipsToBounds = YES;
    textLabel.font = BoldFont(16);
    _textLabel = textLabel;
    [self.contentView addSubview:textLabel];

}

-(void)setRechargeModel:(SPRechargeModel *)rechargeModel{
    _rechargeModel = rechargeModel;
    if ([rechargeModel.presentFee isEqualToString:@"0"])
    {
        _textLabel.text = [NSString stringWithFormat:@"%@元",rechargeModel.rechargeFee];
    }else
    {
    _textLabel.attributedText = [self procesString: [NSString stringWithFormat:@"%@元",rechargeModel.rechargeFee] withcolour:[UIColor blackColor] withfont:16 with: [NSString stringWithFormat:@"\n赠送%@元(%@)",rechargeModel.presentFee,rechargeModel.percent] withcolour:[UIColor blackColor] withfont:12];
    }
}

- (NSAttributedString *)procesString:(NSString *)str1 withcolour:(UIColor*)firstColour withfont:(NSInteger)font1 with:(NSString *)str2 withcolour:(UIColor*)secondColour withfont:(NSInteger)font2
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", str1, str2]];
    [str addAttribute:NSForegroundColorAttributeName value:firstColour range:NSMakeRange(0,str1.length)];
    [str addAttribute:NSForegroundColorAttributeName value: secondColour range:NSMakeRange(str1.length + 1, str2.length)];
    
    [str addAttribute:NSFontAttributeName value:BoldFont(font1) range:NSMakeRange(0, str1.length)];
    [str addAttribute:NSFontAttributeName value:Font(font2) range:NSMakeRange(str1.length+1, str2.length)];
    
    return str;
}

-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    _textLabel.text = @"其他金额";
}

-(void)setSelected:(BOOL)selected{
    if (self.indexRow!=0) {
        return;
    }
    if (selected)
    {
        _textLabel.backgroundColor = PrinkColor;
        _textLabel.textColor = [UIColor whiteColor];
       
    }else
    {
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.textColor = [UIColor blackColor];

    }
}
@end
