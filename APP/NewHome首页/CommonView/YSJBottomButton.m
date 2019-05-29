//
//  YSJBottomButton.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJBottomButton.h"

@implementation YSJBottomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
         [self setUI];
    }
    return self;
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
    
    self.backgroundColor = KMainColor;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
  
}
@end
