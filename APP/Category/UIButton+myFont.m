#import "UIButton+MyFont.h"

//不同设备的屏幕比例(当然倍数可以自己控制)
#define SizeScale ((kWindowH > 568) ? kWindowH/568 : 1)

@implementation UIButton (myFont)
//
+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.titleLabel.tag != 333){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}


@end

@implementation UILabel (myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
//            CGFloat fontSize = self.font.pointSize;
//            self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
            NSString *text = self.text;
            if (isEmptyString(text)) {
                self.text = @"";
            }
        }
    }
    return self;
}

@end
