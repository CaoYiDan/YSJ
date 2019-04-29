//
//  SPNewDynamicHeaderView.m
//  SmallPig


#import "YSJMineHeaderView.h"
#import "SPDynamicCategoryCell.h"
#import "YSJActivityCell.h"
#import "YSJUserModel.h"
@interface YSJMineHeaderView ()

//
@property(nonatomic,strong)NSMutableArray *categoryArr;
//
@property(nonatomic,strong)UIView *topView;
//
@property(nonatomic,strong)UIView *middleView;

@property(nonatomic,strong)NSMutableArray *activityArr;
//
@property(nonatomic,strong)UIView *applicationView;

@end

@implementation YSJMineHeaderView
{
    UIImageView *_icon;
    UILabel *_name;
    UILabel *_phone;
    
    NSMutableArray *_numArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    self.backgroundColor = KWhiteColor;
    
    self.clipsToBounds = YES;
    
    self.categoryArr = @[@{@"img":@"wodefabu ",@"name":@"我的发布"},@{@"img":@"maidao",@"name":@"买到管理"},@{@"img":@"maichu",@"name":@"卖出管理"},@{@"img":@"dianp",@"name":@"作业点评"},@{@"img":@"qianbao",@"name":@"我的钱包"}].mutableCopy;
    
    self.activityArr = @[@{@"img":@"icon_boss",@"name":@"私教申请",@"subTitle":@"诚邀优秀艺术加教师"},@{@"img":@"icon_jigou",@"name":@"机构申请",@"subTitle":@"诚邀优质机构合作"}].mutableCopy;
    
    [self addSubview:self.topView];
    
    [self addSubview:self.middleView];
    
    [self addSubview:self.applicationView];
    
}

#pragma mark - topView
-(UIView*)topView{
    
    if (!_topView) {
        
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, bgImgH)];
        [self setTop];
    }
    
    return _topView;
}

-(void)setTop{
    
    /** 背景图片 */
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, bgImgH)];
    bgImg.clipsToBounds = YES;
    bgImg.backgroundColor =grayF2F2F2;
    bgImg.contentMode = UIViewContentModeScaleAspectFill;
    _bgImgView = bgImg;
    bgImg.image = [UIImage imageNamed:@"headerbg_my"];
    bgImg.userInteractionEnabled = YES;
    [self.topView addSubview:bgImg];
    NSLog(@"%.0f",bgImg.frameHeight);
    
    
    //设置按钮
    UIButton *setBtn = [FactoryUI createButtonWithtitle:nil titleColor:nil imageName:@"shezhi" backgroundImageName:nil target:self selector:@selector(setClick)];
    [_bgImgView addSubview:setBtn];
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(44);
        make.height.offset(44);
        make.top.offset(SafeAreaStateHeight);
    }];
    
    /** 头像背景（光环） */
    CGFloat iconbgW = 94;
    UIImageView *iconBgView = [[UIImageView alloc] init];
    
    iconBgView.layer.cornerRadius  = iconbgW/2;
    iconBgView.clipsToBounds = YES;
    iconBgView.image = [UIImage imageNamed:@"yonghubg"];
    iconBgView.contentMode = UIViewContentModeScaleAspectFill;
    iconBgView.userInteractionEnabled = YES;
    [_bgImgView addSubview:iconBgView];
    
    [iconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(iconbgW);
        make.height.offset(iconbgW);
        make.bottom.offset(-75);
    }];
    
    
    /** 头像 */
    CGFloat iconW = 75;
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = BASEGRAYCOLOR;
    iconView.layer.cornerRadius  = iconW/2;
    iconView.clipsToBounds = YES;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.userInteractionEnabled = YES;
    [iconBgView addSubview:iconView];
    ImgWithUrl(iconView, [StorageUtil getPhotoUrl]);
    _icon = iconView;
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.offset(iconW);
        make.height.offset(iconW);
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)];
    tap.numberOfTapsRequired = 1;
    [iconView addGestureRecognizer:tap];
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = isEmptyString([StorageUtil getNickName])?@"艺术加":[StorageUtil getNickName];
    nameLabel.font = font(22);
    nameLabel.textColor = KWhiteColor;
    [_bgImgView addSubview:nameLabel];
    _name = nameLabel;
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(_icon.mas_right).offset(kMargin);
        
        make.height.offset(30);
        make.top.equalTo(_icon).offset(0);
    }];
    
    
    /** 手机号*/
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.font = Font(14);
    timeLab.numberOfLines = 2;
    timeLab.textColor  = KWhiteColor;
    [_bgImgView addSubview:timeLab];
    _phone = timeLab;
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).offset(kMargin);
        
        make.height.offset(30);
        make.top.equalTo(_name.mas_bottom).offset(10);
    }];
    
    
    UIButton *insertBtn = [FactoryUI createButtonWithtitle:@"" titleColor:nil imageName:@"dizhi_more" backgroundImageName:nil target:self selector:@selector(insertClick)];
    [_bgImgView addSubview:insertBtn];
    [insertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.width.offset(40);
        make.height.offset(30);
        make.centerY.equalTo(_icon).offset(0);
    }];
    
    
    NSArray *arr  = @[@"收藏",@"关注",@"足迹",@"红包券"];
    CGFloat btnW = (kWindowW)/arr.count;
    int i= 0;
    _numArr = @[].mutableCopy;
    for (NSString *str in arr)
    {
        UIView *base = [[UIView alloc]initWithFrame:CGRectMake(btnW*i,bgImgH-70, btnW,70)];
        WeakSelf;
        [base addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf.delegate mineHeaderViewDidSelectedType:@"topBottom" index:i];
        }];
        [_bgImgView addSubview:base];
        UILabel *numLabel  = [[UILabel alloc]init];
        numLabel.text = @"0";
        numLabel.userInteractionEnabled = NO;
        numLabel.font = font(18);
        numLabel.textColor = KWhiteColor;
        [_numArr addObject:numLabel];
        [base addSubview:numLabel];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.height.offset(20);
            make.top.offset(10);
        }];
        
        UILabel *bottomLabel = [[UILabel alloc]init];
        bottomLabel.userInteractionEnabled = NO;
        bottomLabel.textColor = KWhiteColor;
        bottomLabel.text = str;
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = font(12);
        [base addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(20);
            make.top.equalTo(numLabel.mas_bottom).offset(10);
        }];
        i++;
    }
}


#pragma mark - 我的发布 买到管理...view
-(UIView *)middleView{
    if (!_middleView) {
        
        _middleView  = [[UIView alloc]initWithFrame:CGRectMake(0, bgImgH+kMargin, SCREEN_W, categotyH)];
        _middleView.backgroundColor = KWhiteColor;
        [self setMiddle];
        
    }
    return _middleView;
}

-(void)setMiddle{
    
    CGFloat btnW = (kWindowW)/5;
    int i= 0;
    UIImageView *lastImg = nil;
    for (NSDictionary *dic in self.categoryArr)
    {
        UIView *base = [[UIView alloc]initWithFrame:CGRectMake(btnW*i,0, btnW,80)];
        WeakSelf;
        [base addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakSelf.delegate mineHeaderViewDidSelectedType:@"middle" index:i];
        }];
        [_middleView addSubview:base];
        //图标
        UIImageView *img  = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:dic[@"img"]];
        img.userInteractionEnabled = NO;
        img.backgroundColor = KWhiteColor;
        img.contentMode = UIViewContentModeScaleAspectFit;
        [base addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //第四个图片有点与众不同
            if (i==3) {
                
                make.width.offset(45);
                make.height.offset(33);
                make.bottom.equalTo(lastImg);
                make.centerX.offset(10);
                
            }else{
                make.centerX.offset(0);
                
                make.width.offset(26);
                make.height.offset(23);
                make.top.offset(20);
            }
            
            
        }];
        
        lastImg = img;
        
        //底部title
        UILabel *bottomLabel = [[UILabel alloc]init];
        bottomLabel.userInteractionEnabled = NO;
        bottomLabel.text = dic[@"name"];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = font(13);
        [base addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.height.offset(20);
            make.top.equalTo(img.mas_bottom).offset(10);
        }];
        i++;
    }
}

#pragma mark - 申请view
-(UIView *)applicationView{
    
    if (!_applicationView) {
        
        _applicationView  = [[UIView alloc]initWithFrame:CGRectMake(0, bgImgH+20+categotyH, SCREEN_W, activityH)];
        _applicationView.backgroundColor = KWhiteColor;
        
        CGFloat btnW = (kWindowW-3*kMargin)/2;
        int i= 0;
        for (NSDictionary *dic in self.activityArr)
        {
            UIView *base = [[UIView alloc]initWithFrame:CGRectMake(i%2*(btnW+kMargin)+kMargin,i/2*100, btnW,activityH)];
            [SPCommon setShaowForView:base];
            WeakSelf;
            [base addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                  [weakSelf.delegate mineHeaderViewDidSelectedType:@"application" index:i];
            }];
            [_applicationView addSubview:base];
            
            UIImageView *img  = [[UIImageView alloc]init];
            img.userInteractionEnabled = NO;
            img.backgroundColor = KWhiteColor;
            [base addSubview:img];
            img.image = [UIImage imageNamed:dic[@"img"]];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.offset(0);
                make.width.offset(30);
                make.height.offset(30);
                make.left.offset(kMargin);
            }];
            
            UILabel *title = [[UILabel alloc]init];
            title.userInteractionEnabled = NO;
            title.text = dic[@"name"];
            title.font = font(14);
            [base addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(img.mas_right).offset(10);
                make.right.offset(0);
                make.height.offset(20);
                make.top.equalTo(img).offset(0);
            }];
            
            UILabel *subTitle = [[UILabel alloc]init];
            subTitle.userInteractionEnabled = NO;
            subTitle.text = dic[@"subTitle"];
            subTitle.textColor = gray999999;
            subTitle.font = font(12);
            [base addSubview:subTitle];
            [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title).offset(0);
                make.right.offset(0);
                make.height.offset(20);
                make.top.equalTo(title.mas_bottom).offset(5);
            }];
            i++;
        }
    }
    return _applicationView;
}


#pragma mark - action

-(void)setClick{
    
    [self.delegate mineHeaderViewDidSelectedType:@"set" index:0];
}

-(void)insertClick{
    
    [self.delegate mineHeaderViewDidSelectedType:@"insert" index:0];
}

-(void)iconTap{
    
    [self.delegate mineHeaderViewDidSelectedType:@"icon" index:0];
}
- (void)setNumberDic:(NSMutableDictionary *)numberDic{
    _numberDic = numberDic;
    NSArray *keyArr = @[@"fan_num",@"collect_num",@"haveLook",@"red_packets_num"];
    
    int i = 0;
    
    for (UILabel *lab in _numArr) {
        
        NSNumber *num  = numberDic[keyArr[i]];
        lab.text = [num stringValue];
        
        i++;
    }

}

-(void)setModel:(YSJUserModel *)model{
    
    _model = model;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo];
    
    ImgWithUrl(_icon,url);
    
    _name.text = model.nickname;
    
    if (!isEmptyString(model.phone)) {
        NSString*tel=[model.phone  stringByReplacingOccurrencesOfString:[model.phone  substringWithRange:NSMakeRange(2,6)]withString:@"***"];
        _phone.text =  tel;
    }
    
}
@end
