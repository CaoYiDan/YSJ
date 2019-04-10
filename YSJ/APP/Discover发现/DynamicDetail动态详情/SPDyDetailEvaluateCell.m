//
//  SPDyDetailEvaluateCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDyDetailEvaluateCell.h"
#import "SPUserNavTitleView.h"
#import "SPCommentModel.h"

@implementation SPDyDetailEvaluateCell
{
    SPUserNavTitleView *_userView;
    UIButton *_messageBtn;
    UILabel *_content;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    //评价人 基本信息view
    _userView = [[SPUserNavTitleView alloc]initWithFrame:CGRectMake(10, 10, 150, 44)];
    [self.contentView addSubview:_userView];
    
    //右边的信息图片
    _messageBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-50, 10, 20, 20)];
    [_messageBtn setImage:[UIImage imageNamed:@"d_message"] forState:0];
    _messageBtn.backgroundColor = [UIColor whiteColor];
    _messageBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_messageBtn];
    
    //内容
    _content = [[UILabel alloc]init];
    _content.numberOfLines = 0;
    _content.font = kFontNormal_14;
    _content.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_content];
    
    //分割线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = BASEGRAYCOLOR;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W-20, 1));
        make.left.offset(10);
        make.bottom.offset(0);
    }];
}

//字典赋值
-(void)setDic:(NSDictionary *)dict andHeight:(CGFloat)h{

    NSLog(@"%@",dict);
    
    //评价人信息
    [_userView setDict:dict];
    
    //评价内容
    _content.frame = CGRectMake(65, 55, SCREEN_W-75, h-70);
    if ([dict[@"type"] isEqualToString:@"COMMENT"]) {//回复评论人
        _content.text = [NSString stringWithFormat:@" 回复:%@ %@",dict[@"beCommentedUserName"],dict[@"content"]];
    }else{//直接回复动态
         _content.text = dict[@"content"];
    }
    
}

@end
