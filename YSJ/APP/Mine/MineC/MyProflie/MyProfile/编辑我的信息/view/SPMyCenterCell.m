//
//  SPMyCenterCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyCenterCell.h"

@implementation SPMyCenterCell
{
    UILabel *_content;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _content = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 150, 42)];
        _content.font = kFontNormal;
        _content.backgroundColor = [UIColor whiteColor];
        _content.textColor = [UIColor lightGrayColor];
        [self addSubview:_content];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, self.frameHeight-1, SCREEN_W-20, 1)];
        line.backgroundColor = GRAYCOLOR;
        [self.contentView addSubview:line];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    return  self;
}

-(void)setMyText:(NSString *)text{
    _content.text = text;
}

-(void)changeContentFrameAndTextALight{
    _content .frame = CGRectMake(SCREEN_W-150, 0, 130, 42);
    _content.textAlignment = NSTextAlignmentRight;
}
@end
