//
//  SPLzsLoginView.h
//  SmallPig
//
//  Created by 李智帅 on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)changeToHome;

@end

@interface SPLzsLoginView : UIView
@property (nonatomic,strong)UITextField * phoneTF;
@property (nonatomic,strong)UITextField * phoneCodeTF;
@property (nonatomic,strong)UIButton * getMaBtn;
@property(nonatomic,strong) UIView * adverView;
@property(nonatomic,strong) UIButton * nextBtn;
@property(nonatomic,strong) UIView * loginView;
@property(nonatomic,weak) id<LoginViewDelegate>delegate;
- (void)createLoginView;
@end
