//
//  SPHomeFrame.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.

#import "YSJHomeWorkFrameModel.h"

#import "YSJOrderModel.h"

#import "NSString+getSize.h"

#define  iconW  60.0
@implementation YSJHomeWorkFrameModel

-(void)setStatus:(YSJOrderModel*)status{
    _status = status;
    
    [self sMiddleF];
    
}

- (void)setStudentWorkModel:(YSJOrderModel *)studentWorkModel{
    _studentWorkModel = studentWorkModel;
    [self sMiddleForStudent];
}

-(void)sMiddleForStudent{
    
    CGFloat contentX = kMargin;
    
    CGFloat maxW = SCREEN_W - 2*kMargin;
    CGSize contentSize = [self.studentWorkModel.student_describe sizeWithFont:font(13) maxW:maxW];
    NSInteger H = contentSize.height+5;
    self.contentLabelF = CGRectMake(contentX, 10, maxW, H);
    
    
    NSArray *photoArr = self.studentWorkModel.student_despics;
    
    /** 有配图 */
    if (photoArr.count!=0) {
        self.photosViewF = (CGRect){{0,  CGRectGetMaxY(self.contentLabelF)+15}, CGSizeMake(SCREEN_W-contentX-kMargin,[self heigtForPhoto:photoArr.count])};
        
    } else { // 没配图
        
        self.photosViewF = (CGRect){{10, CGRectGetMaxY(self.contentLabelF)}, CGSizeMake(SCREEN_W,0)};
    }
    
    self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.photosViewF));
    NSLog(@"%.2f",self.topViewF.size.height);
    
    self.studentCellHeight = self.topViewF.size.height+20;
}

-(void)sMiddleF{
    
    CGFloat contentX = kMargin;
    
    CGFloat maxW = SCREEN_W - 2*kMargin;
    CGSize contentSize = [self.status.teacher_describe sizeWithFont:font(13) maxW:maxW];
    NSInteger H = contentSize.height+5;
    self.contentLabelF = CGRectMake(contentX, 10, maxW, H);

   
    NSArray *photoArr = self.status.teacher_despics;
    
    /** 有配图 */
    if (photoArr.count!=0) {
        self.photosViewF = (CGRect){{10,  CGRectGetMaxY(self.contentLabelF)+15}, CGSizeMake(SCREEN_W-contentX-kMargin,[self heigtForPhoto:photoArr.count])};
       
    } else { // 没配图
        
        self.photosViewF = (CGRect){{0, CGRectGetMaxY(self.contentLabelF)}, CGSizeMake(SCREEN_W,0)};
    }
    
    self.topViewF= CGRectMake(0, 0, SCREEN_W, CGRectGetMaxY(self.photosViewF));
    NSLog(@"%.2f",self.topViewF.size.height);
    
    self.cellHeight = self.topViewF.size.height+20;
}

//根据图片的个数 返回不同的高度
-(CGFloat)heigtForPhoto:(NSInteger)count{
    
    NSInteger index = count-1;
    
    if (count == 1) {
        
        return (SCREEN_W-kMiddleMargin-2*kMargin)/2;
        
    }else{
        
        return (SCREEN_W-kMargin*3-iconW)/3 *(index/3+1);
       
    }
    
    return 0;
}

@end

