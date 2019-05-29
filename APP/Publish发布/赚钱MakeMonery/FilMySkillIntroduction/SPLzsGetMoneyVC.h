//
//  SPLzsGetMoneyVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

@interface SPLzsGetMoneyVC : BaseViewController
@property (nonatomic,strong) UILabel * skillCategoryLab;//技能类别
@property (nonatomic,strong) UILabel * servePriceLab;//服务价格
@property (nonatomic,strong) UILabel * serveTimeLab;//服务时间
@property (nonatomic,strong) UILabel * serveInfoLab;//服务介绍
@property (nonatomic,strong) UITextView *serveInfoTV ;//服务介绍输入框
@property (nonatomic,strong) UILabel * serveGoodLab;//服务优势
@property (nonatomic,strong) UITextView *serveGoodTV ;//服务优势输入框
@property (nonatomic,strong) UILabel * serveRemarkLab;//备注

@property (nonatomic,strong) UITextView *serveRemarkTV ;//服务备注输入框

//requare
@property(nonatomic,copy)NSString *skillCode;

@property(nonatomic,copy)NSString *skill;
/** 从哪里进来
    0 发布界面  1 租约广场（点击了去完善）；
    根据进入的不同，判断发布完成后该跳转到哪里
    默认为0*/
@property(nonatomic,assign)NSInteger  formWhere;

@end
