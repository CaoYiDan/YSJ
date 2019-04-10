//
//  SPCanDeleteImgView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^deleteblock)(NSInteger tag);
@interface SPCanDeleteImgView : UIImageView

@property(nonatomic,copy)deleteblock deleteblock;

@end
