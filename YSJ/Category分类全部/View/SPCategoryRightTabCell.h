//
//  SPCategoryRightTabCell.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString* SPCategoryRightTabCellID =@"SPCategoryRightTabCellID";
@interface SPCategoryRightTabCell : UITableViewCell
/**<#Name#>*/
@property (nonatomic, strong)NSMutableArray *secondLevelDataArr;
-(void)canClick;
/**<##>Type*/
@property (nonatomic, strong) NSString*type;
@end
