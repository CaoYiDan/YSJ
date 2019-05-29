//
//  SPDyDetailBottomView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^toolClick)(NSInteger tag);

@interface SPDyDetailBottomView : UIView

-(void)setPrasizedCount:(NSInteger)prasizeNum evaluateNum:(NSInteger)evaluateNum ifPrasized:(BOOL)prasized;

- (instancetype)initWithFrame:(CGRect)frame withCode:(NSString *)code;
/***/
@property(nonatomic,copy)toolClick toolClick;

/**动态code*/
@property(nonatomic,copy)NSString*feedCode;

@end
