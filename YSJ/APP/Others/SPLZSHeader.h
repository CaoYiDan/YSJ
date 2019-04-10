//
//  SPLZSHeader.h
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

//获取定位信息
//#import "SPGetLocationInformation.h"
#import "RegisterViewController.h"//注册登录
//获取预约时间
#define MineReserveTime kUrlBase@"/v1/reservation/getReserveTime"
//上传设置的预约时间
#define UPLoadMineReserveTime kUrlBase@"/v1/reservation/saveReserveTime"
//用户活跃度
#define UserActivity kUrlBase@"/v1/user/updateLiveness"
//精选分类列表
#define SeletionCategoryURL kUrlBase@"/v1/selection/listBySkill"
//关注
#define FollowUrl kUrlBase@"/v1/follow/add"
//取消关注
#define CancelFollowUrl kUrlBase@"/v1/follow/delete"
//我的关注
#define MineFollowUrl kUrlBase@"/v1/follow/listFolloweds"
//关注我的
#define FollowMineUrl kUrlBase@"/v1/follow/listFollowers"
//获取隐私列表
#define GetPersonalListUrl kUrlBase@"/v1/user/getPrivacy"
//隐私列表选择
#define AllPersonalSeletedUrl kUrlBase@"/v1/user/setPrivacy"
//动态访问设置列表
#define PrivacyListUrl kUrlBase@"/v1/privacy/list"
//不让他看我的动态添加
#define listNotReadMeAddUrl kUrlBase@"/v1/privacy/listNotReadMe"
//我不看他的动态添加
#define listNotReadOtherAddUrl kUrlBase@"//v1/privacy/listNotReadOne"

//添加访问
#define PrivacyAddUrl kUrlBase@"/v1/privacy/add"
//删去访问
#define PrivacyDeleteUrl kUrlBase@"/v1/privacy/delete"
//系统通知列表
#define SystemNotiUrl kUrlBase@"/v1/notification/listNotifications"
//设置已读
#define ReadedNotiUrl kUrlBase@"/v1/notification/read"
//系统通知全部已读
#define AllSystemReadURL kUrlBase@"/v1/notification/readall"
//通讯录匹配
#define UrlOfContract kUrlBase@"/v1/user/contacts"
//推荐 根据喜好
#define UrlOfLike kUrlBase@"/v1/user/commendByHobby"
//互动列表
#define OthersMessageURL kUrlBase@"/v1/message/listMessages"
//互动已读
#define ReadedOthersMessageURL kUrlBase@"/v1/message/read"
//互动全部已读
#define AllOthersMessageReadURL kUrlBase@"/v1/message/readall"
//验证短信接口
#define CheckVerifyCodeUrl kUrlBase@"/v1/sms/checkVerifyCode"
//修改手机号
#define ChangeMobileUrl kUrlBase@"/v1/user/changeMobile"
//我的技能列表
#define MineSkillsUrl kUrlBase@"/v1/lucrative/byUserCode"
//修改技能和修改赚钱的状态
#define ChangeStatusOfSkillAndMoney kUrlBase@"/v1/lucrative/update"
//清空消息 动态：FEED，消息：MESSAGE,关注：FOLLOWED
#define ClearNewMessage kUrlBase@"/v1/user/emptyNum"
//获取设置内容
#define GetContentUrl kUrlBase@"/v1/content/get"
//我的需求列表
#define MyNeedListUrl kUrlBase@"/v1/demand/listMyDepoly"
//我的需求详细
#define MyNeedDetailUrl kUrlBase@"/v1/demand/listUserByDeploy"
//隐藏标签栏
#define HideTabbar self.tabBarController.tabBar.hidden=YES
//不隐藏标签栏
#define NotHideTabbar self.tabBarController.tabBar.hidden=NO
//我的钱包
#define URLOfMineWallet kUrlBase@"/v1/user/wallet"
//我的钱包明细
#define URLOfMineWalletDetail kUrlBase@"/v1/pay/detail"
//隐藏底部栏
#define HideBotum self.hidesBottomBarWhenPushed = YES
//不隐藏底部栏
#define NotHideBotum self.hidesBottomBarWhenPushed = NO
//RGBA
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
