//
//  SPHomeFrame.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNewHomeCellFrame.h"
#import "SPHomeModel.h"
#import "NSString+getSize.h"

@implementation SPNewHomeCellFrame

-(void)setStatus:(SPHomeModel *)status{
    _status = status;
    
    [self sTopF];
    [self sMiddleF];
    [self sBottomF];
}

-(void)sTopF{
    
    CGFloat Y = 10;
    
    //头像
    CGFloat iconW = 42;
    self.iconViewF = CGRectMake(kMargin,Y,iconW , iconW);
    
    //昵称
    self.nameLabelF = CGRectMake(iconW+kMargin+kMargin,11,200, 20);
    
    //距离 和活跃状态
    self.distanceAndlivesLabelF = CGRectMake(iconW+kMargin +kMargin+60, 31,200, 20);
}

-(void)sMiddleF{
    
    CGFloat contentX = 10;
    
    CGFloat photosX = 0;
    CGFloat photosY =  CGRectGetMaxY(self.iconViewF)+10;
    /** 配图 */
    if (self.status.skillImgList.count) { // 有配图
      
        NSLog(@"%lu",(unsigned long)self.status.skillImgList.count);
        self.photosViewF = (CGRect){{photosX, photosY}, CGSizeMake(SCREEN_W,[self heigtForPhoto:self.status.skillImgList.count])};
       
    } else { // 没配图

        self.photosViewF = (CGRect){{photosX, photosY}, CGSizeMake(SCREEN_W,0)};
    }
    
    //服务人简介
    self.profileF = CGRectMake(kMargin, CGRectGetMaxY(self.photosViewF), 75, 30);
    
    //服务价格
    self.priceF = CGRectMake(kMargin+80, CGRectGetMaxY(self.photosViewF), SCREEN_W-kMargin-80-90, 30);
    
    /** 技能认证*/
    self.authenticationF = CGRectMake(SCREEN_W-90, CGRectGetMaxY(self.photosViewF)+5, 80, 20);
    
    /** 服务介绍*/
    CGFloat maxW = SCREEN_W- 4*kMargin;
    
    /** topView*/
    if (isEmptyString(self.status.serIntro)) {
        
        self.contentLabelF = CGRectMake(kMargin,CGRectGetMaxY(self.profileF)+1,0, 0);
        
    }else{
        
        CGSize contentSize = [self.status.serIntro sizeWithFont:kFontNormal_14 maxW:maxW];
        NSInteger H = contentSize.height+10;
        self.contentLabelF = CGRectMake(contentX, CGRectGetMaxY(self.profileF), maxW, H);
    }
    
     self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.contentLabelF));
    
}

-(void)sBottomF{
    
    //工具栏
    self.toolbarF = CGRectMake(SCREEN_W/6*2,CGRectGetMaxY(self.topViewF) , SCREEN_W/6*4, 50);
    
    //cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

//根据图片的个数 返回不同的高度
-(CGFloat)heigtForPhoto:(NSInteger)count{
    if (count == 1) {
        
        return (SCREEN_W-kMiddleMargin-2*kMargin)/2;
        
    }else {
        
        return (SCREEN_W-2*kMiddleMargin-2*kMargin)/3;
    }
    return 0;
}
@end

