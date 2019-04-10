//
//  SPExpOfficeTimeCell.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/18.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPExperienceForMakeMoneryCell.h"
#import "JXAlertview.h"
#import "SPSkillWorkExp.h"

#import "CustomMonthDatePicker.h"
//static CGFloat normalCellH = 45;

@interface SPExperienceCell <UITextFieldDelegate>

@end

@implementation SPExperienceForMakeMoneryCell

{
    UILabel *_textLabForCompany;
    
    UILabel *_textLabForCity;
    UILabel *_resultLabForCity;
    
    UILabel *_textLabForIndustry;
    UILabel *_resultLabForIndustry;
    
    UILabel *_textLabForJob;
   
    UILabel *_textLabForTime;
    UIButton *_startTime;
    UIButton *_endTime;
    UIButton *_onJob;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    SPExperienceForMakeMoneryCell *cell = [tableView dequeueReusableCellWithIdentifier:SPExperienceForMakeMoneryCellID forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[SPExperienceForMakeMoneryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPExperienceForMakeMoneryCellID];
        //        cell.clipsToBounds = YES;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setUI];
        self.backgroundColor = HomeBaseColor;
    }
    return self;
}

-(void)setUI{
    [self row0];
    [self row1];
    [self row2];
    [self row3];
    [self row4];
}

-(void)row0{
    UIView *baseViewForCompany = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,45)];
    baseViewForCompany.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseViewForCompany];
    
    _textLabForCompany = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 45)];
    _textLabForCompany.text = @"公司全称";
    _textLabForCompany.textColor = [UIColor blackColor];
    _textLabForCompany.font = kFontNormal_14;
    [baseViewForCompany addSubview:_textLabForCompany];
    
    _textFiledForCompany = [[UITextField alloc]initWithFrame:CGRectMake(100+kMargin, 0, SCREEN_W-100-10-kMargin, 45)];
    _textFiledForCompany.delegate = self;
    _textFiledForCompany.placeholder = @"请输入公司名称";
    [baseViewForCompany addSubview:_textFiledForCompany];
}

-(void)row1{
    UIView *baseViewForCity = [[UIView alloc]initWithFrame:CGRectMake(0, 46, SCREEN_W, 45)];
    baseViewForCity.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseViewForCity];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCity)];
    tap.numberOfTouchesRequired = 1;
    [baseViewForCity addGestureRecognizer:tap];
    
    _textLabForCity = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 45)];
    _textLabForCity.font = kFontNormal_14;
    _textLabForCity.text = @"工作城市";
//    _textLabForCity.backgroundColor = [UIColor orangeColor];
    _textLabForCity.textColor = [UIColor blackColor];
    [baseViewForCity addSubview:_textLabForCity];
    
    _resultLabForCity = [[UILabel alloc]initWithFrame:CGRectMake(100+kMargin, 0, SCREEN_W-100-10-kMargin-25,45)];
    _resultLabForCity.font= font(13);
    _resultLabForCity.backgroundColor =[UIColor whiteColor];
    _resultLabForCity.textAlignment = NSTextAlignmentRight;
    _resultLabForCity.textColor = [UIColor grayColor];
    [baseViewForCity addSubview:_resultLabForCity];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-30, 5, 20, 45-10)];
    [arrow setImage:[UIImage imageNamed:@"sy_ryf"]];
    [baseViewForCity addSubview:arrow];
}

-(void)row2{
    UIView *baseViewForIndustry = [[UIView alloc]initWithFrame:CGRectMake(0, 92, SCREEN_W, 45)];
    baseViewForIndustry.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseViewForIndustry];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIndustry)];
    tap.numberOfTouchesRequired = 1;
    [baseViewForIndustry addGestureRecognizer:tap];
    
    _textLabForIndustry = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 45)];
    _textLabForIndustry.font = kFontNormal_14;
    _textLabForIndustry.text = @"所属行业";
    _textLabForIndustry.textColor = [UIColor blackColor];
    [baseViewForIndustry addSubview:_textLabForIndustry];
    
    _resultLabForIndustry = [[UILabel alloc]initWithFrame:CGRectMake(100+kMargin, 0, SCREEN_W-100-10-kMargin-25,45)];
    _resultLabForIndustry.font= font(13);
    _resultLabForIndustry.backgroundColor =[UIColor whiteColor];
    _resultLabForIndustry.textAlignment = NSTextAlignmentRight;
    _resultLabForIndustry.textColor = [UIColor grayColor];
    [baseViewForIndustry addSubview:_resultLabForIndustry];
    
    UIImageView *arrow2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W-30, 5, 20, 45-10)];
    [arrow2 setImage:[UIImage imageNamed:@"sy_ryf"]];
    [baseViewForIndustry addSubview:arrow2];
}

-(void)row3{
    UIView *baseViewForjob= [[UIView alloc]initWithFrame:CGRectMake(0, 92+46, SCREEN_W, 45)];
    baseViewForjob.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseViewForjob];
    
    _textLabForJob = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 45)];
    _textLabForJob.text = @"职位名称";
    _textFiledForJob.textColor = [UIColor blackColor];
    _textLabForJob.font = kFontNormal_14;
    [baseViewForjob addSubview:_textLabForJob];
    
    _textFiledForJob = [[UITextField alloc]initWithFrame:CGRectMake(100+kMargin, 0, SCREEN_W-100-10-kMargin, 45)];
    _textFiledForJob.delegate = self;
    _textFiledForJob.placeholder = @"请输入职位";
    [baseViewForjob addSubview:_textFiledForJob];
}

-(void)row4{
    UIView *baseViewForTime = [[UIView alloc]initWithFrame:CGRectMake(0, 92+46+46, SCREEN_W, 70)];
    baseViewForTime.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:baseViewForTime];
    
    _textLabForTime = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 30)];
    _textLabForTime.text = @"任职时间";
    _textLabForTime.font = kFontNormal_14;
    [baseViewForTime addSubview:_textLabForTime];
    
    CGFloat btnW = 80;
    UIButton *startTime = [[UIButton alloc]initWithFrame:CGRectMake(15, 30, 80, 40)];
    startTime.backgroundColor = [UIColor whiteColor];
    [startTime setTitle:@"开始时间" forState:0];
    startTime.tag = 0;
    _startTime = startTime;
    [startTime setTitleColor:[UIColor grayColor] forState:0];
    startTime.titleLabel.font = font(13);
    [startTime addTarget:self action:@selector(timeChose:) forControlEvents:UIControlEventTouchDown];
    [baseViewForTime addSubview:startTime];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(95, 30, 30, 40)];
    line.text = @"——";
    line.adjustsFontSizeToFitWidth=YES;
    [baseViewForTime addSubview:line];
    
    UIButton *endTime = [[UIButton alloc]initWithFrame:CGRectMake(125, 30, 80, 40)];
    endTime.backgroundColor = [UIColor whiteColor];
    [endTime setTitle:@"结束时间" forState:0];
    [endTime setTitleColor:[UIColor grayColor] forState:0];
    endTime.titleLabel.font = font(13);
    endTime.tag=1;
    _endTime = endTime;
    [endTime addTarget:self action:@selector(timeChose:) forControlEvents:UIControlEventTouchDown];
    [baseViewForTime addSubview:endTime];
    
    UIButton *onJob = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-80, 30, 70, 40)];
    onJob.backgroundColor = [UIColor whiteColor];
    _onJob = onJob;
    //    [onJob setImage:[UIImage imageNamed:@""] forState:0];
    //    [onJob setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [onJob setTitleColor:[UIColor blackColor] forState:0];
    [onJob setTitle:@"目前在职" forState:0];
    [onJob setImage:[UIImage imageNamed:@"fa_xx_djw"] forState:0];
    [onJob setImage:[UIImage imageNamed:@"fb_xx_dj"] forState:UIControlStateSelected];
    onJob.titleLabel.font = font(13);
    [onJob addTarget:self action:@selector(onJob:) forControlEvents:UIControlEventTouchDown];
    [baseViewForTime addSubview:onJob];
}

#pragma  mark - -----------------action-----------------

-(void)onJob:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    self.expModel.working = btn.selected;
}

-(void)timeChose:(UIButton *)btn{
        
    [self.delegate SPExperienceCellDelegateDidSelectedIndexPath:self.indexPath WithType:btn.tag andStringType:@"任职时间"];
}


-(void)tapCity{
    
    [self.delegate SPExperienceCellDelegateDidSelectedIndexPath:self.indexPath WithType:0 andStringType:@"城市"];
}

-(void)tapIndustry{
    [self.delegate SPExperienceCellDelegateDidSelectedIndexPath:self.indexPath WithType:0 andStringType:@"行业"];
}

#pragma  mark - -----------------UITextFieldDelegate-----------------
- (void)textFieldDidEndEditing:( UITextField *)textField{
    if (textField==_textFiledForCompany) {
        self.expModel.companyName = textField.text;
    }else if (textField == _textFiledForJob){
        self.expModel.jobTitle = textField.text;
    }
}

#pragma  mark   - 模型赋值
-(void)setExpModel:(SPSkillWorkExp *)expModel{
    if (!expModel) {
        return;
    }
    _expModel = expModel;
    
    _textFiledForCompany.text = expModel.companyName;
    
    _resultLabForCity.text = expModel.workCity;
    
    _resultLabForIndustry.text = expModel.industry;
    
    _textFiledForJob.text = expModel.jobTitle;
    
    if (!isEmptyString(expModel.workBeginTime)) {
        [_startTime setTitle:expModel.workBeginTime forState:0];
    }else{
         [_startTime setTitle:@"开始时间" forState:0];
    }
    
    if(!isEmptyString(expModel.workEndTime)){
        [_endTime setTitle:expModel.workEndTime forState:0];
    }else{
         [_endTime setTitle:@"结束时间" forState:0];
    }
    
    _onJob.selected = expModel.working;
}


@end


