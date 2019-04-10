//
//  LGEvaluateStatusFrame.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "SPProfileCommentFrame.h"

#import "SPCommentModel.h"
#import "NSString+getSize.h"
@implementation SPProfileCommentFrame
{
    CGFloat iconWH;
}

- (void)setStatus:(SPCommentModel *)status{
    
    _status=status;
    
    [self setTopViewFrame];
    
    [self setMiddleViewFrame];//中间frame
    
    [self setBottomViewFrame];
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);//cell的高度
}

#pragma  mark - 上半部分View

-(void)setTopViewFrame{
    iconWH = 40;
    /** 头像*/
    self.iconViewF = CGRectMake(HWStatusCellBorderW,10, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellBorderW;
    CGSize nameSize = [self.status.commentorName sizeWithFont:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, 10+iconWH/2-nameSize.height/2}, nameSize};
    
    /** 时间*/
    self.timeLabelF = CGRectMake(kWindowW-150, 10+iconWH/2-nameSize.height/2 ,140 ,25);
    
    /** 上部分View topView*/
    self.topViewF = CGRectMake(0, HWStatusCellMargin, kWindowW, CGRectGetMaxY(self.iconViewF)+10);
}

#pragma  mark 中间viewframe

-(void)setMiddleViewFrame{
    
    /** 正文 */
    CGFloat contentX = HWStatusCellBorderW;
    CGFloat contentY = 0;
    CGFloat maxW = kWindowW - 2 * contentX;
    
    
    CGSize contentSize = CGSizeZero;
    
    contentSize = [self.status.content sizeWithFont:HWStatusCellContentFont maxW:maxW];
    
    NSInteger contentW = contentSize.width;
    NSInteger contentH = contentSize.height;
    
    self.contentLabelF = (CGRect){{contentX, contentY}, contentW+1,contentH+10};
    
    /** 中间View*/
    self.middleViewF = CGRectMake(0, CGRectGetMaxY(self.topViewF)+1, kWindowW, CGRectGetMaxY(self.contentLabelF));
}

#pragma  mark 底部toolView

-(void)setBottomViewFrame{
    
    CGFloat toolbarX = 0;
    CGFloat toolbarW = kWindowW;
    CGFloat toolbarH = 34;
     /** 评分viewFrame*/
    self.starF= CGRectMake(toolbarX, CGRectGetMaxY(self.middleViewF)+1, toolbarW, toolbarH);
    
    /** 工具条 */
    self.toolbarF= CGRectMake(toolbarX, CGRectGetMaxY(self.middleViewF)+1, toolbarW, toolbarH);
}

@end

