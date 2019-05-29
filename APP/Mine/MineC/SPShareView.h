//
//  SPShareView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPShareView : UIView 
/**<##>分享的用户头像图片*/
@property (nonatomic, strong)UIImage *shareImg;
/**<##>分享的链接*/
@property(nonatomic,copy)NSString*shareUrl;
/**<##>分享的标题*/
@property(nonatomic,copy)NSString*title;
/**<##>分享的副标题*/
@property(nonatomic,copy)NSString*subTitle;
@end
