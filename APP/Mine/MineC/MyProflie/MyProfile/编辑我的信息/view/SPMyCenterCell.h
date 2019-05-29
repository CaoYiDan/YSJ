//
//  SPMyCenterCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const  SPMyCenterCellID = @"SPMyCenterCellID";

@interface SPMyCenterCell : UITableViewCell
-(void)setMyText:(NSString *)text;
-(void)changeContentFrameAndTextALight;
@end
