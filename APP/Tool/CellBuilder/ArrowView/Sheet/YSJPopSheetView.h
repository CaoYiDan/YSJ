//
//  YSJPopSheetView.h
//  SmallPig
//
//  Created by xujf on 2019/4/19.
//  Copyright © 2019年 lisen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSJPopProtocol.h"
#import "YSJPopViewProtocol.h"
#import "YSJLSBaseCommonCellView.h"

@interface YSJPopSheetView : YSJLSBaseCommonCellView <YSJPopProtocol>


@property (nonatomic,strong) NSArray *sheetTextArr;


@end
