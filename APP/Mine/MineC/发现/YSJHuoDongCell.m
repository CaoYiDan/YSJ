
#import "YSJHuoDongCell.h"

#import "YSJHuoDongModel.h"

@implementation YSJHuoDongCell

{
    UIImageView *_img;
   
    UILabel *_name;
    
    UILabel *_introduction;
    
}

#pragma mark - init

- (void)initUI{
    
    CGFloat imgWid = 134;
    CGFloat imgH = 82;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    _name.numberOfLines = 2;
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.right.offset(-kMargin);
        make.top.equalTo(_img).offset(0);
    }];
    
    //介绍
    _introduction = [[UILabel alloc]init];
    _introduction.font = font(12);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_introduction];
    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.bottom.equalTo(_img.mas_bottom).offset(7);
    }];

}

-(void)setModel:(YSJHuoDongModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.activity_pic]]placeholderImage:[UIImage imageNamed:@"120"]];
    _name.text = model.activity_title;
    _introduction.text = [NSString stringWithFormat:@"%@   %@",[SPCommon getTimeFromTimestamp:[model.activity_time integerValue]],model.activity_place];
}

@end
