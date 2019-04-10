//
//  SPHomeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLeaseCell.h"
#import "SPProfileDynamicFrame.h"
#import "SPCommon.h"
#import "SPAuthenticationView.h"
#import "SPHomeModel.h"
#import "SPLeaseModel.h"
#import "SPNewHomeCellFrame.h"
#import "SPDynamicToolView.h"
#import "SPProfileDynamicToolView.h"
@interface SPLeaseCell ()

/** 坐标 frame*/
@property (nonatomic, weak) SPNewHomeCellFrame *homeFrame;
/**  topVIew */
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *textView;

/** 正文 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 年龄 */
@property (nonatomic, strong) UIButton *age;

/** 距离 活跃状态 */
@property (nonatomic, strong) UIButton *locationAndLivenes;

/** 应邀类型 和预付类型*/
@property (nonatomic, weak) UILabel *leaseAndPayType;
/** 服务价格*/
@property (nonatomic, weak) UILabel *priceLabel;
//认证图标
//认证
@property(nonatomic,strong)SPAuthenticationView *authenticationView;

/** 工具条 */
@property (nonatomic, strong)UIView *toolView;
/** 工具条 （在个人动态中的Tool） */
@property (nonatomic, strong) SPProfileDynamicToolView *toolbarForProfileDynamic;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *answerBtn;

@end

@implementation SPLeaseCell
{
    NSDictionary *_toolDic;
    UIButton *_firstBtn;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    SPLeaseCell *cell = [tableView dequeueReusableCellWithIdentifier:SPLeaseCellID];
    if (cell==nil) {
        cell = [[SPLeaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPLeaseCellID];
        //        cell.clipsToBounds = YES;
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setupOriginal];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupOriginal
{
    _toolDic = @{@"应邀广场":@[@"应邀接单",@"邀请好友来接单"],@"我的应邀":@[@"沟通",@"分享"],@"我的成交":@[@"评价",@"分享"]};
    
    [self sTop];
    [self sMiddle];
    [self setBottom];
}

-(void)sTop{
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 10, 42, 42)];
    iconView.backgroundColor = BASEGRAYCOLOR;
    iconView.layer.cornerRadius  = 21;
    iconView.clipsToBounds = YES;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.userInteractionEnabled = YES;
    [self.contentView addSubview:iconView];
    self.iconImg = iconView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    tap.numberOfTapsRequired = 1;
    [iconView addGestureRecognizer:tap];
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin +52, 11, 150, 20)];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = kFontNormal_14;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //认证
    self.authenticationView = [[SPAuthenticationView alloc]initWithFrame:CGRectMake(SCREEN_W-90, 10, 80, 20)];
    self.authenticationView.type = 3;
    self.authenticationView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.authenticationView];
    
    /** 年龄 */
    _age = [[UIButton alloc]initWithFrame:CGRectMake(kMargin +52, 31, 50, 20)];
    _age.backgroundColor = RGBCOLOR(199, 226, 253);
    _age.layer.cornerRadius = 4;
    _age.clipsToBounds = YES;
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_n"] forState:UIControlStateSelected];
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_nv"] forState:0];
    _age.titleLabel.font = font(12);
    [self addSubview:_age];
    
    //距离 和 活跃状态
    _locationAndLivenes = [[UIButton alloc]init];
    _locationAndLivenes.backgroundColor = [UIColor whiteColor];
    [_locationAndLivenes setTitleColor:[UIColor grayColor] forState:0];
    [_locationAndLivenes setImage:[UIImage imageNamed:@"sy_gr_dw_"] forState:0];
    _locationAndLivenes.titleLabel.font = font(13);
    
    [self.contentView addSubview:_locationAndLivenes];
    [_locationAndLivenes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_age.mas_right).offset(5);
        make.height.offset(20);
        make.top.equalTo(_age);
    }];
    
    /**状态*/
    UILabel *leaseAndPayType = [[UILabel alloc] init];
    leaseAndPayType.backgroundColor = [UIColor whiteColor];
    leaseAndPayType.font = kFontNormal;
    leaseAndPayType.textColor =[UIColor lightGrayColor];
    leaseAndPayType.textAlignment = NSTextAlignmentRight;
    leaseAndPayType.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:leaseAndPayType];
    self.leaseAndPayType = leaseAndPayType;
    
    if (kiPhone5)
    {
        leaseAndPayType.textAlignment = NSTextAlignmentCenter;
        [leaseAndPayType mas_makeConstraints:^(MASConstraintMaker *make) {
            //    make.left.equalTo(_locationAndLivenes.mas_right).offset(4);
            make.height.offset(20);
            make.top.equalTo(_authenticationView);
            make.right.equalTo(_authenticationView.mas_left).offset(16);
            
        }];
       
        //            make.left.equalTo(_nameLabel.mas_right).offset(4);
    }else
    {
        [leaseAndPayType mas_makeConstraints:^(MASConstraintMaker *make) {
            //    make.left.equalTo(_locationAndLivenes.mas_right).offset(4);
            make.height.offset(20);
            make.top.equalTo(_age);
            make.right.offset(-10);
        }];
    }
    
//    /* 应邀类型 和预付类型*/
//    UILabel *leaseAndPayType = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_W-750, 35,70, 20)];
//    leaseAndPayType.font = Font(13);
//    leaseAndPayType.textAlignment = NSTextAlignmentRight;
//    leaseAndPayType.textColor  = [UIColor lightGrayColor];
//    leaseAndPayType.backgroundColor = [UIColor clearColor];
//    [self.contentView addSubview:leaseAndPayType];
//    self.leaseAndPayType = leaseAndPayType;
    
}

-(void)sMiddle{
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kFontNormal;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

-(void)setBottom{
    /**工具栏*/
   
    [self.contentView addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(-1);
        make.right.offset(1);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.offset(55);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(5);
    }];
}

-(UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc]init];
        _toolView.backgroundColor = [UIColor whiteColor];
        _toolView.layer.borderWidth =1;
        _toolView.layer.borderColor = HomeBaseColor.CGColor;

        UIButton *care = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2-110, 10, 100, 35)];
        _firstBtn = care;
        [care setBackgroundColor:[UIColor redColor]];
        care.layer.cornerRadius = 17.5;
        care.clipsToBounds = YES;
        [care addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchDown];
        care.titleLabel.font = font(13);
        [_toolView addSubview:care];
        
        UIButton *invite = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W/2+10, 10, 100, 35)];
       
        invite.layer.cornerRadius =17.5;
        invite.clipsToBounds = YES;
        [invite setTitle:@"dsds" forState:0];
        invite.layer.borderColor = [UIColor redColor].CGColor;
        invite.layer.borderWidth =1.0;
        [invite setTitleColor:[UIColor redColor] forState:0];
        [invite addTarget:self action:@selector(toolClick:) forControlEvents:UIControlEventTouchDown];
        invite.titleLabel.font = font(13);
        [_toolView addSubview:invite];

    }
    return _toolView;
}

#pragma  mark - -----------------底部功能按钮点击-----------------

-(void)toolClick:(UIButton *)btn
{
    [self.delegate SPLeaseCellSelectedIndex:self.indexRow andType:btn.titleLabel.text];
}

-(void)setLeaseM:(SPLeaseModel *)leaseM
{
    _leaseM = leaseM;
    _contentLabel.frame = CGRectMake(kMargin, 70, SCREEN_W-2*kMargin, leaseM.contentH);
    _contentLabel.text = [NSString stringWithFormat:@"需求技能：%@\n\n需求描述：%@",leaseM.propertyName,leaseM.content];
    
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:leaseM.userPic]];
    
    _nameLabel.text = leaseM.userName;
    
    //认证
    [self.authenticationView setA0:NO A1:![leaseM.bailFee isEqualToString:@"0"]  set2:YES set3:[leaseM.identityStatus isEqualToString:CERTIFIED]];
    
    //性别和年龄
    [_age setTitle:[NSString stringWithFormat:@"%@岁",leaseM.userAge] forState:0];
    _age.selected = leaseM.gender;
    //如果是女的，背景色改为粉红色
    if (!leaseM.gender)
    {
        _age.backgroundColor = RGBCOLOR(255, 203, 215);
    }else
    {
        _age.backgroundColor = RGBCOLOR(199, 226, 253);
    }
    
    [_locationAndLivenes setTitle:[NSString stringWithFormat:@"%@  %@",leaseM.distance,leaseM.activeFlag] forState:0];
    NSLog(@"%d",leaseM.flushFlag);
    
    _leaseAndPayType.text = [NSString stringWithFormat:@"%@ %@",!leaseM.flushFlag?@"闪约":@"",[leaseM.bailFee isEqualToString:@"0"]||isEmptyString(leaseM.bailFee)?@"无诚意金":[NSString stringWithFormat:@"诚意金%@元",leaseM.bailFee]];
    
    if ([self.leaseType isEqualToString:@"应邀广场"])
    {
        if (leaseM.orderFlag)
        {
             [_firstBtn setTitle:@"已接单" forState:0];
        }else
        {
             [_firstBtn setTitle:@"应邀接单" forState:0];
        }
    }
}

-(void)iconTap{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
//    SPProfileVC *vc = [[SPProfileVC alloc]init];
//    //    vc.code = self.statue.promulgator;
//    //    vc.titleName = self.statue.promulgatorName;
//    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

-(void)setLeaseType:(NSString *)leaseType{
    _leaseType = leaseType;
    int i=0;
    for (UIButton *toolBtn in self.toolView.subviews) {
        [toolBtn setTitle:_toolDic[leaseType][i] forState:0];
        i++;
    }
}

@end

