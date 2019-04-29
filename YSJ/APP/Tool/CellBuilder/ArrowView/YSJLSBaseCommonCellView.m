//
//  YSJLSBaseCommonCellView.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopProtocol.h"

#import "YSJLSBaseCommonCellView.h"
#import "YSJPopSheetView.h"
#import "YSJPopTextViewView.h"
#import "YSJPopTextFiledView.h"

@implementation YSJLSBaseCommonCellView

{
    UILabel *_leftText;
    UILabel *_rightText;
    
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self initUIwithTitle:title subTitle:subTitle];
    }
    return self;
}

-(void)initUIwithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
    _leftText = [[UILabel alloc]init];
    _leftText.font = font(16);
    _leftText.text = title;
    _leftText.textColor = KBlack333333;
    [self addSubview:_leftText];
    [_leftText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.height.offset(normaelCellH);
        make.top.equalTo(self).offset(0);
    }];
    
    _rightText = [[UILabel alloc]init];
    _rightText.textAlignment = NSTextAlignmentRight;
    _rightText.text = subTitle;
    _rightText.textColor = gray999999;
    _rightText.font = font(14);
    [self addSubview:_rightText];
    [_rightText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin-20);
        make.left.equalTo(_leftText.mas_right).offset(10);
        make.height.offset(normaelCellH);
        make.top.offset(0);
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]init];
    arrowImg.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kWindowW-kMargin-8);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.equalTo(_rightText).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    WeakSelf;
    [self addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.superview endEditing:YES];
        [weakSelf zhuanhuanqiWithTitle:title subTitle:weakSelf.rightSubTitle];
    }];
    
}

-(void)zhuanhuanqiWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    [self popViewWithTitle:title subTitle:self.rightSubTitle];
}

//交由子类去实现
-(void)popViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle{
    
}

- (void)setRightSubTitle:(NSString *)rightSubTitle{
    _rightSubTitle = rightSubTitle;
    _rightText.text = rightSubTitle;
}

- (NSString *)getContent{
    return self.rightSubTitle;
}

- (UIView *)getView{
    return  self;
}
@end
