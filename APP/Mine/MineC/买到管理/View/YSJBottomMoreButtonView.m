//
//  YSJBottomMoreButtonView.m
//  SmallPig
//
//  Created by xujf on 2019/5/9.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJHomeWorkCommentVC.h"
#import "YSJHomeWorkCommentVC.h"
#import "YSJEvaluateVC.h"
#import "YSJPublishHomeWorkVC.h"
#import "YSJCheckCommentVC.h"
#import "YSJOrderDeatilVC.h"
#import "YSJBottomMoreButtonView.h"
#import "YSJOrderModel.h"
#import "YSJDrawBackVC.h"
#import "YSJDrawBackDeatilVC.h"
#import "YSJRequimentModel.h"
#import "YSJCourseModel.h"
#import "YSJGetMoneyVC.h"

@implementation YSJBottomMoreButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = grayF2F2F2;
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.right.offset(0);
            make.height.offset(1);
            make.top.offset(0);
        }];
        
        {
            UIView *bottomLine = [[UIView alloc]init];
            bottomLine.backgroundColor = grayF2F2F2;
            [self addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.right.offset(0);
                make.height.offset(6);
                make.bottom.offset(0);
            }];
        }
        
    }
    return self;
}

- (void)setBtnTextArr:(NSArray *)btnTextArr{
    
    _btnTextArr = btnTextArr;
    
    int i =0;
    
    UIView *rightView = self;
    
    for (NSString *str in btnTextArr) {
        
        UIButton *btn = [FactoryUI createButtonWithtitle:str titleColor:[UIColor hexColor:@"666666"] imageName:nil backgroundImageName:nil target:self selector:@selector(btnClick:)];
        if([str isEqualToString:@"查看"]){
            btn.userInteractionEnabled = NO;
        }
        btn.layer.cornerRadius = 11;
        btn.clipsToBounds = YES;
        btn.layer.borderColor = [UIColor hexColor:@"E6E6E6"].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.tag = i;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                 make.right.offset(-kMargin);
            }else{
            make.right.equalTo(rightView.mas_left).offset(-10);
            }
           
            make.width.offset(67);
            make.height.offset(22);
            make.centerY.offset(0);
        }];
        
        rightView = btn;
        
        i++;
    }
}

- (void)setMoreColorBtnArr:(NSArray<NSDictionary *> *)moreColorBtnArr{
    
    _moreColorBtnArr = moreColorBtnArr;
    
    int i =0;
    
    UIView *rightView = self;
    //字体颜色
    NSArray *textColorArr = @[[UIColor hexColor:@"666666"],[UIColor hexColor:@"E8541E"]];
    //边框颜色
    NSArray *borderColorArr = @[[UIColor hexColor:@"E6E6E6"],[UIColor hexColor:@"FFD1BE"]];
    
    for (NSDictionary *dic in moreColorBtnArr) {
        
        
        UIButton *btn = nil;
        
        NSString *title = dic[@"title"];
        NSInteger type = [dic[@"type"] integerValue];
        
        btn = [FactoryUI createButtonWithtitle:title titleColor:textColorArr[type] imageName:nil backgroundImageName:nil target:self selector:@selector(btnClick:)];
        UIColor *borderColor = borderColorArr[type];
        btn.layer.borderColor = borderColor.CGColor;
        if([title isEqualToString:@"查看"]||[title isEqualToString:@"去买课"]){
            btn.userInteractionEnabled = NO;
        }
        btn.layer.cornerRadius = 11;
        btn.clipsToBounds = YES;
        
        btn.layer.borderWidth = 1.0;
        btn.tag = i;
        [self addSubview:btn];
        
        CGFloat width= [title sizeWithFont:font(12) maxW:200].width+30;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.right.offset(-kMargin);
            }else{
            make.right.equalTo(rightView.mas_left).offset(-10);
            }
            make.width.offset(width);
            make.height.offset(22);
            make.centerY.offset(0);
        }];
        
        rightView = btn;
        
        i++;
    }
}

#pragma mark - 按钮点击事件处理

-(void)btnClick:(UIButton *)btn{
    
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"评价"]) {
        
        YSJEvaluateVC *vc = [[YSJEvaluateVC alloc]init];
        vc.order_Id = self.model.order_id;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        
    }else if ([title isEqualToString:@"查看"]){
        
        if ([self.model.order_status containsString:@"退款"]) {
            //查看退款详情
            YSJDrawBackDeatilVC *vc = [[YSJDrawBackDeatilVC alloc]init];
            vc.model = self.model;
            [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        }else{
            //查看订单详情
           YSJOrderDeatilVC *vc = [[YSJOrderDeatilVC alloc]init];
          vc.model = self.model;
          [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
    }else if ([title isEqualToString:@"申请退款"]){
        YSJDrawBackVC *vc = [[YSJDrawBackVC alloc]init];
        vc.model = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"删除"] ||[title isEqualToString:@"确认授课完成"]||[title isEqualToString:@"取消订单"] ||[title isEqualToString:@"去支付"]||[title isEqualToString:@"确认退款"]||[title isEqualToString:@"拒绝退款"]){
        [self popAlterViewWithTitle:title];
    }else if ([title isEqualToString:@"查看打款进度"]){
        YSJGetMoneyVC *vc = [[ YSJGetMoneyVC alloc]init];
        vc.model = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:nil];
    }else if ([title isEqualToString:@"查看评价"]){
        YSJCheckCommentVC *vc = [[YSJCheckCommentVC alloc]init];
        vc.model = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:nil];
    }else if ([title isEqualToString:@"确认退款"]){
        
    }else if ([title isEqualToString:@"布置作业"] || [title isEqualToString:@"重新布置作业"]){
        
        YSJPublishHomeWorkVC *vc= [[ YSJPublishHomeWorkVC alloc]init];
        vc.orderModel = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"点评作业"]){
        YSJHomeWorkCommentVC *vc= [[YSJHomeWorkCommentVC alloc]init];
        vc.homeWorkDetailType = HomeWorkDetailWaitComment;
        vc.orderModel = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"查看作业"]){
        
        YSJHomeWorkCommentVC *vc= [[YSJHomeWorkCommentVC alloc]init];
        if (!isEmptyString(self.model.student_describe)) {
            vc.homeWorkDetailType = HomeWorkDetailCheckCommit;
        }else{
            vc.homeWorkDetailType = HomeWorkDetailCheckMyPublish;
        }
        vc.orderModel = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"查看点评"]){
        
        YSJHomeWorkCommentVC *vc= [[YSJHomeWorkCommentVC alloc]init];
        vc.homeWorkDetailType = HomeWorkDetailCheckComment;
        vc.orderModel = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"提交作业"] || [title isEqualToString:@"重新提交"]){
        
        YSJHomeWorkCommentVC *vc= [[YSJHomeWorkCommentVC alloc]init];
        vc.homeWorkDetailType = HomeWorkDetailWaitCommit;
        vc.orderModel = self.model;
        [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
    }
   
    return;
    
    [self.delegate bottomMoreButtonViewClickWithIndex:btn.tag andTitle:btn.titleLabel.text];
}

#pragma mark - 是否退款

-(void)beSureDracwBackWithStatus:(BOOL)beSure{
    
    //网络请求
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:self.model.order_id forKey:@"order_id"];
    [dic setObject:beSure?@"退款成功":@"退款失败" forKey:@"type"];
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YBeSureDrawBack parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        Toast(@"操作完成");
        NSLog(@"%@",responseObject);
        //发送通知刷新界面
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}


#pragma mark - 删除

-(void)cancel{
    
    if (self.orderType == OrderTypeBuy || self.orderType == OrderTypeSale) {
        
        //网络请求
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:self.model.orderId forKey:@"id"];
        [[HttpRequest sharedClient]httpRequestPOST:YCancelOrder parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            Toast(@"操作完成");
            NSLog(@"%@",responseObject);
            //发送通知刷新界面
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else if (self.orderType== OrderTypePublish){
        //网络请求
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        
        //发布分两类，一类是课程发布，一类是 需求发布，所传的model 不同
        if (!isEmptyString(self.courseModel.code)) {
           
            [dic setObject:self.courseModel.code forKey:@"id"];
            
        }else{
            [dic setObject:self.requementModel.code forKey:@"id"];
            
        }
        
        [[HttpRequest sharedClient]httpRequestPOST:YCancelPublish parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            Toast(@"操作完成");
            NSLog(@"%@",responseObject);
            //发送通知刷新界面
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

#pragma mark - 确认授课完成

-(void)courseComlete{
    
    if (self.orderType == OrderTypeBuy || self.orderType == OrderTypeSale) {
        
        //网络请求
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:self.model.order_id forKey:@"order_id"];
        
        [dic setObject:(self.orderType == OrderTypeBuy)? @"买家":@"卖家" forKey:@"role"];
        NSLog(@"%@",dic);
        
        [[HttpRequest sharedClient]httpRequestPOST:YOrderComplete parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            Toast(@"操作完成");
            NSLog(@"%@",responseObject);
            //发送通知刷新界面
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

#pragma mark - 去支付

-(void)pay{
    
    if (self.orderType == OrderTypeBuy) {
        
        //网络请求
        NSMutableDictionary *dic = @{}.mutableCopy;
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:self.model.orderId forKey:@"id"];
        [[HttpRequest sharedClient]httpRequestPOST:YPayOrder parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            Toast(@"操作完成");
            NSLog(@"%@",responseObject);
            //发送通知刷新界面
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}
#pragma mark - 弹出确定框
- (void)popAlterViewWithTitle:(NSString *)title
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@？",title]
                                
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self readyTodoSomething:title];
                                                          }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    [alert addAction:cancelAction];
    [alert addAction:defaultAction];
    
    [[SPCommon getCurrentVC] presentViewController:alert animated:YES completion:nil];
}

-(void)readyTodoSomething:(NSString *)title{
    
    if ([title isEqualToString:@"删除"] || [title isEqualToString:@"取消订单"]) {
        
        [self cancel];
        
    }else if ([title isEqualToString:@"确认授课完成"]){
        [self courseComlete];
    }else if ([title isEqualToString:@"去支付"]){
        [self pay];
    }else if ([title isEqualToString:@"确认退款"]){
        [self beSureDracwBackWithStatus:YES];
    }else if ([title isEqualToString:@"拒绝退款"]){
        [self beSureDracwBackWithStatus:NO];
    }
}

@end
