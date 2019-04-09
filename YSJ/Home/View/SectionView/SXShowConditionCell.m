//
//  SXShowConditionCell.m
//  TopSelectBar
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 付耀辉. All rights reserved.
//

#import "SXShowConditionCell.h"

@interface SXShowConditionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selectedImage;

@property (weak, nonatomic) IBOutlet UILabel *chooseName;

@end

@implementation SXShowConditionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setName:(NSString *)name andIsSelected:(BOOL)flag{
    
    _chooseName.text = name;

    _selectedImage.hidden = flag;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
