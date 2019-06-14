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

typedef enum
{
    HomeWorkDetailCheckMyPublish,//查看我（私教）发布的作业
    HomeWorkDetailWaitCommit,//提交作业
    HomeWorkDetailCheckCommit,//查看提交的作业
    HomeWorkDetailWaitComment,//作业待点评
    HomeWorkDetailCheckComment,//查看点评
    
}HomeWorkDetailType;

typedef enum
{
   OrderTypeBuy = 0,//买到管理
   OrderTypeSale,//卖出管理
   OrderTypePublish,//我的发布
   CellTypeCollection,//我的收藏
   CellTypeForHomeComments,//作业点评
    HomeWorkPublish,//布置作业
    HomeWorkComment,//作业点评
    HomeWorkCommit,//作业提交
    
}YSJCellType;

typedef enum
{
    HBTypeGet = 0,//已领到（立即使用）
    HBTypeOut,//已失效
    HBTypeCreate,//已创建
    HBTypeDiscover,//发现红包
    HBTypeOnlyGet,//已领到，不可点击跳转
    HBTypeUse,//使用
}HBType;

typedef enum
{
    MyPublishTypeFindTeacher = 0,//
    MyPublishTypeFindCompany,//
    MyPublishTypeTeacherCourse ,//
    MyPublishTypeTeacherRequement,//
    MyPublishTypeCompanyFamous ,//
    MyPublishTypeCompanyJingPin,//
    MyPublishTypeCompanyFree,
}YSJMyPublishType;

typedef enum
{
    /** 系统自带的textfiled*/
    CellPopNormal = 0,//
    /** 自定义的textView */
    CellPopTextView,//
    /** 系统自带的sheet */
    CellPopSheet,//
    /**pushVC*/
    CellPushVC,
    /** //课程选择器 */
    CellPopCouserChosed,
    /** 开关switch */
    CellSwitch,
    /** 输入textField,带placeholder的那种*/
    CellTextFiled,
 
    /** 分割线 */
    CellPopLine,//
    /** 展示多个textFiled */
    CellPopMoreTextFiledView,
    /** 选择有效日期 */
    CellPopYouXiaoView,
    /** 门槛 满 ..适用 */
    CellPopMenKanView,
}YSJCellPopViewType;

/** 进入支付的对象 */
typedef NS_ENUM(NSUInteger, YSJPayForObject) {
    YSJPayForPinDan,//参与他人拼单
    YSJPayForStartPinDan,//发起拼单
    YSJPayForSinglePinDan,//单独拼单购买
    YSJPayForCompanyCourse,//机构课程购买
    YSJPayForTeacherOneByOne,//教师一对一购买
};
