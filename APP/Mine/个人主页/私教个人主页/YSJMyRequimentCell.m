#import "YSJRequimentModel.h"
#import "YSJMyRequimentCell.h"

@implementation YSJMyRequimentCell
{
    UILabel *_name;
    UILabel *_introduction;
    UILabel *_price;
}

- (void)initUI{
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 17,200, 20)];
    _name.font = Font(15);
    _name.textColor = KBlack333333;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 45, 300, 20)];
    _introduction.font = font(11);
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(kWindowW-112-24, 45, 100, 20)];
    _price.font = font(18);
    _price.textColor = yellowEE9900;
    _price.backgroundColor = [UIColor whiteColor];
    _price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_price];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

- (void)setModel:(YSJRequimentModel *)model{
    
    _model = model;
    
    _name.text = model.title;
    
    _introduction.text = [NSString stringWithFormat:@"%@ | %@ ",model.coursetype,model.coursetypes];
    
   _price.text = [NSString stringWithFormat:@"¥%@-¥%@ ",model.lowprice,model.highprice];

}

@end
