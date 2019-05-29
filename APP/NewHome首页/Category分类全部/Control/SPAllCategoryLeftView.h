//
//  SPAllCategoryLeftView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  categoryWid 90

@interface SPAllCategoryLeftView : UITableViewController
@property(nonatomic,strong)NSMutableArray*dataArr;
/**<#title#>*/
@property(nonatomic,assign)BOOL isfirstLoadVc; //这个方法比较笨，---首次加载VC,则选中第一个，不是首次，则置NO,不在选中第一行。

-(void)reloadMyTableView;

-(void)selectedIndex:(NSInteger)section;
@end
