//
//  SPMyMessageModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/9/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPMyMessageModel : NSObject
@property(nonatomic,copy)NSString * Id;//通知id
@property(nonatomic,copy)NSString * type;//通知类型
@property(nonatomic,copy)NSString * code;//通知code
@property(nonatomic,copy)NSString * sender;//发送者
@property(nonatomic,copy)NSString * reciver;//接受者
@property(nonatomic,copy)NSString * content;//内容
@property(nonatomic,copy)NSString * sendTime;//发送时间
@property(nonatomic,assign)BOOL readed;
@property(nonatomic,copy)NSString * image;//图片
@property(nonatomic,copy)NSString * mainCode;//
@property(nonatomic,copy)NSString * feedContent;//动态或者消息内容
@property(nonatomic,copy)NSString * avatar;//头像





@end
