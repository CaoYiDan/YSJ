//
//  SPHomeCell.m
//  SmallPig


#import "YSJHomeWorkCell.h"
#import "XHStarRateView.h"
#import "YSJHomeWorkFrameModel.h"
#import "SPCommon.h"
#import "YSJOrderModel.h"
#import "SPDynamicFrame.h"
#import "SPDynamicToolView.h"
#import "SPProfileDynamicToolView.h"
#import "SPPhotosView.h"
#import "SPProfileVC.h"
#import "SDPhotoBrowser.h"

@interface YSJHomeWorkCell ()<SDPhotoBrowserDelegate>


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
    [self sContent];
   
}

-(void)sContent{
    
    UIView *topView = [[UIView alloc]init];
    [self.contentView addSubview:topView];
    
    self.topView = topView;
    self.topView.backgroundColor = [UIColor whiteColor];
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = font(16);
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = KWhiteColor;
    contentLabel.textColor = [UIColor hexColor:@"888888"];
    [_topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    
    
    /**图片View */
    [topView addSubview:self.photosView];
    
   
    
    //分割线
    UIView *line  =[[UIView alloc]init];
    line.backgroundColor = grayF2F2F2;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_W,6));
        make.bottom.equalTo(self).offset(0);
        make.left.offset(0);
    }];
}

-(SPPhotosView *)photosView{
    if (!_photosView) {
        _photosView = [[SPPhotosView alloc] init];
        _photosView.backgroundColor = [UIColor whiteColor];
    }
    return _photosView;
}

-(void)setStatusFrame:(YSJHomeWorkFrameModel *)statusFrame{
    
    _statusFrame = statusFrame;
    _statue = statusFrame.status;
    
    NSArray *photosArr = @[];
    NSString *contentText = @"";
    
    if (self.type ==0) {
        contentText =  statusFrame.status.teacher_describe;
        photosArr = statusFrame.status.teacher_despics;
    }else{
        
        contentText =  statusFrame.status.student_describe;
        photosArr = statusFrame.status.student_despics;
    }
    
    
    NSLog(@"%@%@",contentText,photosArr);
    
    //正文
    _contentLabel.frame = statusFrame.contentLabelF;
    _contentLabel.text = contentText;
    
    
    //上部分baseView
    _topView.frame = statusFrame.topViewF;
    
    
    if (photosArr.count !=0 ) {
        //图片
     
        NSMutableArray *photoA = @[].mutableCopy;
        for (NSString *url in photosArr) {
            [photoA addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url]];
        }
        NSLog(@"%.2f",statusFrame.photosViewF.size.height);
        _photosView.backgroundColor = KWhiteColor;
        _photosView.frame = statusFrame.photosViewF;

        [_photosView setImgArr:photoA];
        
    }else{
        
        _photosView.frameHeight = 0;
    }
}

-(void)prepareForReuse{
    
    [super prepareForReuse];
    //将图片view上的图片移除，不然错乱
    for (UIView *vi in self.photosView.subviews) {
        [vi removeFromSuperview];
    }
}

#pragma mark - SDPhotoBrowserDelegate
- (NSString *)photoBrowser:(SDPhotoBrowser *)browser stringUrlForIndex:(NSInteger)index{
    return   self.statusFrame.studentWorkModel.student_despics[index];
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *url = self.statusFrame.studentWorkModel.student_despics[index];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]init];
     NSString *url = self.statusFrame.studentWorkModel.student_despics[index];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,url];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
    return imageView.image;
}

@end
