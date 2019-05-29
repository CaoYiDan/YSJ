//
//  YSJTagLabel.m
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJTagLabel.h"

@implementation YSJTagLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor hexColor:@"E8541E"];
    self.font = Font(11);
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
    
    self.backgroundColor = RGBA(253, 135, 197, 0.08);
}

-(void)setTagText:(NSString *)tagText{
    _tagText = tagText;
    self.text = [NSString stringWithFormat:@"%@",tagText];
}
@end
