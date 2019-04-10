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
