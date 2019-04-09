//
//  SPHomeSifingVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPHomeSifingVCDelegate <NSObject>

-(void)SPHomeSifingVCSifting:(NSMutableDictionary *)siftingDic;

@end

@interface SPHomeSifingVC : UIViewController

/**代理<##>*/
@property(nonatomic,weak)id <SPHomeSifingVCDelegate> delegate;
@end
