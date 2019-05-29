//
//  UILabel+Extension.m
//  XCFApp
//
//  Created by callmejoejoe on 16/4/5.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+ (UILabel *)labelWithFont:(UIFont *)font
                 textColor:(UIColor *)textColor
             numberOfLines:(NSInteger)lines
             textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.numberOfLines = lines;
    label.textAlignment = textAlignment;
    return label;
}

-(void)setAttributeTextWithString:(NSString *)string range:(NSRange)range WithColour:(UIColor *)colour{
    
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:colour range:range];
    self.attributedText = attrsString;
}

- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range WithColour:(UIColor*)colour andFont:(NSInteger)font{
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:colour range:range];
    [attrsString addAttribute:NSFontAttributeName value:Font(font) range:range];
    self.attributedText = attrsString;
}

- (void)setAttributeTextWithString:(NSString *)string range:(NSRange)range WithColour:(UIColor *)colour Double:(BOOL)ifDouble Withrange:(NSRange)range2 WithColour:(UIColor *)colour2{
    NSMutableAttributedString *attrsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrsString addAttribute:NSForegroundColorAttributeName value:colour range:range];
    if (ifDouble==YES) {
        
        [attrsString addAttribute:NSForegroundColorAttributeName value:colour2 range:range2];
    }
    self.attributedText = attrsString;
}

- (NSAttributedString *)procesString:(NSString *)str1 withcolour:(UIColor*)firstColour withfont:(NSInteger)font1 with:(NSString *)str2 withcolour:(UIColor*)secondColour withfont:(NSInteger)font2
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", str1, str2]];
    [str addAttribute:NSForegroundColorAttributeName value:firstColour range:NSMakeRange(0,str1.length)];
    [str addAttribute:NSForegroundColorAttributeName value: secondColour range:NSMakeRange(str1.length + 1, str2.length)];
    
    [str addAttribute:NSFontAttributeName value:Font(font1) range:NSMakeRange(0, str1.length)];
    [str addAttribute:NSFontAttributeName value:Font(font2) range:NSMakeRange(str1.length+1, str2.length)];
    
    return str;
}

-(void)addMiddleLine{
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
    
    // 赋值
    self.attributedText = attribtStr;

}
@end
