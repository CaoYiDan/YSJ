//
//  YSJHeaderForPublishCompanyView.h
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import "YSJPopMoreTextFiledView.h"

NS_ASSUME_NONNULL_BEGIN


/**
 刷新block

 @return <#return value description#>
 */
typedef  void (^RefreshBlock)();

typedef  void (^ChangeContentInsetBlock)(CGFloat contentofY);

@class  LGTextView,YSJPopTextFiledView;

@interface YSJPhotosForProfileView : UIView

/**
 刷新block
 
 @return
 */
@property (nonatomic,copy) RefreshBlock block;
@property (nonatomic,copy) ChangeContentInsetBlock contentofYChangeBlock;

@property(nonatomic,weak)LGTextView *textView;

@property (nonatomic, strong) NSMutableArray *photos;

@property (nonatomic,strong) NSMutableArray *urlArr;

/**
 上课时间
 */
@property (nonatomic,strong) YSJPopTextFiledView *classTime;
/**
 课时数
 */
@property (nonatomic,strong) YSJPopMoreTextFiledView *classNums;

-(void)setPhotoImg:(NSArray *)imgs;

@end

NS_ASSUME_NONNULL_END
