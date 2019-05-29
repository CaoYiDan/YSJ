//
//  SPSearchView.h
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^searchViewBlock) (NSString *searchText);
@interface SPSearchView : UIView
/**<##>block*/
@property(nonatomic,copy)searchViewBlock searchViewBlock;

-(void)textFieldBecomeFirstResponse;

-(void)setSearchText:(NSString *)searchText;
@end
