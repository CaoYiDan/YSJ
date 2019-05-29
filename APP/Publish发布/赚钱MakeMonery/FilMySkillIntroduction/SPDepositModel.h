//
//  SPDepositModel.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 2018/1/11.
//  Copyright © 2018年 李智帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDepositModel : NSObject

/**<##>*/
@property(nonatomic,copy)NSString *prompt;
/**<##>*/
@property(nonatomic,copy)NSString *bailFee;
/**<##>*/
@property(nonatomic,copy)NSString *bailId;
/**<##>*/
@property(nonatomic,copy)NSString *note;
/**<##>*/
@property(nonatomic,assign)BOOL selected;
@end
