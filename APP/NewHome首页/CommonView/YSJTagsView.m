//
//  YSJTagsView.m
//  SmallPig
//
//  Created by xujf on 2019/4/9.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJTagLabel.h"
#import "YSJTagsView.h"
#import "NSString+getSize.h"

@implementation YSJTagsView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTagsArr:(NSArray *)tagsArr{
    
    _tagsArr = tagsArr;
    
    NSLog(@"%@",tagsArr);
    
    if (tagsArr.count==0) return;
    
    self.backgroundColor = [UIColor whiteColor];
    
    int i = 0 ;
    
    YSJTagLabel *leftLabel = nil;
    
    
    for (NSString *labelStr in tagsArr) {
        
        if (i>2 || isEmptyString(tagsArr[0])) {
            return;
        }
        
        YSJTagLabel *label = [[YSJTagLabel alloc]init];
       
        label.tagText = labelStr;
        
        [self addSubview:label];
        
        CGFloat width= [labelStr sizeWithFont:font(11) maxW:120].width+20;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.left.offset(0);
            }else{
            make.left.equalTo(leftLabel.mas_right).offset(15);
            }
            make.width.offset(width);
            make.height.offset(20);
            make.bottom.offset(-5);
        }];
        
        leftLabel = label;
        
        i++;
    }
}

@end
