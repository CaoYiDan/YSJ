//
//  Notification.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>
//登录状态改变
extern NSString*const NotificationLoginStatusChange;
//选择城市通知
extern NSString*const NotificationChoseCity;
//发布完成之后
extern NSString*const NotificationPublishFinish;
//无网络状态下 点击刷新
extern NSString*const NotificationReloadForNoWifi;

//快速报价 选择的城市
extern NSString*const NotificationChoseOfferCity;

//附近筛选 选择的城市
extern NSString*const NotificationChoseNearSiftingCity;

//在租约广场 应邀的时候，如果去完善信息，完善之后，要发通知给租约广场界面
extern NSString*const NotificationPublishSkillFinshedForLeaseVC;

//附近条件筛选
extern NSString*const NotificationSiftingForNear;

//总分类页 ，选择左边发送通知
extern NSString*const NotificationCategorySelected;

//发布成功 跳转到首页
extern NSString*const NotificationJumpToHome;
