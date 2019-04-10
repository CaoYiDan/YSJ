//
//  UILabel+SPText.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/11.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "UILabel+SPText.h"

@implementation UILabel (SPText)

static const char MyTextKey = '\0';

-(void)setMyText:(NSString *)myText{
    objc_setAssociatedObject(self, &MyTextKey,
                             myText, OBJC_ASSOCIATION_ASSIGN);
    
    if (isEmptyString(myText) || [myText isEqualToString:@"(null) | (null)"]) {
        myText = @"-------";
    }
    self.text = myText;
}

-(NSString *)myText{
  return objc_getAssociatedObject(self, &MyTextKey);
}
@end
