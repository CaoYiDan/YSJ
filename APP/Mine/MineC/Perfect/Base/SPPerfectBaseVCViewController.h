//
//  SPPerfectBaseVCViewController.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/5.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"
#import "SPMyButtton.h"
#import "SPUser.h"
typedef void(^perfaceBlock)(NSDictionary *dict);
@interface SPPerfectBaseVCViewController : BaseViewController
/**<##>block回传*/
@property(nonatomic,copy)perfaceBlock perfaceBlock;
//跳过
@property (nonatomic, strong)SPMyButtton *jumpBtn;
//下一步
@property (nonatomic, strong)SPMyButtton *nextBtn;
//保存
@property (nonatomic, strong)UIButton *saveBtn;
//是否需要请求最新接口
@property (nonatomic , assign,getter=isNeedLoad)BOOL needLoad;

//设置背景图片
-(void)setBaseImgViewWithImgage:(UIImage *)image;

//上传服务器
-(void)postMessage:(NSMutableDictionary *)paragram pushToVC:(NSString *)vc;

//是否需要拦截，返回拦截弹出提示框方法
@property (nonatomic , assign,getter=isNeedShowAlter)BOOL needShow;

//是否从个人中心 push进来
@property (nonatomic , assign,getter=isFormMyCenter)BOOL formMyCenter;

/**个人中心进入 传入模型*/
@property (nonatomic, strong)SPUser *user;

//交由子类调用的，返回拦截弹出提示框方法
-(void)showAliterView;
@end
