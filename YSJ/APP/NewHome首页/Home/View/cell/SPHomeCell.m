//
//  SPHomeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPHomeCell.h"
#import "SPProfileDynamicFrame.h"
#import "SPCommon.h"
#import "SPAuthenticationView.h"
#import "SPHomeModel.h"
#import "SPNewHomeCellFrame.h"
#import "SPDynamicToolView.h"
#import "SPProfileDynamicToolView.h"
#import "SPPhotosView.h"
#import "SPProfileVC.h"

@interface SPHomeCell ()

/** 坐标 frame*/
@property (nonatomic, weak) SPNewHomeCellFrame *homeFrame;
/** 图片 View */
@property (nonatomic, strong) UIView *topView;
/** 图片 View */
@property (nonatomic, strong) SPPhotosView *photosView;

@property (nonatomic, strong) UIView *textView;

/** 正文 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
//性别和年龄
@property (nonatomic, strong)UIButton *age;
/** 距离 和活跃状态*/
@property (nonatomic, weak) UILabel *distanceAndlivesLabel;
/** 行业和年龄*/
@property (nonatomic, weak) UILabel *profileLabel;
/** 服务价格*/
@property (nonatomic, weak) UILabel *priceLabel;
//认证
@property(nonatomic,strong)SPAuthenticationView *authenticationView;
/** 工具条 */
@property (nonatomic, strong) SPDynamicToolView *toolbar;
/** 工具条 （在个人动态中的Tool） */
@property (nonatomic, strong) SPProfileDynamicToolView *toolbarForProfileDynamic;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *answerBtn;

@end

@implementation SPHomeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    SPHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:SPHomeCellID];
    if (cell==nil) {
        cell = [[SPHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPHomeCellID];
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
    [self sTop];
    [self sBottom];
}

-(void)sTop{
    
    /** topView */
    
    UIView *topView = [[UIView alloc]init];
    [self.contentView addSubview:topView];
    
    self.topView = topView;
    self.topView.backgroundColor = [UIColor whiteColor];
    
    /**图片View */
    [topView addSubview:self.photosView];
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kFontNormal_14;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor whiteColor];
    [topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

-(void)sBottom{
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
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
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = kFontNormal_14;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    _age = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 10, 50, 20)];
    _age.backgroundColor = RGBCOLOR(199, 226, 253);
    _age.layer.cornerRadius = 4;
    _age.clipsToBounds = YES;
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_n"] forState:UIControlStateSelected];
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_nv"] forState:UIControlStateNormal];
    _age.titleLabel.font = font(12);
    [self addSubview:_age];
    
    
    /** 距离  和 活跃状态*/
    UILabel *distanceAndlivesLabel = [[UILabel alloc] init];
    distanceAndlivesLabel.font = Font(12);
    distanceAndlivesLabel.numberOfLines = 2;
    distanceAndlivesLabel.textColor  = [UIColor lightGrayColor];
    distanceAndlivesLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:distanceAndlivesLabel];
    self.distanceAndlivesLabel = distanceAndlivesLabel;
    
    /** 服务行业 和 年龄*/
    UILabel *profileLabel = [[UILabel alloc] init];
    profileLabel.font = Font(15);
    profileLabel.textColor  = RGBCOLOR(255, 42, 102);
    profileLabel.backgroundColor = [UIColor whiteColor];
    profileLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:profileLabel];
    self.profileLabel = profileLabel;
    
    /** 服务价格 */
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = Font(14);
    priceLabel.textColor  = RGBCOLOR(255, 42, 102);
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //认证
    SPAuthenticationView *authenticationView  = [[SPAuthenticationView alloc]init];
    self.authenticationView = authenticationView;
    [self.contentView addSubview:authenticationView];
    
    /**工具栏*/
    self.toolbar = [SPDynamicToolView toolbar];
    [self.contentView addSubview:self.toolbar];
    
    self.toolbarForProfileDynamic = [SPProfileDynamicToolView toolbar];
    [self.contentView addSubview:self.toolbarForProfileDynamic];
}

-(SPPhotosView *)photosView{
    if (!_photosView) {
        _photosView = [[SPPhotosView alloc] init];
        _photosView.backgroundColor = [UIColor whiteColor];
    }
    return _photosView;
}

-(void)setStatusFrame:(SPNewHomeCellFrame *)statusFrame{
    _statusFrame = statusFrame;
    _statue = statusFrame.status;
    
    //上部分baseView
    _topView.frame = statusFrame.topViewF;
    
    //图片
    _photosView.frame = statusFrame.photosViewF;
    [_photosView setImgArr:statusFrame.status.skillImgList];
    
    //正文
    _contentLabel.frame = statusFrame.contentLabelF;
    _contentLabel.text = statusFrame.status.serIntro;
    
    //头像
    _iconImg.frame = statusFrame.iconViewF;
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:statusFrame.status.avatar]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
    
    //昵称
    _nameLabel.frame = statusFrame.nameLabelF;
    _nameLabel.text = statusFrame.status.nickName;
    
    //距离和活跃状态
    _distanceAndlivesLabel.frame= statusFrame.distanceAndlivesLabelF;
    _distanceAndlivesLabel.text = [NSString stringWithFormat:@"%@  %@",statusFrame.status.distance,statusFrame.status.livenessStatus];
    
    //性别和年龄
    _age.frame = CGRectMake(_nameLabel.originX,_distanceAndlivesLabel.originY,50,_distanceAndlivesLabel.frameHeight);
    [_age setTitle:[NSString stringWithFormat:@"%d岁",statusFrame.status.age] forState:0];
    _age.selected = statusFrame.status.gender;
    //如果是女的，背景色改为粉红色
    if (!statusFrame.status.gender) {
        _age.backgroundColor = RGBCOLOR(255, 203, 215);
    }else{
        _age.backgroundColor = RGBCOLOR(199, 226, 253);
    }
    
    _profileLabel.frame = statusFrame.profileF;
    _profileLabel.text = statusFrame.status.skill;
    
    //服务价格
    _priceLabel.frame = statusFrame.priceF;
    _priceLabel.text = [NSString stringWithFormat:@"服务价格  %@",statusFrame.status.serPrice];
    [_priceLabel setAttributeTextWithString:_priceLabel.text range:NSMakeRange(0, 5) WithColour:[UIColor lightGrayColor]];
    
    //认证View
    _authenticationView.frame = statusFrame.authenticationF;
    
    [_authenticationView setA0:NO A1:[statusFrame.status.bailFee doubleValue]>0 set2:YES set3:[statusFrame.status.identityStatus isEqualToString:CERTIFIED]];
    //工具栏
    _toolbar .frame = statusFrame.toolbarF;
    [_toolbar setModel:statusFrame.status];
    
    //分割线
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W-20, 0.6));
        make.bottom.equalTo(self).offset(0);
        make.left.offset(10);
    }];
}

//个人动态赋值
//-(void)setProfileStatusFrame:(SPProfileDynamicFrame *)profileStatusFrame{
//    _profileStatusFrame = profileStatusFrame;
//    _statue = profileStatusFrame.status;

//    //上部分baseView
//    _topView.frame = profileStatusFrame.topViewF;

//    //图片
//    _photosView.frame = profileStatusFrame.photosViewF;
//    [_photosView setImgArr:profileStatusFrame.status.imgs];

//    //正文
//    _contentLabel.frame = profileStatusFrame.contentLabelF;
//    _contentLabel.text = profileStatusFrame.status.text;

//    //头像
//    _iconImg.frame = profileStatusFrame.iconViewF;
//    if (profileStatusFrame.status.promulgatorAvatar) {
//        [_iconImg sd_setImageWithURL:[NSURL URLWithString:profileStatusFrame.status.promulgatorAvatar]];
//    }

//    //昵称
//    _nameLabel.frame = profileStatusFrame.nameLabelF;
//    _nameLabel.backgroundColor = [UIColor whiteColor];
//    _nameLabel.text = profileStatusFrame.status.promulgatorName;

//    //发布时间 和地点
//    _timeAndAreaLabel.frame = profileStatusFrame.timeAndAreaLabelF;
//    _timeAndAreaLabel.backgroundColor = [UIColor whiteColor];
//    _timeAndAreaLabel.textAlignment = NSTextAlignmentRight;
//    _timeAndAreaLabel.text = profileStatusFrame.status.time;

////    _authenticationView.frame =

//    //工具栏
//    _toolbarForProfileDynamic .frame = profileStatusFrame.toolbarF;
//    [_toolbar setModel:profileStatusFrame.status];
//}

-(void)setFrameAndContentWith:(SPDynamicModel *)model
{
    
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    //将图片view上的图片移除，不然错乱
    for (UIView *vi in self.photosView.subviews)
    {
        [vi removeFromSuperview];
    }
}

-(void)iconTap{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
        vc.code = self.statusFrame.status.code;
        vc.titleName = self.statusFrame.status.nickName;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

-(void)setCellType:(DynamicCellType)cellType{
    _cellType = cellType;
    if ( cellType == DynamicCellTypeForHome) {
        
    }else if(cellType == DynamicCellTypeForProfile){
        
    }
}
@end

