//
//  SPProfileVC.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/25.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LS_SwitchVC.h"

typedef void(^myBack) (NSString *type);

@interface SPProfileVC : LS_SwitchVC
/**<##>coreId*/
@property(nonatomic,copy)NSString*code;

/**<##>导航栏标题*/
@property(nonatomic,copy)NSString *titleName;

/**是否关注*/
@property(nonatomic,assign)BOOL care;

/*点赞 关注 回传更新列表<##>*/
@property(nonatomic,copy)myBack block;

/**分享图片Image*/
@property (nonatomic, strong)UIImage *shareImg;
@end
