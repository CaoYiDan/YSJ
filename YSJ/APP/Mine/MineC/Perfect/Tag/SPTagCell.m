//
//  SPKungFuCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPKungFuModel.h"
#import "SPTagCell.h"
#import "UILabel+Extension.h"
#import "SPThirdLevelCell.h"
#import "SPThirdLevelCell.h"
#import "SPCommon.h"
@interface SPTagCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UILabel *tipLabel;//请选择喜欢的标签
@property(nonatomic,strong)UIImageView *Img;
@property(nonatomic,strong)UIView *baseView;

@end

@implementation SPTagCell
{
    UIColor *_cellColor;
    UIColor *_lightCellColor;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //一级分类图片
        self.Img = [[UIImageView alloc]init];
        [self.contentView addSubview:self.Img];
        [self.Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(20);
            make.size.mas_offset(CGSizeMake(25, 25));
        }];
        
        // 请选择喜欢的标签
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.font=kFontNormal;
        [self.contentView addSubview:self.tipLabel];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(80);
            make.width.offset(200);
        }];
        
        //二级分类--contentViewcell（tableView嵌套collectionView）
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.equalTo(self.Img.mas_right).offset(30);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(self);
        }];
      
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection =     UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.userInteractionEnabled = NO;
        [_collectionView registerClass:[SPThirdLevelCell class] forCellWithReuseIdentifier:SPThirdLevelCellID];
        _collectionView.backgroundColor=[UIColor whiteColor];
    }
    return _collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.thirdLevelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPThirdLevelCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPThirdLevelCellID forIndexPath: indexPath];
    SPKungFuModel *model3 = self.model.thirdLevelArr[indexPath.row];
    //字text
    [cell setText:model3.value];
    //collection 的背景颜色
    cell.baseColor = _cellColor;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.collectionView.frameWidth-21)/4, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 0, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 1;
}

-(void)setModel:(SPKungFuModel *)model{
    _model = model;
    _cellColor = [SPCommon colorWithHexString:model.bgColor];
    
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.tagImg]];
    
    if(model.thirdLevelArr.count!=0 && model.thirdLevelArr!=nil){
        //三级数组不为0. 展示 collection
        self.tipLabel.hidden = YES;
        self.collectionView.hidden = NO;
        //刷新
        [self.collectionView reloadData];
    }else{
        //三级数组为0.不隐藏 “+请选择武功” 隐藏colllection
        self.tipLabel.hidden = NO;
        self.tipLabel.text = [NSString stringWithFormat:@"+ 添加%@标签",model.value];
        //将 + 号 变颜色
        [self.tipLabel setAttributeTextWithString:self.tipLabel.text range:NSMakeRange(0, 1) WithColour:_cellColor];
        self.collectionView.hidden = YES;
    }
}

-(void)setMyCenterModel:(SPKungFuModel *)model{
    _model = model;
    
    _model.thirdLevelArr = (NSMutableArray *)model.subProperties;
    
    _cellColor = [SPCommon colorWithHexString:model.bgColor];
    
    [self.Img sd_setImageWithURL:[NSURL URLWithString:model.tagImg]];
    
    if(model.thirdLevelArr.count!=0 && model.thirdLevelArr!=nil){
        //三级数组不为0. 展示 collection
        self.tipLabel.hidden = YES;
        self.collectionView.hidden = NO;
        //刷新
        [self.collectionView reloadData];
    }
}
@end
