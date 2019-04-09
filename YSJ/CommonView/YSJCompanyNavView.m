//
//  SPNewHomeNavView.m


#import "YSJCompanyNavView.h"

#import "SPUpDownButton.h"

@implementation YSJCompanyNavView
{
    UIButton *_leftItem;
    UIButton * _careItem;
    SPUpDownButton *_shareItem;
    
    NSString *url;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _leftItem = [[UIButton alloc]init];
    _leftItem.tag =0;
    
    [_leftItem addTarget:self action:@selector(homeNavClick:) forControlEvents:UIControlEventTouchDown];
    _leftItem.titleLabel.font = font(16);
    [_leftItem setImage:[UIImage imageNamed:@"return"] forState:0];
    [self addSubview:_leftItem];
    [_leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
//        make.width.offset(60);
        make.height.offset(40);
        make.top.offset(SafeAreaStateHeight);
    }];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-100, SafeAreaStateHeight, 40, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:0];
    shareBtn.tag = 1;

    [shareBtn addTarget:self action:@selector(homeNavClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:shareBtn];
    
    
    UIButton *careBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-50, SafeAreaStateHeight, 40, 40)];
    [careBtn setImage:[UIImage imageNamed:@"guanzhu_1"] forState:UIControlStateSelected];
    [careBtn setImage:[UIImage imageNamed:@"guanzhu_0"] forState:0];
    careBtn.tag = 2;
    _careItem = careBtn;
    [careBtn addTarget:self action:@selector(homeNavClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:careBtn];
    
}

-(void)homeNavClick:(UIButton *)btn
{

    [self.delegate navViewSelectedBtn:btn];
}


-(void)setCare:(BOOL)care{
    _care = care;
    _careItem.selected = care;
}

- (void)setTittleHiden:(BOOL)tittleHiden{
    _tittleHiden = tittleHiden;
    if (tittleHiden) {
        [_leftItem setTitle:@"" forState:0];
    }else{
        [_leftItem setTitle:[NSString stringWithFormat:@"  %@",self.title] forState:0];
    }
}

-(void)setIsCare:(BOOL)isCare{
    _isCare = isCare;
//    url =
}
@end
