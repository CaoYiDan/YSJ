//
//  SPHomeFrame.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPProfileDynamicFrame.h"
#import "SPDynamicModel.h"
#import "NSString+getSize.h"

@implementation SPProfileDynamicFrame

-(void)setStatus:(SPDynamicModel *)status{
    _status = status;
    
    [self sTopF];
    [self sMiddleF];
    [self sBottomF];
}

-(void)sTopF{
    
    CGFloat Y = 10;
    
    //头像
    CGFloat iconW = 50;
    self.iconViewF = CGRectMake(kMargin,Y,iconW , iconW);
    
    //昵称
    self.nameLabelF = CGRectMake(iconW+kMargin +kMargin, Y+iconW/2-10, 100, 20);
    
    //发布时间
    self.timeAndAreaLabelF = CGRectMake(SCREEN_W-100, self.nameLabelF.origin.y, 85, 30);
}

-(void)sMiddleF{
    
    CGFloat contentX = 10;
    
    /** 正文 */
    CGFloat maxW = SCREEN_W- 4*contentX;
    
    /** topView*/
    if (isEmptyString(self.status.text)) {
        
        self.contentLabelF = CGRectMake(contentX,CGRectGetMaxY(self.iconViewF)+1,0, 0);
        
        /** topView*/
//        self.topViewF= CGRectMake(contentX, 0, SCREEN_W-2*contentX, originalH);
//        
    }else{
        
        CGSize contentSize = [self.status.text sizeWithFont:kFontNormal_14 maxW:maxW];
        NSInteger H = contentSize.height+10;
        self.contentLabelF = CGRectMake(contentX, CGRectGetMaxY(self.iconViewF), maxW, H);
        
    }
    
    /** 配图 */

    if (self.status.imgs.count) { // 有配图
        CGFloat photosX = 0;
        CGFloat photosY =  CGRectGetMaxY(self.contentLabelF);
        NSLog(@"%lu",(unsigned long)self.status.imgs.count);
        self.photosViewF = (CGRect){{photosX, photosY}, CGSizeMake(SCREEN_W,[self heigtForPhoto:self.status.imgs.count])};
          self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.photosViewF));
    } else { // 没配图

        self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.contentLabelF));
    }
    
}

-(void)sBottomF{
    
    //工具栏
    self.toolbarF = CGRectMake(0,CGRectGetMaxY(self.topViewF) , SCREEN_W, 50);
    
    //cell高度
    self.cellHeight = CGRectGetMaxY(self.toolbarF)-20;
}

//根据图片的个数 返回不同的高度
-(CGFloat)heigtForPhoto:(NSInteger)count{
    if (count == 1) {
        
        //获取加载的图片的大小，然后按比例返回高度
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.status.imgs[0]]];
        UIImage *image = [UIImage imageWithData:data];
        
        return image.size.height/image.size.width*SCREEN_W;
    }else if (count ==2){
        return (SCREEN_W)/2;
    }else if (count == 3){
        return (SCREEN_W)/2;
    }else if (count == 4){
        return (SCREEN_W)/3*2;
    }else if (count == 5){
        return (SCREEN_W)/2+(SCREEN_W)/3;
    }else if (count == 6){
        return (SCREEN_W)/2+(SCREEN_W)/3;
    }else if (count == 7){
        return (SCREEN_W)/2+(SCREEN_W)/3*2;
    }else if (count == 8){
        return (SCREEN_W);;
    }else if (count == 9){
        return (SCREEN_W);
    }
    return 0;
}
@end
