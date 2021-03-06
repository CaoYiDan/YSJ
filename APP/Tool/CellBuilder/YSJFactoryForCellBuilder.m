//
//  YSJFactoryForCellBuilder.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJPopMenKanView.h"
#import "YSJPopYouXiaoDateView.h"
#import "YSJPopTextFiledView.h"
#import "YSJPopTextViewView.h"
#import "YSJPopSheetView.h"
#import "YSJPopMoreTextFiledView.h"
#import "YSJPopProtocol.h"
#import "YSJPushVCArrowView.h"
#import "YSJPopViewProtocol.h"
#import "YSJFactoryForCellBuilder.h"
#import "YSJCommonSwitchView.h"
#import "YSJPopCourserCellView.h"
#import "YSJTextFiledCellView.h"

@implementation YSJFactoryForCellBuilder
{
    UIScrollView *_scrollView;
    UIView *_tagView;
    CGFloat orY;
    CGFloat cellH;
    NSMutableArray *_cellViewArr;
    NSMutableArray *_sepLineViewArr;//分割线数组
}

-(UIScrollView *)createViewWithDic:(NSDictionary *)dic
{
    orY = [dic[@"orY"] doubleValue];
    
    cellH = [dic[cb_cellH] doubleValue];
    
    NSArray *cellArr = dic[cb_cellArr];
    
    UIScrollView  *_scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView = _scroll;
    _scroll.backgroundColor = KWhiteColor;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
    _tagView = _scroll;
    
    _cellViewArr = @[].mutableCopy;
    _sepLineViewArr = @[].mutableCopy;
    
    for (NSDictionary *cellDic in cellArr) {
        
        NSInteger type = [cellDic[@"type"] integerValue];
        
        if (type==CellPopNormal) {
            
            YSJPopTextFiledView  *arrow =[[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            arrow.keyBorad = [cellDic[@"keyBoard"] intValue];
            
            [self p_addView:arrow];
            
        }else if (type == CellPopSheet){
            
            YSJPopSheetView *arrow =[[YSJPopSheetView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            arrow.otherStr = cellDic[@"sheetText"];
            
            [self p_addView:arrow];
            
        }else if (type == CellPopTextView){
            
            YSJPopTextViewView *arrow =[[YSJPopTextViewView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            [self p_addView:arrow];
            
        }else if (type == CellPopYouXiaoView){
            
            YSJPopYouXiaoDateView *arrow =[[YSJPopYouXiaoDateView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            [self p_addView:arrow];
            
        }else if (type == CellPopCouserChosed){
            
            YSJPopCourserCellView  *arrow =[[YSJPopCourserCellView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            //单选 还是 多选
            arrow.type = [cellDic[cb_courseCategoryType] integerValue];
            
            [self p_addView:arrow];
            
        }else if (type==CellPushVC) {
            
            YSJPushVCArrowView *arrow = [[YSJPushVCArrowView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            arrow.otherStr = cellDic[cb_otherString];
            
            [self p_addView:arrow];
            
        }else if (type ==CellSwitch) {
            
            YSJCommonSwitchView *arrow = [[YSJCommonSwitchView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] selected:YES];
            
            [self p_addView:arrow];
            
        }else if (type ==CellPopMenKanView) {
            
            YSJPopMenKanView *arrow =[[YSJPopMenKanView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            [self p_addView:arrow];
            
        }else if (type == CellTextFiled) {
            
            YSJTextFiledCellView *arrow = [[YSJTextFiledCellView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) title:cellDic[@"title"] placholder:cellDic[@"placeholder"]];
            
            [self p_addView:arrow];
            
        }else if (type == CellPopMoreTextFiledView) {
            
            YSJPopMoreTextFiledView *arrow = [[YSJPopMoreTextFiledView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            
            arrow.otherStr = cellDic[cb_moreTextFiledArr];
            
            [self p_addView:arrow];
            
        }else if ([cellDic[@"type"] integerValue]==CellPopLine) {
            
            CGFloat lineH =[cellDic[@"lineH"] doubleValue];
            UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, lineH)];
            bottomLine.backgroundColor = grayF2F2F2;
            [_scroll addSubview:bottomLine];
            
            self.lastBottomView =bottomLine;
            
            orY+=lineH;
            
            //注意，lineView  并没有加入到_cellViewArr数组中;
            [_sepLineViewArr addObject:bottomLine];
            
        }
    }
    
    return  _scroll;
}


-(void)p_addView:(UIView *)arrow{
    
    [_scrollView addSubview:arrow];
    
    orY+=cellH;
    
    self.lastBottomView = arrow;
    
    [_cellViewArr addObject:arrow];
    
}

#pragma mark - 获取所有cell的信息（lineView除外）
/**
 获取所有cell的信息（lineView除外）
 
 @return 返回数组
 */
- (NSMutableArray *)getAllContent{
    
    NSMutableArray *arr = @[].mutableCopy;
    
    for (id<YSJPopViewProtocol> pro in _cellViewArr) {
        //遵循YSJPopViewProtocol，获取填写的信息
        NSString *content = [pro getContent];
        
        if (!isEmptyString(content)) {
            [arr addObject:content];
        }else{
            [arr addObject:@""];
        }
    }
    NSLog(@"%@",arr);
    return arr;
}

-(void)removeCellView{
    
    for (UIView *vi in _cellViewArr) {
        [vi removeFromSuperview];
    }
    
}

#pragma mark - 专门为 发布需求 写的方法

-(void)hiddenViewForRequement{
    
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (i==3 || i==4) {
            //            [vi removeFromSuperview];
        }else{
            
            [UIView animateWithDuration:0.2 animations:^{
                //大于4的view 坐标上移2个单位
                vi.originY -= i>4?cellH*2:0;
            }];
        }
        i++;
    }
}

- (void)showViewForRequement{
    
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (i==3 || i==4) {
            
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                //大于4的view 坐标下移2个单位
                vi.originY += i>4?cellH*2:0;
            }];
        }
        i++;
    }
}

#pragma mark - 专门为 发布私教 写的方法

/**
 私教课程
 */
-(void)publishForTeachOneByOne{
    
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
         if (i==4) {
            
            //获取坐标
            CGRect frame = vi.frame;
            //移除
            [vi removeFromSuperview];
            [_cellViewArr removeObjectAtIndex:4];
            
            //生成新的cell
            YSJCommonSwitchView *newCell = [[YSJCommonSwitchView alloc]initWithFrame:frame withTitle:@"上门服务" selected:YES];
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:4];
            break;
        }
        i++;
    }
    
    int j=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (j == 2) {
            
            //获取坐标
            CGRect frame = vi.frame;
            //移除
            [vi removeFromSuperview];
            [_cellViewArr removeObjectAtIndex:2];
            
            //生成新的cell
            YSJPopMoreTextFiledView *newCell = [[YSJPopMoreTextFiledView alloc]initWithFrame:frame withTitle:@"课程价格" subTitle:@""];
            
            newCell.otherStr = @"现价,原价";
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:2];
            
            break;

        }
        j++;
        
    }

}

/**
 拼单课程
 */
-(void)publishForTeachPinDan{
    
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (i==4) {
            
            //获取坐标
            CGRect frame = vi.frame;
            //移除
            [vi removeFromSuperview];
            [_cellViewArr removeObjectAtIndex:4];
            
            //生成新的cell
            YSJPopMoreTextFiledView *newCell = [[YSJPopMoreTextFiledView alloc]initWithFrame:frame withTitle:@"拼单人数" subTitle:@""];
            
            newCell.otherStr = @"最少人数,最多人数";
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:4];
            
            break;
        }
        i++;
    }
    
    int j=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (j == 2) {
            
            //获取坐标
            CGRect frame = vi.frame;
            //移除
            [vi removeFromSuperview];
            [_cellViewArr removeObjectAtIndex:2];
            
            //生成新的cell
            YSJPopMoreTextFiledView *newCell = [[YSJPopMoreTextFiledView alloc]initWithFrame:frame withTitle:@"课程价格" subTitle:@""];
            
            newCell.otherStr = @"现价,原价,拼单价";
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:2];
            
            break;
        }
        j++;
        
    }
}

#pragma mark - 专门为 发布机构 写的方法

/**
 明星课程 he 精品课程 布局一样
 */
-(void)publishForCompanyFamousCourseOrJingPin{
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (i==2) {
            
        }else{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                if (i==3 || i==4) {
                    vi.originY += cellH;
                }else if (i>3){
                    vi.originY += cellH*2;
                }
            }];
        }
        i++;
    }
    
    //分割线的变动
    for (UIView *line in _sepLineViewArr) {
        line.originY += cellH*2;
    }
}


/**
 试听课程
 */
-(void)publishForCompanyFree{
    
    int i=0;
    
    for (UIView *vi in _cellViewArr) {
        
        if (i==2 ) {
            
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                
                if (i==3 || i==4) {
                    vi.originY -= cellH;
                }else if (i>3){
                    vi.originY -= cellH*2;
                }
            }];
        }
        i++;
    }
    
    //分割线的变动
    for (UIView *line in _sepLineViewArr) {
        line.originY -= cellH*2;
    }
}

@end
