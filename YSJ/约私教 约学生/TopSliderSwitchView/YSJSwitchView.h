//
//  YSJSwitchView.h
//  SmallPig
//
//  Created by xujf on 2019/3/21.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchDelegate
-(void)switchViewDidSelectedIndexRow:(NSInteger)indexRow;
@end;

@interface YSJSwitchView : UIView
/**<##>数据数组*/
@property (nonatomic, strong)NSArray *listArr;
@property (nonatomic,weak) id<SwitchDelegate> delegate;
@end
