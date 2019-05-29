//
//  SPNearVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"

typedef NS_ENUM(NSInteger, HandleDirectionType) {
    HandleDirectionOn          = 0,
    HandleDirectionDown        = 1,
    HandleDirectionLeft        = 2,
    HandleDirectionRight       = 3,
};

@interface SPNearVC : UIViewController
@property (nonatomic, strong) ZLSwipeableView *swipeableView;
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;


@end
