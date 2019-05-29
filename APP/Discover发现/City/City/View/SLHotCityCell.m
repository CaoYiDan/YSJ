//
//  SDHotCityCell.m
//  sudaizhijia
//
//  Created by 武传亮 on 2017/4/27.
//  Copyright © 2017年 武传亮. All rights reserved.
//

#import "SLHotCityCell.h"
#import "SLCityModel.h"

#define kMargin 13
#define kButtonWidth 91
#define kGap (kScreenWidth - kButtonWidth * 3 - kMargin - 25) / 2
#define kButtonHeight 32
#define kGapH 9
#define kTopMargin 34

@interface SLHotCityCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;


@end

@implementation SLHotCityCell

{
    NSArray *_hotArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];

    
}

- (void)setCityModel:(SLCityModel *)cityModel {
    if (_cityModel != cityModel) {
        _cityModel = cityModel;
        [self setupView];
    }
}

#define kButtonColor [UIColor blueColor]

- (void)setupView {
    
    NSInteger count = 0;
    CGFloat y = 0.0;
    NSInteger x = 1;
    
    _hotArr = self.cityModel.hotCity;

    for (int i = 0; i < self.cityModel.hotCity.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [button setTitle:_hotArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        button.tag = i;
        
//        if ([city.arename isEqualToString:self.cityModel.selectedCity]) {
//            [button setTitleColor:kButtonColor forState:UIControlStateNormal];
//            button.layer.borderColor = kButtonColor.CGColor;
//        }
        
        if (self.cityModel.hotCity.count > count ) {

            if (((kScreenWidth) - (kMargin + kButtonWidth * (x - 1) + kGap * (x - 1))) <= kButtonWidth) {
                y += kGapH + kButtonHeight;
                x = 1;
            }
            
            button.frame = CGRectMake(kMargin + ((kButtonWidth + kGap) * (x - 1)), kTopMargin + y, kButtonWidth, kButtonHeight);
            count ++;
            x ++;
        }
        
        [button addTarget:self action:@selector(citySelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.backView addSubview:button];
        
        self.cityModel.hotCellH = y + kButtonHeight + kTopMargin + 11;
    }
}

- (void)citySelected:(UIButton *)button {
    NSString *city= _hotArr[button.tag];
    
    if (self.selectedCityBlock) {
        self.selectedCityBlock(city, 1);
    }
    
}




@end
