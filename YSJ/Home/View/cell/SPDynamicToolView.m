//
//  SPHomeToolView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicToolView.h"
#import "SPDynamicDetialVC.h"
#import "SPHomeModel.h"
#import "SPCommon.h"
#import "SPKitExample.h"
@interface  SPDynamicToolView ()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *praisedBtn;
@property (nonatomic, weak) UIButton *careBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, copy) NSString *feedCode;//此动态发布人的code
@property (nonatomic, assign) BOOL praised;//是否被赞
@end

@implementation SPDynamicToolView

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
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加按钮
        self.praisedBtn = [self setupBtn:@"为Ta点赞" icon:@"sy_an_dz"];
        [self.praisedBtn setTitle:@"已点赞" forState:UIControlStateSelected];
        self.praisedBtn.tag = 1;
        
        self.careBtn = [self setupBtn:@"关注" icon:@"sy_an_gz"];
        [self.careBtn setTitle:@"已关注" forState:UIControlStateSelected];
        self.careBtn.tag = 2;
        
        self.commentBtn = [self setupBtn:@"邀请Ta" icon:@"sy_an_yq"];
        self.commentBtn.tag = 3;
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
//    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:icon] forState:0];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:0];
    [btn addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchDown];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.btns.count;
    CGFloat btnW = self.frameWidth / btnCount;
    CGFloat btnH = self.frameHeight;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.originY = 0;
        btn.frameWidth = btnW;
        btn.originX = i * btnW;
        btn.frameHeight = btnH;
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

-(void)setModel:(SPHomeModel*)model{
    _model = model;
    self.feedCode = self.model.code;

    // 是否点赞
    self.praisedBtn.selected = self.model.praised;
    //是否关注
    self.careBtn.selected = self.model.followed;
}

-(void)toolClick:(UIButton*)btn{
    
    if (btn.tag == 1) {//赞 点击
        [self praisedClick:btn];
    }else if (btn.tag == 2){//关注点击
        [self careClick:btn];
    }else{
        [self chatClick:btn];//沟通
    }
}

//关注
-(void)careClick:(UIButton *)btn{
    
    if (![SPCommon gotoLogin]) {
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        
        [dict setObject:[StorageUtil getCode] forKey:@"followerCode"];
        [dict setObject:self.model.code forKey:@"userCode"];
        
        NSString *url  = @"";
        if (btn.isSelected) {
            url = CancelFollowUrl;
        }else{
            url = FollowUrl;
        }
        [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            btn.selected = !btn.isSelected;

            self.model.followed = btn.selected;
            
            if (btn.isSelected) {
                //打招呼
                [[SPKitExample sharedInstance]sendMessageWithPersonId:self.model.code content:@"你好，很高兴认识你。"];
            }
           
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

//为他点赞
-(void)praisedClick:(UIButton *)btn{
    
    if (![SPCommon gotoLogin]) {
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        
        [dict setObject:self.model.code forKey:@"bePraisedCode"];
        [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
        [dict setObject:@"USER" forKey:@"type"];
        NSString *url  = @"";
        if (btn.isSelected) {
            url = kUrlDeletePraise;
        }else{
            url = kUrlAddPraise;
        }
        [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            btn.selected = !btn.isSelected;
            
            self.model.praised = btn.selected;
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}

-(void)chatClick:(UIButton *)btn{
    YWPerson *person = [[YWPerson alloc]initWithPersonId:self.model.code];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
}

@end
