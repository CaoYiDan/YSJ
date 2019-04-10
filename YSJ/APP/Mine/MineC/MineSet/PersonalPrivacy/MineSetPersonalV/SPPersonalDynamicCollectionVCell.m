//
//  SPPersonalDynamicCollectionVCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/9/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPersonalDynamicCollectionVCell.h"

@implementation SPPersonalDynamicCollectionVCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    //头像
    self.headIV = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, self.contentView.frame.size.width-20, self.contentView.frame.size.height-25)];
    
    self.headIV.layer.cornerRadius = 10;
    self.headIV.clipsToBounds = YES;
    [self.contentView addSubview:self.headIV];
    
    self.nickLab = [[UILabel alloc]initWithFrame:CGRectMake(3, self.headIV.frame.size.height+3, self.headIV.frame.size.width,20)];
    
    self.nickLab.textColor = [UIColor blackColor];
    self.nickLab.textAlignment = NSTextAlignmentCenter;
    
    self.nickLab.font = [UIFont boldSystemFontOfSize:13];
    [self.contentView addSubview: self.nickLab];

    
}

- (void)initWithModel:(HomeModel *)model AndCount:(NSInteger)number{

    
    if (number ==0) {
        
        [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"imagePlaceHold"]];
        self.nickLab.text = model.nickName;
    }else if (number==1) {
        self.headIV.image = [UIImage imageNamed:@"yssz_+"];
        self.nickLab.text = nil;
    }else if(number==2){
    
        self.headIV.image = [UIImage imageNamed:@"yssz_-"];
        self.nickLab.text = nil;
    }
}
@end
