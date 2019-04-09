//
//  SPRightReusableView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *SPRightReusableViewID = @"SPRightReusableViewID";

@interface SPRightReusableView : UICollectionReusableView
/**<##>*/
@property(nonatomic,copy)NSString*name;

-(void)changeTextProperty;

-(void)setFont:(UIFont*)font;
@end
