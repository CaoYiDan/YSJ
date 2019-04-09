//
//  SPAllCategoryRightView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightDelegate <NSObject>

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end

@interface SPAllCategoryRightView : UITableViewController
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic, weak) id<RightDelegate> delegate;/**< delegate */
/**<##>Type*/
@property (nonatomic, strong) NSString*type;
@end
