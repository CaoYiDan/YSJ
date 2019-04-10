//
//  SPKungFuCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPKungFuModel.h"
#import "SPKungFuCell.h"
#import "SPThirdLevelCell.h"
#import "SPThirdLevelCell.h"
#import "UILabel+Extension.h"
#import "SPCommon.h"
const CGFloat onelevelWid = 70;

@interface SPKungFuCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UILabel *tipLabel;//请选择武功标签
@property(nonatomic,strong)UIView *baseView;

@end

@implementation SPKungFuCell
{
    UIColor *_cellColor;
    UIColor *_lightCellColor;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //一级分类标题
        self.lable = [[UILabel alloc]init];
        self.lable.font=kFontNormal;
        self.lable.adjustsFontSizeToFitWidth = YES;
        self.lable.layer.cornerRadius = 12.5f;
        self.lable.clipsToBounds = YES;
        self.lable.textColor = [UIColor blackColor];
        self.lable.backgroundColor = [UIColor whiteColor];
        self.lable.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.lable];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(kMargin);
            make.size.mas_offset(CGSizeMake(onelevelWid, 25));
        }];
        
        // 请选择武功标签
        self.tipLabel = [[UILabel alloc]init];
        self.tipLabel.font=kFontNormal;
        self.tipLabel.backgroundColor = [UIColor whiteColor];
        self.tipLabel.text = @"+ 请选择技能标签";
        [self.contentView addSubview:self.tipLabel];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(self.lable.mas_right).offset(10);
            make.width.offset(200);
        }];
        
        //二级分类--contentViewcell（tableView嵌套collectionView）
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.equalTo(self.lable.mas_right).offset(10);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(self);//先随定一个
        }];
        
        //底部的分割线
//        UIView*bottomLine=[[UIView alloc]init];
//        bottomLine.backgroundColor=[UIColor grayColor];
//        [self.contentView addSubview:bottomLine];
//        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.mas_bottom);
//            make.right.offset(0);
//            make.height.offset(0.8);
//            make.left.offset(0);
//        }];
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
    cell.baseColor = _lightCellColor;;
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
}

-(void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    NSInteger x = indexRow%6;
    switch (x) {
        case 0:
         _cellColor = PURPLECOLOR;
            _lightCellColor = LIGHTPURPLECOLOR;
            break;
        case 1:
            _cellColor = PRINKCOLOR;
            _lightCellColor = LIGHTPRINKCOLOR;
            break;
        case 2:
            _cellColor = BULECOLOR;
            _lightCellColor = LIGHTBULECOLOR;
            break;
        case 3:
            _cellColor = GREENCOLOR;
            _lightCellColor = LIGHTGREENCOLOR;
            break;
        case 4:
            _cellColor = ORANGECOLOR;
            _lightCellColor = LIGHTORANGECOLOR;
            break;
        case 5:
            _cellColor = REDCOLOR;
            _lightCellColor = LIGHTREDCOLOR;
            break;
        default:
            break;
    }
    self.lable.backgroundColor = _cellColor;
//    [self.tipLabel setAttributeTextWithString:self.tipLabel.text range:NSMakeRange(0, 1) WithColour:[UIColor blackColor]];
}

-(void)setIndexRow2:(NSInteger)indexRow2{
    _indexRow2 = indexRow2;
    
    NSInteger x = indexRow2%6;
    switch (x) {
        case 0:
            
            _lightCellColor = LIGHTPURPLECOLOR;
            break;
        case 1:
            
            _lightCellColor = LIGHTPRINKCOLOR;
            break;
        case 2:
            
            _lightCellColor = LIGHTBULECOLOR;
            break;
        case 3:
            
            _lightCellColor = LIGHTGREENCOLOR;
            break;
        case 4:
            
            _lightCellColor = LIGHTORANGECOLOR;
            break;
        case 5:
            
            _lightCellColor = LIGHTREDCOLOR;
            break;
        default:
            break;
    }
    self.lable.backgroundColor = [UIColor whiteColor];
//    [self.tipLabel setAttributeTextWithString:self.tipLabel.text range:NSMakeRange(0, 1) WithColour:[UIColor blackColor]];
}

//在个人信息完善调用
-(void)setModel:(SPKungFuModel *)model{
    _model = model;
    self.lable.text = model.value;
    self.lable.textColor = [UIColor whiteColor];
    self.lable.backgroundColor =_cellColor;
    if(model.thirdLevelArr.count!=0){
         //三级数组不为0. 展示 collection
        self.tipLabel.hidden = YES;
        self.collectionView.hidden = NO;
        //刷新
        [self.collectionView reloadData];
    }else{
        //三级数组为0.不隐藏 “+请选择武功” 隐藏colllection
        self.tipLabel.hidden = NO;
        self.collectionView.hidden = YES;
    }
    
//    [self.tipLabel setAttributeTextWithString:self.tipLabel.text range:NSMakeRange(0, 1) WithColour:[SPCommon colorWithHexString:model.bgColor]];
}

//在个人中心编辑 调用此方法，
-(void)setModel2:(SPKungFuModel *)model2{
    //将Model2赋给 不对应的Model，此处并不是错误，是有意为之。
    _model = model2;
    //将
    _model.thirdLevelArr = (NSMutableArray *)model2.subProperties;
    
    self.lable.text = model2.value;
    self.lable.textColor = [UIColor blackColor];
    self.lable.backgroundColor = [UIColor whiteColor];
//    self.lable.textColor = [SPCommon colorWithHexString:model2.fontColor];
//    self.lable.backgroundColor =[SPCommon colorWithHexString:model2.bgColor];
    if(model2.thirdLevelArr.count!=0){
        //三级数组不为0. 展示 collection
        self.tipLabel.hidden = YES;
        self.collectionView.hidden = NO;
        //刷新
        [self.collectionView reloadData];
    }
}
@end
