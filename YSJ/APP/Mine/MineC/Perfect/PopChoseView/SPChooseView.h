//
//  SPChooseView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseBolck) (NSArray *array);
@interface SPChooseView : UIView

/**<##>block*/
@property(nonatomic,copy) ChooseBolck chooseBlock;

//每次调起，都要重新加载数据，并刷新
-(void)loadWithCode:(NSString *)code withAllArray:(NSArray *)allArr haveChosedArr:(NSMutableArray *)choosedArr headerTitle:(NSString *)title;

@end
