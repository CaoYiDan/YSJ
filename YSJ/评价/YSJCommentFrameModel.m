//
//  SPHomeFrame.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "YSJCommentFrameModel.h"

#import "YSJCommentsModel.h"

#import "NSString+getSize.h"

#define  iconW  60.0
@implementation YSJCommentFrameModel

-(void)setStatus:(YSJCommentsModel*)status{
    _status = status;
    
    [self sTopF];
    [self sMiddleF];
    
}

-(void)sTopF{
    
    CGFloat Y = 15;
    
    //头像
   
    self.iconViewF = CGRectMake(kMargin,Y,iconW , iconW);
    
    //昵称
    self.nameLabelF = CGRectMake(iconW+kMargin +kMargin,Y,200, 20);
    //评分
    self.starF = CGRectMake(iconW+kMargin +kMargin,40, 70, 20);
    //时间
    self.timeF = CGRectMake(kWindowW-80, 31, 70, 20);
}

-(void)sMiddleF{
    
    CGFloat contentX = iconW+kMargin +kMargin;
    
    CGFloat maxW = SCREEN_W - (iconW+kMargin +kMargin+kMargin);
    CGSize contentSize = [self.status.content sizeWithFont:font(13) maxW:maxW];
    NSInteger H = contentSize.height+5;
    self.contentLabelF = CGRectMake(contentX, CGRectGetMaxY(self.starF)+10, maxW, H);
    
    CGFloat tagY =  CGRectGetMaxY(self.contentLabelF)+10;

    self.tagLabelF = CGRectMake(contentX, tagY, kWindowW-50, 30);
    
    NSArray *photoArr = [self.status.photo_urls componentsSeparatedByString:@","];
    
    /** 配图 */
    if (photoArr.count) { // 有配图

        self.photosViewF = (CGRect){{contentX,  CGRectGetMaxY(self.tagLabelF)}, CGSizeMake(SCREEN_W-contentX-kMargin,[self heigtForPhoto:photoArr.count])};
        NSLog(@"%@",self.status.photo_urls);
    } else { // 没配图
        
        self.photosViewF = (CGRect){{0, CGRectGetMaxY(self.tagLabelF)}, CGSizeMake(SCREEN_W,0)};
    }
   
    self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.photosViewF));
     NSLog(@"%.2f",self.topViewF.size.height);
    
    self.cellHeight = self.topViewF.size.height+10;
}


//根据图片的个数 返回不同的高度
-(CGFloat)heigtForPhoto:(NSInteger)count{
    if (count == 1) {
        
        return (SCREEN_W-kMiddleMargin-2*kMargin)/2;
        
    }else {
        
        return (SCREEN_W-kMargin*3-iconW)/3;
    }
    return 0;
}
@end

