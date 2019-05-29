/**
 * Cell
 * @author 郑业强 2019-01-15 创建文件
 */

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

// 设置点击颜色
- (void)setSelectBackgroundColor:(UIColor *)color {
    UIView *view_bg = [[UIView alloc] initWithFrame:self.frame];
    view_bg.backgroundColor = color;
    self.selectedBackgroundView = view_bg;
}


// 从代码创建cell
+ (instancetype)loadCode:(UITableView *)table {
    NSString *name = NSStringFromClass(self);
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:name];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell initUI];
    }
   
    return cell;
}


// 初始化
- (void)initUI {
    
}


@end
