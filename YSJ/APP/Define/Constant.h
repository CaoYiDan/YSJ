//



//评价cell类型
typedef NS_ENUM(NSInteger,DynamicCellType)
{
    DynamicCellTypeForHome=0,//首页的动态列表cell
    DynamicCellTypeForProfile,//个人动态的列表cell
};

#define  SKILL @"SKILL"
#define  TAG   @"TAG"
#define HOBBY  @"HOBBY"
#pragma mark - Rect

//左右边距宽度
#define kMargin 12.0f

//中间间距
#define kMiddleMargin 5.0f

#define  headerHeight1 130.0f

#define bottomH 50
//==============================================================================
#pragma mark - FontSize
#define intToStringFormar(x) [NSString stringWithFormat:@"%d",x]

#define  font(x)  [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define  Font(x)  [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor hexColor:@"000000"]
#define KBlack333333 [UIColor hexColor:@"333333"]
#define  BoldFont(x) [UIFont boldSystemFontOfSize:x]
#define gray999999 [UIColor hexColor:@"999999"]
#define grayF2F2F2 [UIColor hexColor:@"F2F2F2"]
#define black666666 [UIColor hexColor:@"666666"]

#define gray9B9B9B [UIColor hexColor:@"9B9B9B"]
#define yellowEE9900 [UIColor hexColor:@"EE9900"]
#define kFontNormal_14 font(14+1)
#define kFontNormal font(13+1)
#define kFontTitle font(16)
#define kFontSmall font(11+1)

//支付方式
#define AliPay @"ALI_APP"

#define WXPay @"WX_APP"

//身份认证 字段
#define CERTIFIED @"CERTIFIED"//认证通过

#define FAITH_FEE @"FAITH_FEE"//诚意金

#define BAIL_FEE @"BAIL_FEE"//保证金
//====================================================================================
#pragma mark - --------------> 通用颜色色值 start

#define CategoryBaseColor        RGBCOLOR(249,249,249)     /*全局灰色背景*/

#define BaseRed        RGBCOLOR(228,54,53)     /*全局红*/
#define GRAYCOLOR        RGBCOLOR(238,238,238)     /*灰色标签*/
#define BASEGRAYCOLOR        RGBCOLOR(239,239,244)     /*全局灰色背景*/
#define PrinkColor         RGBA(254,56,100,1.0) //粉色
#define DarkRed        RGBCOLOR(236,35,45)     /*深红色*/
#define HomeBaseColor        RGBCOLOR(239,239,244)     /*首页背影颜色*/

#define BasePrinkColor        RGBCOLOR(248,46,247)     /*首页背影颜色*/

//#define NAVIGATIONCOLOR     RGBCOLOR(0,125,197)     /*蓝色导航*/
#define NAVIGATIONCOLOR     [Common colorWithHexString:@"#00b0ec"]     /*蓝色导航*/

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBCOLORA(r,g,b,z) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:z]
//标签颜色
#define PURPLECOLOR        RGBCOLOR(147,109,200)     /*紫色标签*/
#define DarkPURPLECOLOR        RGBCOLOR(117,51,247)     /*超深紫色标签*/

#define LIGHTPURPLECOLOR        RGBCOLOR(224,213,238)     /*淡紫色标签*/
#define PRINKCOLOR          RGBCOLOR(197,153,223)    /*粉红色标签*/
#define LIGHTPRINKCOLOR          RGBCOLOR(231,197,230)    /*淡粉红色标签*/
#define BULECOLOR   RGBCOLOR(62,142,208)   /*蓝色标签*/
#define LIGHTBULECOLOR       RGBCOLOR(191,220,236)   /*淡蓝色标签*/
#define GREENCOLOR      RGBCOLOR(129,165,89)      /*绿色标签*/
#define LIGHTGREENCOLOR      RGBCOLOR(216,236,190)     /*淡绿色标签*/
#define REDCOLOR      RGBCOLOR(168,39,39)   /*红色标签*/
#define LIGHTREDCOLOR      RGBCOLOR(239,186,186)     /*淡红色标签*/
#define ORANGECOLOR      RGBCOLOR(218,152,14)   /*橘色标签*/
#define LIGHTORANGECOLOR      RGBCOLOR(218,200,190)     /*淡橘色标签*/
#define BLUECOLOR2      RGBCOLOR(81,175,166)   /*蓝色标签2*/
#define LIGHTBLUECOLOR2      RGBCOLOR(191,230,219)     /*淡蓝色标签2*/
#define BUTTONTITLECOLOR    [Common colorWithHexString:@"#0061bb"]     /*按钮蓝色字体*/
#define BUTTON_ORDERTITLECOLOR    [Common colorWithHexString:@"#fe5a00"]     /*立即预定按钮蓝色字体*/
#define MyBlueColor      RGBCOLOR(28,138,223)   /*蓝色标签*/
#define HomeLineColor      RGBCOLOR(183,183,183)   /**/

//列表长分割线颜色
#define kLongSeparatorLineColor [UIColor hexStringToColor:@"#dddddd"]
//列表短分割线颜色
#define kShortSeparatorLineColor [UIColor hexStringToColor:@"#e6e9ed"]
//线条颜色
#define LineColor RGBCOLOR(230, 230, 230)
#pragma mark - --------------> 通用颜色色值 end

#pragma mark - -------------->StorageUser  start
#define kStorageUserDict          @"userDict"
#define kStorageUserAddressDict          @"userAddressDict"

#define kStorageCity          @"city"

#define kStorageLat          @"lat"
#define KStorageLon          @"lon"

#define kStorageUserId          @"userId"

#define kStorageLocation          @"location"

#define KStorageUserCode        @"code"
#define KStorageIfQuit           @"ifquit"

#define KStorageIfRemove        @"remove"

#define KStorageIm_password     @"im_password"

#define kStorageUserMobile      @"userMobile"
#define kStorageUserName        @"userName"
#define kStorageHeaderName      @"headerName"
#define kStorageUserRealName    @"realName"
#define kStorageUserType        @"userType"
#define kStorageUserSubType     @"userSubType"
#define kStorageUserStatus      @"userStatus"
#define kStorageDeviceToken      @"deviceToken"
#define kStorageFirstLogin       @"firstLogin"

#define kiPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_X ([UIScreen mainScreen].bounds.size.height ==812.0)
#define IS_IPHONE_6More ([UIScreen mainScreen].bounds.size.height>=667.0)
#define kiPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - -------------->StorageUser end

#pragma mark - --------------> log start
#ifdef DEBUG
#ifndef DLog
#   define NSLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef NSLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#pragma mark - --------------> log end


