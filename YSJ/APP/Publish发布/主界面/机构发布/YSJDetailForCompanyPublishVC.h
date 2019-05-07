//
//  SPPublishVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/29.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^saveBlock) (NSString *detailText,NSMutableArray *courseImgArr,NSMutableArray *teacherArr);

@protocol DetailForCompanyPublishVCDelegate

-(void)getDetailText:(NSString *)detailText courseImgArr:(NSMutableArray *)courseImgArr teacherIdArr:(NSMutableArray *)teacherIdArr;

@end

@interface YSJDetailForCompanyPublishVC :BaseViewController

/**定位城市*/
@property(nonatomic,copy)NSString*locationCity;

@property (nonatomic,weak) id <DetailForCompanyPublishVCDelegate> delegate;

@end
