//
//  CZHCountDownCell.m
//  倒计时重用
//
//  Created by 程召华 on 2017/12/20.
//  Copyright © 2017年 程召华. All rights reserved.
//

#import "CZHCountDownCell.h"

@interface CZHCountDownCell ()

/**小时*/
@property (nonatomic, weak) UILabel *hourLabel;
/**第一个分号*/
@property (nonatomic, weak) UILabel *colonOne;
/**分钟*/
@property (nonatomic, weak) UILabel *miniteLabel;
/**第二个分号*/
@property (nonatomic, weak) UILabel *colonTwo;
/**秒钟*/
@property (nonatomic, weak) UILabel *secondLabel;
///<#注释#>
@property (nonatomic, weak) UILabel *indexLabel;
///<#注释#>
@property (nonatomic, strong) CZHCountDownModel *timeModel;
///<#注释#>
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *const ID = @"CZHCountDownCell";
@implementation CZHCountDownCell
{
  
    UIImageView *_img;
    UILabel *_leftCount;
    UILabel *_name;
    
    UIButton *goToSpell;
    UILabel *_getOrderCount;//接单数量 和评分
    
    UIView *_leftTimeView;
    
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    CZHCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[CZHCountDownCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTime) name:CZHUpdateTimeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownFinish) name:CZHCountDownFinishNotification object:nil];
        
        [self setCell];
        
    }
    return self;
}


- (void)setCellWithTimeModel:(CZHCountDownModel *)timeModel indexPath:(NSIndexPath *)indexPath {
    
    self.timeModel = timeModel;
    self.indexPath = indexPath;
    
    NSInteger countDownTime = timeModel.startTime - timeModel.currentTime;
    
    if (countDownTime <= 0) {
        self.hourLabel.text = @"00";
        self.miniteLabel.text = @"00";
        self.secondLabel.text = @"00";
    } else {
        self.hourLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime/3600];
        self.miniteLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime%3600/60];
        self.secondLabel.text = [NSString stringWithFormat:@"%02ld", countDownTime%60];
    }
    
    self.indexLabel.text = [NSString stringWithFormat:@"位置:%ld",self.indexPath.row];
}

//刷新时间
- (void)updateTime {
    
    [self setCellWithTimeModel:self.timeModel indexPath:self.indexPath];
    
}

//倒计时完成
- (void)countDownFinish {
    
    if (self.timeModel.startTime - self.timeModel.currentTime > 0 || self.timeModel.isFinished == YES) {
        return;
    }

    self.timeModel.isFinished = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:countDownDidFinishedWithTimeModel:indexPath:)]) {
        [self.delegate cell:self countDownDidFinishedWithTimeModel:self.timeModel indexPath:self.indexPath];
    }
    
    NSLog(@"---倒计时完成%ld", self.indexPath.row);
    
}

- (void)setCell {
    
    CGFloat imgWid = 60;
    CGFloat imgH = 60;
    
    _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 12, imgWid, imgH)];
    _img.backgroundColor = KMainColor;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.layer.cornerRadius = imgH/2;
    _img.clipsToBounds = YES;
    [self.contentView addSubview:_img];
    
    
    _name = [[UILabel alloc]init];
    _name.font = Font(15);
    _name.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img.mas_right).offset(10);
        make.height.offset(20);
        make.top.equalTo(_img).offset(10);
    }];
    
    
    
    _leftCount = [[UILabel alloc]init];
    _leftCount.font = Font(12);
    _leftCount.textColor = gray999999;
    _leftCount.text = @"43";
    _leftCount.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_leftCount];
    [_leftCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.equalTo(_name);
        make.height.offset(30);
    }];
    
    UILabel *leftTimeTitle = [[UILabel alloc]init];
    leftTimeTitle.font = Font(12);
    leftTimeTitle.text = @"剩余";
    leftTimeTitle.textColor = gray999999;
    leftTimeTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:leftTimeTitle];
    [leftTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_name);
      
        make.height.offset(20);
       make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    _leftTimeView = [[UIView alloc]init];
    _leftTimeView.backgroundColor = KWhiteColor;
    [self addSubview:_leftTimeView];
    [_leftTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftTimeTitle.mas_right).offset(0);
        make.width.offset(130);
        make.height.offset(20);
        make.top.equalTo(_name.mas_bottom).offset(7);
    }];
    
    goToSpell = [[UIButton alloc]init];
    goToSpell.layer.cornerRadius = 4;
    goToSpell.clipsToBounds = YES;
    [goToSpell setTitle:@"去拼单" forState:0];
    [goToSpell setTitleColor:KWhiteColor forState:UIControlStateNormal];
    
    [goToSpell setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
    goToSpell.titleLabel.font = font(12);
    goToSpell.userInteractionEnabled = YES;
  
    [self addSubview:goToSpell];
    [goToSpell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kMargin);
        make.width.offset(66);
        make.height.offset(24);
        make.centerY.equalTo(self);
    }];
//    _getOrderCount = [[UILabel alloc]init];
//    _getOrderCount.font = font(12);
//    _getOrderCount.textAlignment = NSTextAlignmentCenter;
//    _getOrderCount.textColor = gray999999;
//    _getOrderCount.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:_getOrderCount];
//    [_getOrderCount mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_starRateView.mas_right).offset(5);
//        make.height.offset(20);
//        make.centerY.equalTo(_starRateView);
//    }];
    
    
    UILabel *hourLabel = [self quickSetUpLabel];
    self.hourLabel = hourLabel;
    
    UILabel *colonOne = [self quickSetUpLabel];
    colonOne.text = @":";
    self.colonOne = colonOne;
    
    UILabel *miniteLabel = [self quickSetUpLabel];
    self.miniteLabel = miniteLabel;
    
    UILabel *colonTwo = [self quickSetUpLabel];
    colonTwo.text = @":";
    self.colonTwo = colonTwo;
    
    UILabel *secondLabel = [self quickSetUpLabel];
    self.secondLabel = secondLabel;

}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat w = 30;
    CGFloat h = 20;
    
    self.hourLabel.frame = CGRectMake(0, 0, w,h);
    
    self.colonOne.frame = CGRectMake(CGRectGetMaxX(self.hourLabel.frame) - 2, 0, 4, h);
    
    self.miniteLabel.frame = CGRectMake(w, 0,w, h);
    
    self.colonTwo.frame = CGRectMake(CGRectGetMaxX(self.miniteLabel.frame) - 2, 0, 4, h);
    
    self.secondLabel.frame = CGRectMake(w * 2 , 0, w , h);
    
    self.indexLabel.frame  = CGRectMake(CGRectGetMaxX(self.secondLabel.frame), 0, w, h);
}

- (UILabel *)quickSetUpLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = gray999999;
    label.font = font(12);
    label.textAlignment = NSTextAlignmentCenter;
    [_leftTimeView addSubview:label];
    return label;
}

@end
