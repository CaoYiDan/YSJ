//
//  HomeCollectionViewCell.h
//  TimeMemory
//
//  Created by 李智帅 on 16/9/12.
//  Copyright © 2016年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface HomeCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIImageView * smallIV;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLab;


- (void)refreshUI:(HomeModel *)model withCode:(NSInteger)code;
@end
