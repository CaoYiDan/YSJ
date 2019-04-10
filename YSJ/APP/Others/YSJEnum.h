//
//  YSJeNUM.h
//  SmallPig
//
//  Created by xujf on 2019/3/20.
//  Copyright © 2019年 lisen. All rights reserved.
//

//私教
#define teachers @"teachers"
//机构
#define companys @"companys"
//学生
#define requirements @"requirements"

typedef enum
{
   HomeCellTeacher = 0,
   HomeCellCompany,
   HomeCellRequiment,
}YSJHomeCellType;

/** 进入支付的对象 */
typedef NS_ENUM(NSUInteger, YSJPayForObject) {
    YSJPayForPinDan,//参与他人拼单
    YSJPayForStartPinDan,//发起拼单
    YSJPayForSinglePinDan,//单独拼单购买
    YSJPayForCompanyCourse,//机构课程购买
    YSJPayForTeacherOneByOne,//教师一对一购买
};