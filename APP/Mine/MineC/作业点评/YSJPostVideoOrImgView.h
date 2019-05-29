//
//  YSJPostVideoOrImgView.h
//  SmallPig
//
//  Created by xujf on 2019/5/28.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSJPostVideoOrImgView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>


/**
 不能选择视频
 */
@property (nonatomic,assign) BOOL canNotSelectedVideo;
//@property (nonatomic,copy) NSString *title;
//@property (nonatomic,copy) NSString *placeHolder;

@end

NS_ASSUME_NONNULL_END
