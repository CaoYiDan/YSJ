//
//  SPIfSendPriceAndgoodnessTipView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/11/23.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^sendPriceAndgoodnessTipViewComplment)(BOOL beSure,NSString *price,NSString *goodness);

@interface SPIfSendPriceAndgoodnessTipView : UIView<UITextFieldDelegate>

/***/
@property(nonatomic,copy)sendPriceAndgoodnessTipViewComplment complmentBlock;

-(instancetype)initWithPrice:(NSString *)price priceUnit:(NSString *)priceUnit goodnessText:(NSString *)goodness frame:(CGRect)frame complment:(sendPriceAndgoodnessTipViewComplment)complment;
@end
