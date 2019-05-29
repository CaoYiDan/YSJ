//
//  YSJTeacherCell.m


#import "YSJCompanyCell.h"

#import "NSString+getSize.h"

#import "YSJCompanysModel.h"

@implementation YSJCompanyCell

{
    UIImageView *_img;
    UILabel *_distance;
    UILabel *_name;
    UILabel *_introduction;
    UILabel *xing;
    UILabel *_price;
    UIView *_introductionView;
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
    CGFloat imgH = 83;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, imgWid, imgH)];
    _img.backgroundColor = grayF2F2F2;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 4;
    _img.clipsToBounds = YES;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+17, imgWid, 20)];
    _name.font = Font(15);
    _name.textAlignment = NSTextAlignmentCenter;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+40, imgWid, 20)];
    _introduction.font = font(11);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
    //评分
    UIImageView *xingImg = [[UIImageView alloc]init];
    xingImg.image = [UIImage imageNamed:@"full_Star"];
    [self.contentView addSubview:xingImg];
    [xingImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-5);
        make.width.offset(13);
        make.height.offset(13);
        make.top.equalTo(_introduction.mas_bottom).offset(10);
    }];
    
    xing = [[UILabel alloc]init];
    xing.backgroundColor = KWhiteColor;
    
    xing.textColor=gray9B9B9B;
    xing.font = font(12);
    [self addSubview:xing];
    [xing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xingImg.mas_right).offset(0);
        
        make.height.offset(20);
        make.centerY.equalTo(xingImg);
    }];
    
    _distance = [[UILabel alloc]init];
    _distance.font = Font(11);
    _distance.layer.cornerRadius = 4;
    _distance.clipsToBounds = YES;
    _distance.textColor = KWhiteColor;
//    _distance.textAlignment = NSTextAlignmentCenter;
    _distance.backgroundColor = KWhiteColor;
    [self addSubview:_distance];
    [_distance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xing.mas_right).offset(10);
        
        make.height.offset(20);
        make.centerY.equalTo(xingImg);
    }];

    
    //介绍
    _introductionView = [[UILabel alloc]init];
   
    _introductionView.backgroundColor = KWhiteColor;
    [self.contentView addSubview:_introductionView];
    [_introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.offset(0);
        make.height.offset(30);
        make.top.equalTo(xing.mas_bottom).offset(5);
    }];
}

-(void)setModel:(YSJCompanysModel*)model{
    
    _model = model;
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.site_photo]]placeholderImage:[UIImage imageNamed:@"bg"]];
    _distance.text = [NSString stringWithFormat:@"%dkm",model.distance];
    _name.text = model.name;
    _introduction.text = [NSString stringWithFormat:@"%@ | %@ ",model.coursetype,model.coursetypes];
    xing.text = [NSString stringWithFormat:@"%.1f",model.reputation];
    
    _distance.text = [NSString stringWithFormat:@"%dm",model.distance];

    NSArray *arr = [model.lables componentsSeparatedByString:@","];
    int i = 0 ;
   
    for (NSString *labelStr in arr) {
        if (i>0) {
            return;
        }
        
        
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hexColor:@"E8541E"];
        label.font = Font(11);
        label.layer.cornerRadius = 8;
        label.clipsToBounds = YES;
        label.text = labelStr;
        label.backgroundColor = RGBA(253, 135, 197, 0.08);
        [_introductionView addSubview:label];
        label.text = [NSString stringWithFormat:@"%@名资深老师",model.num_teacher];
       CGFloat width= [label.text sizeWithFont:font(11) maxW:150].width+20;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.offset(width);
            make.height.offset(20);
            make.bottom.offset(-5);
        }];
        i++;
    }
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
