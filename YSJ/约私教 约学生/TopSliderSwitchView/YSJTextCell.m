//
//  YSJTextCell.m
//  SmallPig
//
//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJTextCell.h"

@implementation YSJTextCell
{
    UIView *_line;
    UILabel *_text;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *text = [FactoryUI createLabelWithFrame:CGRectMake(0, 0,self.frameWidth, self.frameHeight-7) text:nil textColor:KWhiteColor font:Font(16)];
        _text = text;
        [self addSubview:text];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(self.frameWidth/2-15, 37, 30, 3)];
        _line.layer.cornerRadius = 1.5;
        _line.clipsToBounds = YES;
        _line.backgroundColor = KWhiteColor;
        [self addSubview:_line];
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setTextStr:(NSString *)textStr{
    _textStr = textStr;
    _text.text = textStr;
}

- (void)setIfSelected:(BOOL)ifSelected{
    _ifSelected = ifSelected;
    _line.hidden = !ifSelected;
    _text.font = ifSelected?Font(17):Font(16);
}
@end
