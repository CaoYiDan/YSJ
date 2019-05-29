//
//  SPMyskillDetailBottomToolView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SPMyskillDetailBottomToolViewDelegate <NSObject>
-(void)SPMyskillDetailBottomToolViewDidSelectedTag:(NSInteger)tag;
@end

@interface SPMyskillDetailBottomToolView : UIView
/**<##>代理*/
@property(nonatomic,weak)id<SPMyskillDetailBottomToolViewDelegate> delegate;

-(void)initWithStatus:(NSString *)status;
@end
