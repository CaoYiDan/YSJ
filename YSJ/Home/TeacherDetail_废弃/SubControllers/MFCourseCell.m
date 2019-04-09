//
//  MFLiveCell.m
//  MoFang
//
//  Created by xujf on 2018/9/13.
//  Copyright © 2018年 ZBZX. All rights reserved.
//

#import "MFCourseCell.h"

@interface MFCourseCell ()

@property(strong,nonatomic)UILabel * name;
@property(strong,nonatomic)UILabel *content;

@end

@implementation MFCourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setUI{
    
    
}

@end
