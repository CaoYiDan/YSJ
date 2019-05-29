//
//  SPLzsSecondLoginVC.h
//  SmallPig
//
//  Created by 李智帅 on 2017/11/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

@interface SPLzsSecondLoginVC : BaseViewController
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property(nonatomic,strong) UIView * adverView;
@property(nonatomic,strong) UIButton * nextBtn;
@property(nonatomic,strong) UIView * loginView;
- (void)createLoginView;
@end
