//
//  SPHomeCell.m
//  SmallPig


#import "YSJHomeWorkCell.h"
#import "XHStarRateView.h"
#import "YSJCommentFrameModel.h"
#import "SPCommon.h"
#import "YSJCommentsModel.h"
#import "SPDynamicFrame.h"
#import "SPDynamicToolView.h"
#import "SPProfileDynamicToolView.h"
#import "SPPhotosView.h"
#import "SPProfileVC.h"

@interface YSJHomeWorkCell ()

@property (nonatomic, strong) UIView *topView;
/** 图片 View */
@property (nonatomic, strong) SPPhotosView *photosView;

/** 正文 */
@property (nonatomic, strong) UILabel *contentLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconImg;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
//标签
@property (nonatomic, weak) XHStarRateView*startView;
/** 时间*/
@property (nonatomic, weak) UILabel *timeLab;
//标签
@property (nonatomic, weak)UIButton *taglab;
@end

@implementation YSJHomeWorkCell

- (void)initUI
{
    [self sBottom];
    [self sTop];
    
}

-(void)sTop{
    
    /** topView */
    
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = BASEGRAYCOLOR;
    iconView.layer.cornerRadius  = 30;
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
    
    /** 时间*/
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.font = Font(12);
    timeLab.numberOfLines = 2;
    timeLab.textColor  = [UIColor lightGrayColor];
    timeLab.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:timeLab];
    self.timeLab = timeLab;
    
    
    //评分
    XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(10, 40, 70, 20) numberOfStars:5 rateStyle:IncompleteStar isAnination:NO foreBackgroundStarImage:@"full_Star" backgroundStarImage:@"Star" finish:nil];
    _startView = starRateView;
    starRateView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:starRateView];
    
    
}

-(void)sBottom{
    
    
    UIView *topView = [[UIView alloc]init];
    [self.contentView addSubview:topView];
    
    self.topView = topView;
    self.topView.backgroundColor = [UIColor whiteColor];
    
    /**图片View */
    [topView addSubview:self.photosView];
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = font(13);
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = KWhiteColor;
    [topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //标签
    UIButton *taglab = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 0, 60, 50)];
    taglab.backgroundColor = [UIColor whiteColor];
    [taglab setImage:[UIImage imageNamed:@"biaoqian"] forState:0];
    [taglab setTitle:@"" forState:0];
    [taglab setTitleColor:[UIColor grayColor] forState:0];
    taglab.titleLabel.font = font(13);
    self.taglab = taglab;
    [self.contentView addSubview:taglab];
    
}

-(SPPhotosView *)photosView{
    if (!_photosView) {
        _photosView = [[SPPhotosView alloc] init];
        _photosView.backgroundColor = [UIColor whiteColor];
    }
    return _photosView;
}

-(void)setStatusFrame:(YSJCommentFrameModel *)statusFrame{
    _statusFrame = statusFrame;
    _statue = statusFrame.status;
    
    //头像
    _iconImg.frame = statusFrame.iconViewF;
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,statusFrame.status.photo]]placeholderImage:[UIImage imageNamed:@"logo_placeholder"]];
    
    //昵称
    _nameLabel.frame = statusFrame.nameLabelF;
    _nameLabel.text = statusFrame.status.nickname;
    
    //评分
    _startView.frame = statusFrame.starF;
    [_startView setStarLeave:[statusFrame.status.evaluation doubleValue]];
    
    //时间
    _timeLab.frame= statusFrame.timeF;
    _timeLab.text = statusFrame.status.create_time;
    
    //正文
    _contentLabel.frame = statusFrame.contentLabelF;
    _contentLabel.text = statusFrame.status.content;
    
    //标签
    self.taglab.frame = statusFrame.tagLabelF;
    [self.taglab setTitle:[NSString stringWithFormat:@" %@",statusFrame.status.lables] forState:0];
    [self.taglab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel).offset(0);
        make.height.offset(20);
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
    }];
    
    //分割线
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor = HomeBaseColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W-20, 0.6));
        make.bottom.equalTo(self).offset(0);
        make.left.offset(10);
    }];
    
    //上部分baseView
    _topView.frame = statusFrame.topViewF;
    
    
    if (!isEmptyString(statusFrame.status.photo_urls)) {
        //图片
        NSArray *photoArr = [statusFrame.status.photo_urls componentsSeparatedByString:@","];
        NSMutableArray *photoA = @[].mutableCopy;
        for (NSString *url in photoArr) {
            [photoA addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url]];
        }
        _photosView.frame = statusFrame.photosViewF;
        [_photosView setImgArr:photoA];
    }else{
        _photosView.frameHeight = 0;
    }
    
    
    
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
    
    //    SPProfileVC *vc = [[SPProfileVC alloc]init];
    //    vc.code = self.statue.promulgator;
    //    vc.titleName = self.statue.promulgatorName;
    //    [[SPCommon getCurrentVC].navigationController pushViewController:vc animated:YES];
}



//点赞
-(void)praise:(UIButton *)btn{
    
    //    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    //
    //    [dict setObject:self.statusFrame.status.code forKey:@"bePraisedCode"];
    //    [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
    //    [dict setObject:@"FEED" forKey:@"type"];
    //    NSString *url  = @"";
    //    if (btn.isSelected) {
    //        url = kUrlDeletePraise;
    //    }else{
    //        url = kUrlAddPraise;
    //    }
    //    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
    //        btn.selected = !btn.isSelected;
    //
    //        self.statusFrame.status.praised = btn.selected;
    //        //
    //        if (btn.selected) {
    //            self.statusFrame.status.praiseNum+=1;
    //        }else{
    //            self.statusFrame.status.praiseNum-=1;
    //        }
    //        [self.prasie setTitle:[NSString stringWithFormat:@"%d",self.statusFrame.status.praiseNum] forState:0];
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //    }];
}
@end
