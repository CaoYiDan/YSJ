//
//  SPChooseHeaderView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/8.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SPChooseHeaderViewBlock)(NSInteger tag);
@interface SPChooseHeaderView : UIView
/**<##>block*/
@property(nonatomic,copy)SPChooseHeaderViewBlock SPChooseHeaderViewBlock;

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title ;
@end
