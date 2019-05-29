//
//  SPHomeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/27.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPDynamicCell.h"
#import "SPProfileDynamicFrame.h"
#import "SPCommon.h"
#import "SPDynamicModel.h"
#import "SPDynamicFrame.h"
#import "SPDynamicToolView.h"
#import "SPProfileDynamicToolView.h"
#import "SPPhotosView.h"
#import "SPProfileVC.h"

@interface SPDynamicCell ()

/** 坐标 frame*/
@property (nonatomic, weak) SPDynamicFrame *homeFrame;
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

@property (nonatomic, strong) UIButton *age;

/** 距离 和活跃状态*/
@property (nonatomic, weak) UILabel *distanceAndlivesLabel;
/** 行业和年龄*/
@property (nonatomic, weak) UILabel *profileLabel;
/** 服务价格*/
@property (nonatomic, weak) UILabel *priceLabel;
/** 点赞*/
@property (nonatomic, weak)UIButton *prasie;
/** 阅读*/
@property (nonatomic, weak)UIButton *read;
/** 评价*/
@property (nonatomic, weak)UIButton *comment;
//认证图标
@property(nonatomic,strong)UIView *authenticationView;
@property(nonatomic,strong)UIButton *authentication1;
@property(nonatomic,strong)UIButton *authentication2;
@property(nonatomic,strong)UIButton *authentication3;
/** 工具条 */
@property (nonatomic, strong) UIView *toolbar;
/** 工具条 （在个人动态中的Tool） */
@property (nonatomic, strong) UIView *toolbarForProfileDynamic;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *answerBtn;

@end

@implementation SPDynamicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    SPDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:SPDynamicCellID];
    if (cell==nil) {
        cell = [[SPDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPDynamicCellID];
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
    profileLabel.textColor  = BasePrinkColor;
    profileLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:profileLabel];
    self.profileLabel = profileLabel;
    
    /** 服务价格 */
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = Font(15);
    priceLabel.textColor  = [UIColor lightGrayColor];
    priceLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //认证 暂时不添加
//    self.authenticationView = [[UIView alloc]init];
//    self.authenticationView.backgroundColor = [UIColor whiteColor];
////    [self.contentView addSubview:self.authenticationView];
//
//    //认证1
//    self.authentication1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_sjw"] forState:0];
//    [self.authentication1 setImage:[UIImage imageNamed:@"sy_icon_sj"] forState:UIControlStateSelected];
//    [self.authenticationView addSubview:self.authentication1];
//
//    //认证2
//    self.authentication2 = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 20, 20)];
//    [self.authentication2 setImage:[UIImage imageNamed:@"sy_icon_smw"] forState:0];
//    [self.authentication2 setImage:[UIImage imageNamed:@"sy_icon_sm"] forState:UIControlStateSelected];
//    [self.authenticationView addSubview:self.authentication2];
//
//    //认证3
//    self.authentication3 = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 20, 20)];
//    [self.authentication3 setImage:[UIImage imageNamed:@"sy_icon_jnw"] forState:0];
//    [self.authentication3 setImage:[UIImage imageNamed:@"sy_icon_jn"] forState:UIControlStateSelected];
//    [self.authenticationView addSubview:self.authentication3];
    
     /**工具栏*/
    self.toolbar = [[UIView alloc]init];
    self.toolbar.backgroundColor = WC;
    [self.contentView addSubview:self.toolbar];
    
    UIButton *read = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 0, 60, 50)];
    read.backgroundColor = [UIColor whiteColor];
    [read setImage:[UIImage imageNamed:@""] forState:0];
    [read setTitle:@"23" forState:0];
    [read setTitleColor:[UIColor grayColor] forState:0];
    read.titleLabel.font = font(13);
    self.read = read;
    [self.toolbar addSubview:read];
    
    UIButton *prasie = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-kMargin-130, 0, 60, 50)];
    prasie.backgroundColor = [UIColor whiteColor];
    [prasie setImage:[UIImage imageNamed:@"fx_dz_"] forState:0];
    [prasie setImage:[UIImage imageNamed:@"fx_dzcg_"] forState:UIControlStateSelected];
    [prasie setTitle:@"23" forState:0];
    prasie.titleLabel.font = font(13);
    self.prasie = prasie;
    [prasie setTitleColor:[UIColor grayColor] forState:0];
    [prasie addTarget:self action:@selector(praise:) forControlEvents:UIControlEventTouchDown];
    [self.toolbar addSubview:prasie];
    
    UIButton *comment = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-kMargin-70, 0, 60, 50)];
    comment.backgroundColor = [UIColor whiteColor];
    [comment setImage:[UIImage imageNamed:@"fx_pl_"] forState:0];
    comment.titleLabel.font = font(13);
    self.comment = comment;
    comment.userInteractionEnabled = NO;
    [comment setTitleColor:[UIColor grayColor] forState:0];
    [self.toolbar addSubview:comment];
    
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

-(void)setStatusFrame:(SPDynamicFrame *)statusFrame{
    _statusFrame = statusFrame;
    _statue = statusFrame.status;
    
    //上部分baseView
    _topView.frame = statusFrame.topViewF;
    
    //图片
    _photosView.frame = statusFrame.photosViewF;
    [_photosView setImgArr:statusFrame.status.imgs];
    
    //正文
    _contentLabel.frame = statusFrame.contentLabelF;
    _contentLabel.text = statusFrame.status.text;
    
    //头像
    _iconImg.frame = statusFrame.iconViewF;
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:statusFrame.status.promulgatorAvatar]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];

    //昵称
    _nameLabel.frame = statusFrame.nameLabelF;
    _nameLabel.text = statusFrame.status.promulgatorName;
    
    
    
    //距离和活跃状态
    _distanceAndlivesLabel.frame= statusFrame.distanceAndlivesLabelF;
    NSLog(@"%@",statusFrame.status.distance);
    _distanceAndlivesLabel.text = [NSString stringWithFormat:@"%@  %@",statusFrame.status.locationValue,statusFrame.status.time];
    //locationValue
    NSLog(@"%@",_distanceAndlivesLabel.text);
    
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
    
    
    
    //工具栏
    _toolbar .frame = statusFrame.toolbarF;
    [self.read setTitle:[NSString stringWithFormat:@"阅读 %d",statusFrame.status.readNum] forState:0];
    ;
    
    [self.prasie setTitle:[NSString stringWithFormat:@"%d",statusFrame.status.praiseNum] forState:0];
    self.prasie.selected = statusFrame.status.praised;
    
    [self.comment setTitle:[NSString stringWithFormat:@"%d",statusFrame.status.commentNum] forState:0];
    
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

-(void)setFrameAndContentWith:(SPDynamicModel *)model{


}

-(void)prepareForReuse{
    [super prepareForReuse];
    //将图片view上的图片移除，不然错乱
    for (UIView *vi in self.photosView.subviews) {
        [vi removeFromSuperview];
    }
    
}

-(void)iconTap{
    //没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code = self.statue.promulgator;
    vc.titleName = self.statue.promulgatorName;
    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}

-(void)setCellType:(DynamicCellType)cellType{
    _cellType = cellType;
    if ( cellType == DynamicCellTypeForHome) {
        
    }else if(cellType == DynamicCellTypeForProfile){
        
    }
}

//点赞
-(void)praise:(UIButton *)btn{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:self.statusFrame.status.code forKey:@"bePraisedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
    [dict setObject:@"FEED" forKey:@"type"];
    NSString *url  = @"";
    if (btn.isSelected) {
        url = kUrlDeletePraise;
    }else{
        url = kUrlAddPraise;
    }
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        btn.selected = !btn.isSelected;
        
        self.statusFrame.status.praised = btn.selected;
//
        if (btn.selected) {
            self.statusFrame.status.praiseNum+=1;
        }else{
            self.statusFrame.status.praiseNum-=1;
        }
        [self.prasie setTitle:[NSString stringWithFormat:@"%d",self.statusFrame.status.praiseNum] forState:0];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
