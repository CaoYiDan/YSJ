
#import "YSJRequestListCell.h"

#import "YSJRequimentModel.h"

@implementation YSJRequestListCell

{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_requestType;
    UILabel *xuqiu;
   
    UILabel *_price;
    UILabel *_introduction;
    YSJTagsView *_introductionView;
}

#pragma mark - init

- (void)initUI{
    
    CGFloat imgWid = 84;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 17, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(0);
    }];
    
    _distance = [[UILabel alloc]init];
    _distance.font = Font(12);
    _distance.textColor = gray999999;
    _distance.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_name);
        make.height.offset(30);
    }];
    
   
    //上课类型
    _requestType = [[UILabel alloc]init];
    _requestType.font = font(12);
    _requestType.textAlignment = NSTextAlignmentCenter;
    _requestType.textColor = gray999999;
    _requestType.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_requestType];
    [_requestType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(20);
        make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    UIImageView *xuImg =[[UIImageView alloc]init];
    xuImg.image = [UIImage imageNamed:@"xu"];
    [self addSubview:xuImg];
    [xuImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        
        make.height.offset(14);
        make.width.offset(14); make.top.equalTo(_requestType.mas_bottom).offset(7);
    }];
    
    xuqiu = [[UILabel alloc]init];
    xuqiu.backgroundColor = KWhiteColor;
    xuqiu.textColor = gray9B9B9B;
    xuqiu.font = font(12);
    [self addSubview:xuqiu];
    [xuqiu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(xuImg.mas_right).offset(5);
        
        make.height.offset(14);
        make.right.offset(-kMargin); make.top.equalTo(_requestType.mas_bottom).offset(7);
    }];
    
    //介绍
//    _introduction = [[UILabel alloc]init];
//    _introduction.font = font(12);
//    _introduction.textAlignment = NSTextAlignmentCenter;
//    _introduction.textColor = gray999999;
//    _introduction.backgroundColor = KWhiteColor;
//    [self.contentView addSubview:_introduction];
//    [_introduction mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_name).offset(0);
//        make.height.offset(20);
//        make.top.equalTo(xuqiu.mas_bottom).offset(7);
//    }];
    
    //介绍
    _introductionView = [[YSJTagsView alloc]init];

    [self.contentView addSubview:_introductionView];
    [_introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name).offset(0);
        make.height.offset(30);
        make.top.equalTo(xuqiu.mas_bottom).offset(5);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
}

-(void)setModel:(YSJRequimentModel *)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"120"]];
    _distance.text = [SPCommon changeKm:model.distance];
    _name.text = model.nickname;
    _requestType.text = [NSString stringWithFormat:@"%@ | %@ ",model.coursetype,model.coursetypes];
    xuqiu.text = [NSString stringWithFormat:@"%@",model.describe];
     
    _introductionView.tagsArr = [model.userlables componentsSeparatedByString:@","];
    
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    for (UIView *vi in _introductionView.subviews)
    {
        [vi removeFromSuperview];
    }
}

@end
