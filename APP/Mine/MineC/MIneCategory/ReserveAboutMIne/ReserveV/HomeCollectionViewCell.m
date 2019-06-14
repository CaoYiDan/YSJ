//
//  HomeCollectionViewCell.m
//  TimeMemory
//
//  Created by 李智帅 on 16/9/12.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];

    //头像
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, self.contentView.frame.size.width-6, self.contentView.frame.size.width-6)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];

    //小图标
    self.smallIV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    
    [self.imageView addSubview:self.smallIV];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.imageView.frame.size.height-35, self.imageView.frame.size.width-20,25)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor  = RGBA(0, 0, 0, 0.3);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.imageView addSubview: self.titleLabel];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 5, self.imageView.frame.size.width-20,20)];
   
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    self.timeLab.textColor = [UIColor whiteColor];
    self.timeLab.font = Font(14);
    [self.imageView addSubview:self.timeLab];
    
    
}

- (void)refreshUI:(HomeModel *)model withCode:(NSInteger)code{

    self.titleLabel.text = model.nickName;
    
    //我的预约没有小图片
//    if (!code) {
//        
//    }else{
//    
//        
//        if (model.readed) {
//            
//            self.smallIV.image =[UIImage imageNamed:@"yy_r3_c1"];
//            
//        } else{
//            
//            self.smallIV.image =[UIImage imageNamed:@"yy_r3_c5"];
//        }
//    }
//    if (model.followEachOther) {
//        
//        self.smallIV.image =[UIImage imageNamed:@"yy_r3_c1"];
//        
//    }else{
//    
//        self.smallIV.image =[UIImage imageNamed:@"yy_r3_c5"];
//    }
    
    //self.timeLab.text = model.startTime;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"120"]];
    
}
@end
