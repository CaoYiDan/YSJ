//
//  LabelAndImage.h
//  SmallPig
//
//  Created by 李智帅 on 2017/6/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelAndImage : UIView
/**<##>图片*/
@property(nonatomic,strong)UIImageView*unitImageView;
/**<##>z字体*/
@property(nonatomic,strong)UILabel*unitTextLabel;
//图片字体方向
@property(nonatomic,assign)NSInteger imageType;
-(void)setLabelText:(NSString*)text WithColor:(UIColor *)color;
-(void)setImageView:(NSString*)imageName;
@end
