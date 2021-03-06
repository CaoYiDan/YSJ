//
//  YSJ_Api.h
//  SmallPig
//
//  Created by xujf on 2019/3/19.
//  Copyright © 2019年 lisen. All rights reserved.


//#define YUrlBase_YSJ   @"http://192.168.10.185:8003"

#define YUrlBase_YSJ  @"http://39.98.47.98:8002"

#pragma mark - 首页

#define YHomeBanner  YUrlBase_YSJ@"/home/ad"
#define YHomeSlider  YUrlBase_YSJ@"/home/slideshow"
#define YHomeTeacher  YUrlBase_YSJ@"/home/list/teachers"
#define YCare  YUrlBase_YSJ@"/profile/teacher/fan"
#define YCollection  YUrlBase_YSJ@"/profile/course/collects"

#define YHomecompanys  YUrlBase_YSJ@"/home/list/companys"

#define YHomerequirement  YUrlBase_YSJ@"/home/list/requirement"

#define YHomeTeachercourses  YUrlBase_YSJ@"/home/find/teachercourses"
#define YHomeDemands  YUrlBase_YSJ@"/home/find/demands"
#define YHomefindCompanys  YUrlBase_YSJ@"/home/find/companys"
#define YHomefindcategory  YUrlBase_YSJ@"/home/find/coursetype"
#define YHomefindsubcategory  YUrlBase_YSJ@"/home/find/coursetypes"
#define YTeacherBanner  YUrlBase_YSJ@"/profile/coach/personalshow"
#define YTeacherbaseinfo  YUrlBase_YSJ@"/profile/teacher/baseinfo"

#define YPinDanList  YUrlBase_YSJ@"/profile/coach/pindanlist"

#define YCompanybaseinfo  YUrlBase_YSJ@"/profile/company/baseinfo"
#define YCompanyCourse  YUrlBase_YSJ@"/profile/company/courseinfo"
#define YTeachercourseinfo  YUrlBase_YSJ@"/profile/teacher/courseinfo"
#define YTeacherPingJia  YUrlBase_YSJ@"/profile/evaluation/teacher/count"
#define YCoursePingJia  YUrlBase_YSJ@"/profile/evaluation/course/count"

#define YHomeAreas  YUrlBase_YSJ@"/address/city"
#define YHomecourseaddress  YUrlBase_YSJ@"/profile/teacher/courseaddress"
//获取私教、机构评价详情
#define YEvaluationDetails  YUrlBase_YSJ@"/profile/evaluation/teacher/details"

//获取单一课程评价详情
#define YCourseDetails  YUrlBase_YSJ@"/profile/evaluation/course/details"

#pragma mark - 登录

#define imgPinJieUrl(x)   [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,x]

#define YRegister  YUrlBase_YSJ@"/user/register"
#define YLogin  YUrlBase_YSJ@"/user/login"
#define YInformation  YUrlBase_YSJ@"/user/query/information"

#define Yredpacketorder_use  YUrlBase_YSJ@"/redpacket/order_use"

#define Yuserdiffer  YUrlBase_YSJ@"/user/differ"

#define Ymatchshow  YUrlBase_YSJ@"/match/show"
#define Yredpacketshow  YUrlBase_YSJ@"/redpacket/show"
#define Yredpacketgather  YUrlBase_YSJ@"/redpacket/gather"

#define Yredpacketget  YUrlBase_YSJ@"/redpacket/get"
#define Ymessageshowurl  YUrlBase_YSJ@"/message/showurl"
#define Yredpackettime  YUrlBase_YSJ@"/redpacket/time"
#define YcompanyStep1  YUrlBase_YSJ@"/requests/company/step1"
#define YcompanyStep2  YUrlBase_YSJ@"/requests/company/step2"
#define YcompanyStep3  YUrlBase_YSJ@"/requests/company/step3"
#define YTeacherStep1  YUrlBase_YSJ@"/requests/teacher/step1"
#define YTeacherStep2  YUrlBase_YSJ@"/requests/teacher/step2"
#define YTeacherStep3  YUrlBase_YSJ@"/requests/teacher/step3"
#define Yredpacketcreate  YUrlBase_YSJ@"/redpacket/create"

#define YTeacherStep4  YUrlBase_YSJ@"/requests/teacher/step4"
#define YNumber  YUrlBase_YSJ@"/user/number"
#define YInfoSet  YUrlBase_YSJ@"/user/infoset"

#define YPhoto YUrlBase_YSJ@"/user/photo"
#define YAllCourseType YUrlBase_YSJ@"/home/find/coursetype/all"

#pragma mark - 发布

#define YPublishDemands YUrlBase_YSJ@"/publish/user/demands"

#define YCancelPublish YUrlBase_YSJ@"/course/release/drop"

#define YCancelOrder YUrlBase_YSJ@"/course/user/buy_cancel"

#define YPayOrder YUrlBase_YSJ@"/course/user/buy_pay"

#define YOrderComplete YUrlBase_YSJ@"/course/complete"


#define YBeSureDrawBack YUrlBase_YSJ@"/course/teacher/drop"


#define YLables YUrlBase_YSJ@"/lables"

#define YPublishTeacherCourse  YUrlBase_YSJ@"/publish/teacher/course"

#define YHomeworkTeacherArrange  YUrlBase_YSJ@"/homework/arrange"
#define YHomeworkCompanyArrange  YUrlBase_YSJ@"/homework/carrange"
#define Yhomeworksubmit  YUrlBase_YSJ@"/homework/submit"
#define YGetTeacherList  YUrlBase_YSJ@"/publish/company/getteacher"
#define Yhomeworkcommenthomework  YUrlBase_YSJ@"/homework/commenthomework"
#define YAddTeacher  YUrlBase_YSJ@"/publish/company/addteacher"

#define YPublishCompany  YUrlBase_YSJ@"/publish/company/course"

#pragma mark - 买到管理

#define YBuyTeacerOrderCreate  YUrlBase_YSJ@"/order/teacher/create"
#define YBuyCompanyOrderCreate  YUrlBase_YSJ@"/order/company/create"
#define YCourseUserBuy  YUrlBase_YSJ@"/course/user/buy"
#define YCourseUserSale  YUrlBase_YSJ@"/course/user/sale"
#define YHomeworkStatus  YUrlBase_YSJ@"/homework/status"
#define Yhomeworkcompanystatus  YUrlBase_YSJ@"/homework/companystatus"
#define YCstatus  YUrlBase_YSJ@"/homework/cstatus"

#define YCourseUserBuyDeatil  YUrlBase_YSJ@"/course/user/buy_detail"
#define YCourseLabels  YUrlBase_YSJ@"/course/label"

#define YCourseEvaluation  YUrlBase_YSJ@"/course/evaluation"

#define YShow  YUrlBase_YSJ@"/user/personalshow"


#define YMyFindAll  YUrlBase_YSJ@"/course/findall"

#define YMyFollow  YUrlBase_YSJ@"/user/follow"

//查看退款进度
#define YCourseQuery  YUrlBase_YSJ@"/course/drop/query"

#define YOrderDrawBack  YUrlBase_YSJ@"/course/user/drop"

#define YOrderCheckEvaluation  YUrlBase_YSJ@"/course/check_evaluation"

#define YRules  YUrlBase_YSJ@"/user/rules"
