//
//  SPMyProflieHeader.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/19.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPUser;

typedef void(^ProflieHeaderBlock) (NSInteger tag);

@interface SPMyProflieHeader : UIView 
/***/
@property(nonatomic,copy) ProflieHeaderBlock proflieHeaderBLock;
/**<#Name#>*/
@property (nonatomic, strong)SPUser *user;
@end
