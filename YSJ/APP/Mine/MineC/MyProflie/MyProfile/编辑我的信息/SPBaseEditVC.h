//
//  SPBaseEditVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//


#import "SPPerfectBaseVCViewController.h"

@interface SPBaseEditVC :SPPerfectBaseVCViewController
/**标题*/
@property(nonatomic,copy)NSString*titletText;
/**关键词*/
@property(nonatomic,copy)NSString*codeText;
/**<##>之前的信息*/
@property(nonatomic,copy)NSString*placeHoder;
@end
