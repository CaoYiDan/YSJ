//
//  MFTeacherCell.h
//  MoFang
//
//  Created by xujf on 2019/1/4.
//  Copyright © 2019年 ZBZX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MFinformationModel;
static  NSString *teacherCellID = @"teacherCellID";
@interface MFTeacherCell : UITableViewCell
@property (nonatomic,strong) MFinformationModel *model;
@end
