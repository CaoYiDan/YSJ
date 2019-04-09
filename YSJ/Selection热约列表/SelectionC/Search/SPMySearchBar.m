//
//  SPMySearchBar.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMySearchBar.h"

@implementation SPMySearchBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"s_search"];
        
        leftView.frameWidth = leftView.image.size.width + 10;
        leftView.frameHeight = leftView.image.size.height;
        leftView.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.placeholder = @"";
        
    }
    return self;
}

+(instancetype) searchBar
{
    return [[self alloc] init];
}

@end
