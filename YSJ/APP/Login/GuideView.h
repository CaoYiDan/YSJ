//
//  GuideView.h
//  TimeMemory
//
//  Created by 李智帅 on 16/9/5.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol removeGuideView <NSObject>

@optional
- (void)removeGuideView:(BOOL)remove;
@end

@interface GuideView : UIView
@property (nonatomic,retain) id <removeGuideView> delegate;
@property(nonatomic,strong) UIButton * inputButton;
- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
@end
