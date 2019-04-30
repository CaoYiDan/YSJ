//
//  YSJFactoryForCellBuilder.m
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJPopTextFiledView.h"
#import "YSJPopTextViewView.h"
#import "YSJPopSheetView.h"
#import "YSJPopMoreTextFiledView.h"
#import "YSJPopProtocol.h"
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
}

-(UIScrollView *)createViewWithDic:(NSDictionary *)dic
{
    orY = [dic[@"orY"] doubleValue];
    
    cellH = [dic[@"cellH"] doubleValue];
    
    NSArray *cellArr = dic[@"arr"];
    
    UIScrollView  *_scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scrollView = _scroll;
    _scroll.backgroundColor = KWhiteColor;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
    _tagView = _scroll;
    
    _cellViewArr = @[].mutableCopy;
    
    for (NSDictionary *cellDic in cellArr) {
        
        
        NSInteger type = [cellDic[@"type"] integerValue];
        
        if ( type==CellPopNormal || type == CellPopTextView || type == CellPopSheet|| type == CellPopCouserChosed) {
            
            YSJLSBaseCommonCellView *arrow = nil;
            if (type==CellPopNormal) {
                
                arrow =[[YSJPopTextFiledView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
                
                arrow.keyBorad = [cellDic[@"keyBoard"] intValue];
                
            }else if (type == CellPopSheet){
                
                arrow =[[YSJPopSheetView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
                arrow.otherStr = cellDic[@"sheetText"];
                
            }else if (type == CellPopTextView){
                
                arrow =[[YSJPopTextViewView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            }else if (type == CellPopCouserChosed){
                
                arrow =[[YSJPopCourserCellView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            }
            
            [_scroll addSubview:arrow];
            
            orY+=cellH;
            
            self.lastBottomView = arrow;
            
            [_cellViewArr addObject:arrow];
            
        }else if (type ==CellSwitch) {
            
            YSJCommonSwitchView *arrow = [[YSJCommonSwitchView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] selected:YES];
            [_scroll addSubview:arrow];
            orY+=cellH;
            self.lastBottomView = arrow;
            
            [_cellViewArr addObject:arrow];
            
        }else if (type == CellTextFiled) {
            YSJTextFiledCellView *arrow = [[YSJTextFiledCellView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) title:cellDic[@"title"] placholder:cellDic[@"placeholder"]];
            [_scroll addSubview:arrow];
            orY+=cellH;
            self.lastBottomView = arrow;
            
            [_cellViewArr addObject:arrow];
            
        }else if (type == CellPopMoreTextFiledView) {
            
            YSJPopMoreTextFiledView *arrow = [[YSJPopMoreTextFiledView alloc]initWithFrame:CGRectMake(0, orY, kWindowW, cellH) withTitle:cellDic[@"title"] subTitle:@""];
            arrow.otherStr = cellDic[@"arr"];
            [_scroll addSubview:arrow];
            orY+=cellH;
            self.lastBottomView = arrow;
            
            [_cellViewArr addObject:arrow];
            
        }else if ([cellDic[@"type"] integerValue]==CellPopLine) {
            
            CGFloat lineH =[cellDic[@"lineH"] doubleValue];
            UIView *bottomLine = [[UIView alloc]init];
            bottomLine.backgroundColor = grayF2F2F2;
            [_scroll addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.width.offset(kWindowW);
                make.height.offset(lineH);
                make.top.offset(orY);
            }];
            
            self.lastBottomView =bottomLine;
            
            orY+=lineH;
            
            //注意，lineView  并没有加入到_cellViewArr数组中;
            //[_cellViewArr addObject:arrow];
            
        }
        
    }
    
    return  _scroll;
}

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
            //生成新的cell
            YSJCommonSwitchView *newCell = [[YSJCommonSwitchView alloc]initWithFrame:frame withTitle:@"上门服务" selected:YES];
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:4];
            break;
        }
        i++;
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
            //生成新的cell
            YSJPopTextFiledView *newCell = [[YSJPopTextFiledView alloc]initWithFrame:frame withTitle:@"拼单人数" subTitle:@""];
            [_scrollView addSubview:newCell];
            //数组插入原先的位置
            [_cellViewArr insertObject:newCell atIndex:4];
            
            break;
        }
        i++;
    }
}

@end
