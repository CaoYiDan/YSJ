//
//  SPApi.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//


//#define kUrlBase   @"http://192.168.1.253:8080/xzbj-api-server"

#define kUrlBase   @"http://www.smallzhuyue.com"

//认证列表 Get
#define URLOfIdentifyListGet kUrlBase@"/v1/identityRest/identStatus/"

//申请认证
#define URLOfApplyForCertification kUrlBase@"/v1/identityRest/certificate"

//获取认证信息 Get
#define URLOfGetCertification kUrlBase@"/v1/identityRest/certificate/"

#define kUrlPostImg  @"http://www.smallzhuyue.com/rtwm-image-server/v1/image/upload"

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

#define  ios11 @available(iOS 11.0, *)? YES : NO

//获取城市列表
#define KUrlGetCity      kUrlBase@"/v1/areaplace/getAreaTwoSpellDto"

//获取热门城市
#define KUrlGetHotCity    kUrlBase@"/v1/areaplace/getHotSpellDto"

//删除动态
#define KUrlFeedDelete      kUrlBase@"/v1/feed/delete"

//更新用户活跃度
#define KUrlUpdateLiveness      kUrlBase@"/v1/user/updateLiveness"
//删除动态
#define KUrlFeedUpdate      kUrlBase@"/v1/feed/update"

//查询是否关注
#define KUrlIfFollowed      kUrlBase@"/v1/follow/isFollowed"
//查询热门标签
#define KUrlHomeCategory      kUrlBase@"/v1/user/searchKilltag"

//登录
#define kUrlLogin      kUrlBase@"/v1/user/login"

//举报
#define kUrlReport      kUrlBase@"/v1/user/report"
//添加用户隐私设置
#define kUrlPrivacyAdd     kUrlBase@"/v1/privacy/add"

//删除用户隐私设置
#define kUrlPrivacyDelete     kUrlBase@"/v1/privacy/delete"

//修改备注
#define kUrlRemark      kUrlBase@"/v1/privacy/remark"
//广播接口
#define kUrlBroadcasts     kUrlBase@"/v1/broadcast/listBroadcasts"
//评价列表
#define kUrlCommnetList      kUrlBase@"/v1/comment/list"
//搜索结果列表接口
#define kUrlSearchList      kUrlBase@"/v1/selection/search"

//喜欢与不喜欢接口
#define kUrlLikeOrNO      kUrlBase@"/v1/like/add"
//精选列表
#define kUrlListGroupBySkills      kUrlBase@"/v1/selection/listGroupBySkills"
//轮播图数据
#define kUrlBanner      kUrlBase@"/v1/advert/listByPositionName"
//支付请求接口
#define kUrlForPay      kUrlBase@"/v1/pay/pay"
//获取雷达界面的接口
#define URLOfGetRadarList kUrlBase@"/v1/demand/findUserBydemand/"
//获取充值列表
#define KUrlRechargeList      kUrlBase@"/v1/recharge/list"

//热约接口
#define kUrlHot     kUrlBase@"/v1/selection/hot/about"
//获取保证金
#define kUrlBailList     kUrlBase@"/v1/bail/list"

//查询是否发布过此技能
#define kUrlLucrativeQuery     kUrlBase@"/v1/lucrative/query"

//删除我发布的需求
#define kUrldeleteDemand     kUrlBase@"/v1/demand/delDemand"

//修改技能状态
#define kUrlUpdateSkill     kUrlBase@"/v1/lucrative/update"
#define showMBP [MBProgressHUD showHUDAddedTo:self.view animated:YES]
#define hidenMBP [MBProgressHUD hideHUDForView:self.view animated:YES]
//应邀
#define kUrlGetLease     kUrlBase@"/v1/demand/addMyDemand"

//应邀广场数据
#define kUrlLeaseSquare     kUrlBase@"/v1/demand/list"
//我的应邀
#define kUrlMyLease     kUrlBase@"/v1/demand/listMyDemand"
//我的成交
#define kUrlLeaseDane     kUrlBase@"/v1/demand/listDealMyDemand"

//发布找人
#define kUrlFindPeople  kUrlBase@"/v1/demand/add"

//获取热门技能
#define kUrlHotSkill     kUrlBase@"/v1/property/hot"

//获取个人详情数据
#define kUrlProfileDetail     kUrlBase@"/v1/user/getUserDetail"

//获取行业列表
#define kUrlGetIndustryList     kUrlBase@"/v1/user/listJobs"

//查询用户发布过此技能时的信息
#define kUrlLucrativeQuery     kUrlBase@"/v1/lucrative/query"

//获取曾经的筛选信息
#define kUrlHistorySifting      kUrlBase@"/v1/user/getLastSearchHistory"

//保存用户筛选信息
#define kUrladdSearchHistory      kUrlBase@"/v1/user/addSearchHistory"

//更新查看个人信息中隐私设置
#define kUrlUpdatePrivacyForOne     kUrlBase@"/v1/privacy/updatePrivacyForOne"

//查看个人信息中隐私设置
#define kUrlLookAtPrivacyForOne     kUrlBase@"/v1/privacy/privacyForOne"

//快速报价接口
#define kUrlQuotationAdd      kUrlBase@"/v1/quotation/add"

//获取搜索历史及根据兴趣推荐
#define kUrlListSelections      kUrlBase@"/v1/selection/listSelections"

//获取所有等级接口
#define kUrlGetAllLevel      kUrlBase@"/v1/user/listAllLevels"
//个人信息更新
#define kUrlUpdateUser      kUrlBase@"/v1/user/updateUser"
//发布我要赚钱信息
#define kUrlLucrativeAdd      kUrlBase@"/v1/lucrative/add"
//设置备注
#define kUrlRemark      kUrlBase@"/v1/privacy/remark"

//发布评论
#define kUrlFeedComment      kUrlBase@"/v1/comment/add"
//发布动态
#define kUrlFeedAdd      kUrlBase@"/v1/feed/add"
//个人信息
#define kUrlMine      kUrlBase@"/v1/user/getUser"
//短信发送
#define MessageSend kUrlBase@"/v1/sms/sendVerifyCode"
//短信验证
#define MessageCompare kUrlBase@"/v1/sms/sendVerifyCode"

//获取用户动态列表
#define kUrlFeedList     kUrlBase@"/v1/feed/list"
//获取首页列表
#define kUrlLucrativeList    kUrlBase@"/v1/lucrative/list"
//获取得人动态列表
#define kUrlListAlbum     kUrlBase@"/v1/feed/listAlbum"

//获取动态详情
#define kUrlFeedGet     kUrlBase@"/v1/feed/get"
//获取活动列表
#define kUrlActivityList     kUrlBase@"/v1/activity/list"
//添加点赞
#define kUrlAddPraise     kUrlBase@"/v1/praise/add"
//查询附近人
#define kUrlSearchUser     kUrlBase@"/v1/user/searchUser"
//取消点赞
#define kUrlDeletePraise     kUrlBase@"/v1/praise/delete"

//获取用户信息
#define kUrlGetUser     kUrlBase@"/v1/user/getUser"

//获取用户技能二三级
#define kUrlGetSkill    kUrlBase@"/v1/user/listSecSkillsByUser"

//获取用户等级信息
#define kUrlGetUserLevel     kUrlBase@"/v1/user/getLevel"
//我的武功
#define kUrlListSkill      kUrlBase@"/v1/user/listSkills/true"
//我的标签
#define kUrllistTag      kUrlBase@"/v1/user/listTag"

//根据用户获取 我的武功
#define listSkillsByUser      kUrlBase@"/v1/user/listSkillsByUser"

//根据用户获取 我的标签
#define listTagsByUser      kUrlBase@"/v1/user/listTagsByUser"

//根据用户获取 我的兴趣
#define listHobbiesByUser      kUrlBase@"/v1/user/listHobbiesByUser"

//获取三级标签
#define kUrlListLeafByParentCode      kUrlBase@"/v1/forest/listLeafByParentCode"
////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"
//
////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"

////登录
//#define kUrlLogin      kUrlBase@"/v1/user/login"
//我的预约
#define kUrlMineReserve      kUrlBase@"/v1/reservation/listMyReservations"
//预约我的
#define kUrlReserveMine      kUrlBase@"/v1/reservation/listMyReservations"
//活动页
#define ActivityUrl kUrlBase@"/web/activity.html"
//广告页
#define AdvertisementURL kUrlBase@"/web/adv.html"
//个人信息页
//#define InfoMeURL @"http://smallzhuyue.com/web/info.html?code=1852030222645280609&share=true&userid=1852030222645280609"
