//
//  HomeModel.h
//  SmallPig
//
//  Created by 李智帅 on 2017/6/22.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
//@property(nonatomic,copy)NSString * startTime;
//@property(nonatomic,copy)NSString * endTime;
@property(nonatomic,copy)NSString * code;
//@property(nonatomic,copy)NSString * beUser;//被预约
//@property(nonatomic,copy)NSString * doUser;//预约
//@property(nonatomic,copy)NSString * userName;//被预约用户名字
//@property(nonatomic,copy)NSString * userAvatar; //true string 被预约用户头像
//@property(nonatomic,copy)NSString * status;
@property(nonatomic,assign)BOOL readed;
//关注
@property(nonatomic,copy)NSString * nickName;//关注名字
@property(nonatomic,copy)NSString * avatar;//关注头像
@property(nonatomic,copy)NSString * level;//等级
@property(nonatomic,assign)BOOL followEachOther;
@end
