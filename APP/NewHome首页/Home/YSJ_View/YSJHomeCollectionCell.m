
#import "SPUser.h"

#import "YSJHomeCollectionCell.h"

@implementation YSJHomeCollectionCell

{
    UIImageView *_img;
    
    UIButton *_level;
    
    UILabel *_name;
    
    UIButton *_age;
    
    UIButton *_constellation;
    
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    CGFloat imgWid = self.frameWidth;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, imgWid, imgWid)];
    _img.backgroundColor = [UIColor whiteColor];
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
//    CGFloat levelWid = 22;
    
//    _level = [[UIButton alloc]initWithFrame:CGRectMake(5, imgWid-levelWid-5, levelWid, levelWid)];
//    _level.titleLabel.font = font(12);
//    [_level setBackgroundImage:[UIImage imageNamed:@"s_littlepig_level"] forState:0];
//    [_img addSubview:_level];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, imgWid+10, imgWid, 30)];
    _name.font = Font(15);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.backgroundColor = [UIColor whiteColor];
    
    
    _age = [[UIButton alloc]initWithFrame:CGRectMake(self.frameWidth/2-55, imgWid+40, 50, 20)];
    _age.backgroundColor = RGBCOLOR(199, 226, 253);
    _age.layer.cornerRadius = 4;
    _age.clipsToBounds = YES;
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_n"] forState:0];
    [_age setImage:[UIImage imageNamed:@"sy_gr_fj_nv"] forState:UIControlStateSelected];
    _age.titleLabel.font = font(12);
    [self addSubview:_age];
    
    _constellation = [[UIButton alloc]initWithFrame:CGRectMake(self.frameWidth/2+5, imgWid+40, 50, 20)];
    _constellation.layer.cornerRadius = 4;
    _constellation.clipsToBounds = YES;
    _constellation.backgroundColor = RGBCOLOR(216, 199, 253);
    
    _constellation.titleLabel.font = font(12);
    [self addSubview:_constellation];
    [self.contentView addSubview:_name];
}

-(void)setUserModel:(SPUser *)userModel{
    _userModel = userModel;
    NSLog(@"%@",userModel.avatar);
    [_img sd_setImageWithURL:[NSURL URLWithString:userModel.avatar]placeholderImage:[UIImage imageNamed:@"bg"]];
    _name.text = userModel.nickName;
    
    [_age setTitle:[NSString stringWithFormat:@"%d岁",userModel.age] forState:0];
    _age.selected = userModel.gender;
    
    [_constellation setTitle:userModel.zodiac forState:0];
//    NSLog(@"%@",userModel.levelStr);
//    [_level setTitle:userModel.levelStr forState:0];
}
@end
