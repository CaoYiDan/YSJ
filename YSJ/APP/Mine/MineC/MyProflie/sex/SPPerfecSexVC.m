//
//  SPPerfecSexVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPerfecSexVC.h"

#import "SPPerfectBirthDayVC.h"
@interface SPPerfecSexVC ()
@end

@implementation SPPerfecSexVC
{
    UIView *_baseView;
    UIButton *_man;
    UIButton *_girl;
    
    NSInteger _result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    [self.nextBtn  setTitleColor:[UIColor blackColor] forState:0];
    [self.jumpBtn  setTitleColor:[UIColor whiteColor] forState:0];
    
    [self createUI];
    
    if (self.formMyCenter) {
        //将保存按钮变白色
        [self.saveBtn setTitleColor:[UIColor whiteColor] forState:0];
    }
}

//UI布局
-(void)createUI{
    
    CGFloat wid =SCREEN_W-100;
    CGFloat height = wid/8*5;
    
    //base
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wid, height)];
    _baseView = baseView;
    baseView.center = self.view.center;
    baseView.layer.cornerRadius =20.0f;
    [self.view addSubview:baseView];
    
    //男选择器
    UIButton *man = [[UIButton alloc]initWithFrame:CGRectMake(0,0, wid/2, height)];
    man.tag =1;
    _man = man;
    [man addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchDown];
    [man setImage:[UIImage imageNamed:@"b1_hover"] forState:UIControlStateNormal];
    [man setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateSelected];
    [baseView addSubview:man];
    
    //女选择器
    UIButton *girl = [[UIButton alloc]initWithFrame:CGRectMake(wid/2,0, wid/2, height)];
    _girl = girl;
    girl.tag =2;
    [girl addTarget:self action:@selector(selecte:) forControlEvents:UIControlEventTouchDown];
    [girl setImage:[UIImage imageNamed:@"a1_hover"] forState:UIControlStateNormal];
    [girl setImage:[UIImage imageNamed:@"a1"] forState:UIControlStateSelected];
    [baseView addSubview:girl];
    
    //获取之前存储的用户信息
    if (self.formMyCenter) {
        if (!self.isGirl) {
            man.selected =YES;//选中
        }else{
            girl.selected =YES;//选中
        }
        
    }else{
        
    NSDictionary *userDict = [StorageUtil getUserDict];
    if ([userDict[@"gender"] integerValue] ==1) {
         man.selected =YES;//选中
    }else{
        girl.selected =YES;//选中
    }
        
    }
    //Or
    UIImageView *orImg = [[UIImageView alloc]initWithFrame:CGRectMake(wid/2-20, height/2-12.5, 40, 25)];
    [orImg setImage:[UIImage imageNamed:@"or"]];
    [baseView addSubview:orImg];
}

//选择点击
-(void)selecte:(UIButton *)btn{

    if (btn.isSelected) {
        return;
    }
    
    btn.selected = !btn.isSelected;
    
    //始终使两者的选中状态相反
    if (btn.tag == 1) {
        _girl.selected = !btn.isSelected;
    }
    
    if (btn.tag == 2) {
        _man.selected = !btn.isSelected;
    }
}

-(void)next{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if (_man.isSelected) {
        [dict setObject:@(1) forKey:@"gender"];
    }else{
        [dict setObject:@(0) forKey:@"gender"];
    }
    [self postMessage:dict pushToVC:NSStringFromClass([SPPerfectBirthDayVC class])];
}

-(void)jump{
    [self pushViewCotnroller:NSStringFromClass([SPPerfectBirthDayVC class])];
}

- (void)back{
    
    //[self.navigationController popViewControllerAnimated:YES];
    if (self.formMyCenter) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
         [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
