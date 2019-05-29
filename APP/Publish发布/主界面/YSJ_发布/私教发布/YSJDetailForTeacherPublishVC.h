//
//  SPPublishVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^save2019Block) (NSString *detailText,NSMutableArray *imgArr,NSString *courseTime,NSString *courseNum);

@interface YSJDetailForTeacherPublishVC :BaseViewController

/**定位城市*/
@property(nonatomic,copy)NSString*locationCity;

/**回调*/
@property(nonatomic,copy) save2019Block block;

@end
