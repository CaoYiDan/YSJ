

#import "YSJTeacherForCompanyCollectionCell.h"

#import "YSJCompanysModel.h"

@implementation YSJTeacherForCompanyCollectionCell

{
    UIImageView *_img;
    UILabel *_name;
    UILabel *_introduction;
    //被选中的遮挡view
    UIView *_selectedView;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self setUp];
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setUp{
    
    CGFloat imgWid = 70;
    
    CGFloat imgH = 70;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(self.frameWidth/2-imgWid/2, 10, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = 35;
    _img.clipsToBounds = YES;
    _img.clipsToBounds = YES;
 
    [self.contentView addSubview:_img];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+17, self.frameWidth, 30)];
    _name.font = Font(16);
    _name.textColor = KBlack333333;
    _name.textAlignment = NSTextAlignmentCenter;
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    
    _introduction = [[UILabel alloc]initWithFrame:CGRectMake(0, imgH+45, self.frameWidth, 20)];
    _introduction.font = font(12);
    _introduction.textAlignment = NSTextAlignmentCenter;
    _introduction.textColor = gray999999;
    _introduction.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_introduction];
    
    _selectedView = [[UIView alloc]init];
    _selectedView.backgroundColor = RGBCOLORA(0, 0, 0, 0.3);
    [self.contentView addSubview:_selectedView];
    [_selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UIImageView *selectedImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 16)];
    selectedImg.image = [UIImage imageNamed:@"xuanzhong"];
    [_selectedView addSubview:selectedImg];
    selectedImg.center = _selectedView.center;
    [selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.offset(17);
        make.height.offset(16);
    }];
    _selectedView.hidden = YES;
}

- (void)setDic:(NSDictionary *)dic{
    
    _dic = dic;
   
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,dic[@"photo"]]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    
    _name.text = dic[@"name"];
    
    _introduction.text = dic[@"teaching_type"];
}

- (void)setSelectedStatus:(BOOL)selectedStatus{
    
    _selectedStatus = selectedStatus;
    
    _selectedView.hidden = !selectedStatus;
    
   
}

@end
