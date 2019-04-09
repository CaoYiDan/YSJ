//
//  SPHomeToolView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPProfileDynamicToolView.h"
#import "SPDynamicDetialVC.h"
#import "SPDynamicModel.h"
#import "SPCommon.h"
@interface  SPProfileDynamicToolView ()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *distanceBtn;
@property (nonatomic, weak) UIButton *readBtn;
@property (nonatomic, weak) UIButton *praisedBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, copy) NSString *feedCode;//此动态发布人的code
@property (nonatomic, assign) BOOL praised;//是否被赞
@end

@implementation SPProfileDynamicToolView

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolbar
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        // 添加按钮
        
        self.praisedBtn = [self setupBtn:@"" icon:@"xxwdz"];
        self.praisedBtn.tag = 2;
        [self.praisedBtn setImage:[UIImage imageNamed:@"xxdz"] forState:UIControlStateSelected];
        
        self.commentBtn = [self setupBtn:@"" icon:@"xx"];
        self.commentBtn.tag = 3;
        
        self.readBtn = [self setupBtn:@"" icon:@"read"];
        self.readBtn.tag = 1;
        
        self.distanceBtn = [self setupBtn:@"" icon:@"distanc"];
        self.distanceBtn.tag = 4;
    }
    return self;
}

/**
 * 初始化一个按钮
 * @param title : 按钮文字
 * @param icon : 按钮图标
 */
- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchDown];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.frameWidth /6;
    CGFloat btnH = self.frameHeight;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        if (i==3) {
            btn.frame = CGRectMake(10, 0, btnW, btnH);
        }else{
        btn.originY = 0;
        btn.frameWidth = btnW;
        btn.originX = i * btnW+SCREEN_W/2;
        btn.frameHeight = btnH;
        }
        
    }
    
    // 设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.frameWidth = 1;
        divider.frameHeight = btnH;
        divider.originX = (i + 1) * btnW;
        divider.originY = 0;
    }
}

-(void)setModel:(SPDynamicModel *)model{
    _model = model;
    NSLog(@"%@",model.locationValue);
    [self.distanceBtn setTitle:model.locationValue forState:0];
    [self setReadNum:model.readNum praiseNum:model.praiseNum commentNum:model.commentNum andfeedCode:model.code ifPraised:model.praised];
}

-(void)setReadNum:(NSInteger)readNum praiseNum:(NSInteger)praiseNum commentNum:(NSInteger)commentNum andfeedCode:(NSString *)feedCode ifPraised:(BOOL)praised{
    
    [self.readBtn setTitle:[NSString stringWithFormat:@"%ld",(long)readNum] forState:0];
    [self.praisedBtn setTitle:[NSString stringWithFormat:@"%ld",(long)praiseNum] forState:0];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)commentNum] forState:0];
    self.feedCode = feedCode;
    //是否点赞
    self.praisedBtn.selected = praised;
    
}

-(void)toolClick:(UIButton*)btn{
    
    if (btn.tag == 2) {//赞 点击
        [self praisedClick:btn];
    }else if (btn.tag == 3){//评论点击
        [self evaluatedClick:btn];
    }
}

-(void)praisedClick:(UIButton *)btn{
    
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    //已经登录
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:@"FEED" forKey:@"type"];
    [dict setObject:self.feedCode forKey:@"bePraisedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
    NSString *url  = @"";
    if (btn.isSelected) {
        url = kUrlDeletePraise;
    }else{
        url = kUrlAddPraise;
    }
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        btn.selected = !btn.isSelected;
        if (btn.isSelected) {
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]+1] forState:0];
            self.model.praised = YES;
            self.model.praiseNum += 1;
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]-1] forState:0];
            self.model.praised = NO;
            self.model.praiseNum -= 1;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)evaluatedClick:(UIButton *)btn{
    SPDynamicDetialVC *vc = [[SPDynamicDetialVC alloc]init];
    vc.model = self.model;
    vc.directEvaluate = YES;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

@end
