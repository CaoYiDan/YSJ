//
//  SPMyButtton.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyButtton.h"

@implementation SPMyButtton
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight-20);

    self.titleLabel.frame = CGRectMake(0, self.frameHeight-20, self.frameWidth, 20);
    self.titleLabel.font = kFontNormal;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
