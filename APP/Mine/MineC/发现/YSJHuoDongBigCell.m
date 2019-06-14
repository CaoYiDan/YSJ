
#import "YSJHuoDongBigCell.h"

#import "YSJHuoDongModel.h"

@implementation YSJHuoDongBigCell

{
    UIImageView *_img;
    
    UILabel *_name;
    
    UILabel *_introduction;
    
}

#pragma mark - init

- (void)initUI{
    
    CGFloat imgWid = kWindowW-2*kMargin;
    CGFloat imgH = 182;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(18);
    _name.numberOfLines = 2;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        
        make.right.offset(-kMargin); make.top.equalTo(_img.mas_bottom).offset(17);
    }];
    
    //介绍
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(12);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.numberOfLines = 2;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.bottom.equalTo(_name.mas_bottom).offset(25);
    }];
    
}

-(void)setModel:(YSJHuoDongModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.activity_pic]]placeholderImage:[UIImage imageNamed:@"120"]];
    _name.text = model.activity_title;
    _introduction.text = [NSString stringWithFormat:@"%@   %@",[SPCommon getTimeFromTimestamp:[model.activity_time integerValue]],model.activity_place];
}

@end
