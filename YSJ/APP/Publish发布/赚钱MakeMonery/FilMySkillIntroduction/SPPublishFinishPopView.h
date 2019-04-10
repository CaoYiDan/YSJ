//
//  SPPopTipView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^complment)(NSString *resultStr);
@interface SPPublishFinishPopView : UIView

/***/
@property(nonatomic,copy)complment complmentBlock;

-(instancetype)initWithFrame:(CGRect)frame complment:(complment)complment;
@end

