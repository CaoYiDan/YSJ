//
//  SPIndustryView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/23.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^choseIndustry) (NSString *industry);
@interface SPIndustryView : UIView
@property(nonatomic,copy) choseIndustry chooseBlock;

@end
