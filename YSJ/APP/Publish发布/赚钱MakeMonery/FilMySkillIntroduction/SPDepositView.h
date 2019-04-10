//
//  SPDepositView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^choseResult) (NSString *type,NSString *deposit);
@interface SPDepositView : UIView
/**<##>block*/
@property(nonatomic,copy)choseResult block;
/**高度*/
@property(nonatomic,assign)CGFloat  totalH;
/**金额类型*/
@property(nonatomic,copy)NSString *feeType;

-(void)getMyWall;

-(CGFloat)getHeight;

- (instancetype)initWithFeeType:(NSString *)feeType;


@end
