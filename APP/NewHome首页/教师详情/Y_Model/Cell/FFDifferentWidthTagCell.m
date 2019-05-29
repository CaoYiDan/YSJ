//
//  FFDifferentWidthTagCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/17.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFDifferentWidthTagCell.h"

//model
#import "FFDifferentWidthTagModel.h"

@interface FFDifferentWidthTagCell()

/** label的数组 */
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArrM;

/** 颜色的数组 */
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArrM;

@end

@implementation FFDifferentWidthTagCell

/***********************************set方法***********************************/
#pragma mark - set方法

- (void)setTagModel:(FFDifferentWidthTagModel *)tagModel {
    
    if (tagModel == _tagModel || tagModel == nil) {
        return;
    }
    
    _tagModel = tagModel;
    
    //移除所有标签label
    for (UILabel *label in self.labelArrM) {
        [label removeFromSuperview];
    }
    
    self.labelArrM = nil;
    
    
    //创建label
    for (int i = 0; i < tagModel.tagsArrM.count; i++) {
        NSValue *frameValue = tagModel.tagsLabelFramesM[i];
        CGRect frame = [frameValue CGRectValue];
        NSString *title = tagModel.tagsArrM[i];
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hexColor:@"E8541E"];
        label.font = Font(13);
        label.frame = frame;
        label.layer.cornerRadius = frame.size.height * 0.5;
        label.clipsToBounds = YES;
        label.text = title;
        
        label.backgroundColor = RGBA(253, 135, 197, 0.08);
        [self addSubview:label];
        [self.labelArrM addObject:label];
    }
}

/***********************************懒加载***********************************/
#pragma mark - 懒加载
- (NSMutableArray<UILabel *> *)labelArrM {
    if (_labelArrM == nil) {
        _labelArrM = [NSMutableArray array];
    }
    return _labelArrM;
}



@end
