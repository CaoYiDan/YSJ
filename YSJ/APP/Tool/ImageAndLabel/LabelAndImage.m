//
//  LabelAndImage.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "LabelAndImage.h"

@implementation LabelAndImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.unitImageView=[[UIImageView alloc]init];
        self.unitImageView .contentMode=UIViewContentModeScaleAspectFit;
        //[self.unitImageView setImage:[UIImage imageNamed:@"icon"] ];
        
        [self addSubview:self.unitImageView];
        
        self.unitTextLabel=[[UILabel alloc]init];
        self.unitTextLabel.font=Font(14);
        
        
        self.unitTextLabel.adjustsFontSizeToFitWidth=YES;
        
        [self addSubview:self.unitTextLabel];
    }
    return self;
}

-(void)setImageType:(NSInteger)imageType{
    _imageType=imageType;
    
    if (imageType > 0) {//右边的图片
        
        [self.unitTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 22));
            
        }];
        [self.unitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.size.mas_offset(CGSizeMake(20, 20));
            make.top.offset(4);
        }];
        //[self.unitImageView setImage:[UIImage imageNamed:_rightImageArr[type]]];
        self.unitTextLabel.textAlignment=NSTextAlignmentRight;
    }else if(imageType < 0){
        
        [self.unitTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 25, 0, 0));
        }];
        [self.unitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.size.mas_offset(CGSizeMake(20, 20));
            make.top.offset(0);
        }];
        self.unitTextLabel.textAlignment=NSTextAlignmentLeft;
        //[self.unitImageView setImage:[UIImage imageNamed:_leftImageArr[type-10]]];
    }
}

-(void)setLabelText:(NSString*)text WithColor:(UIColor *)color{
    
    self.unitTextLabel.text=text;
    self.unitTextLabel.textColor = color;
    
}
-(void)setImageView:(NSString*)imageName{
    
    self.unitImageView.image = [UIImage imageNamed:imageName];
}

@end
