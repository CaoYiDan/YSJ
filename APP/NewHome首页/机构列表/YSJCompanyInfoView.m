//
//  YSJTeacherInfoView.m
//  SmallPig
//
//  Created by xujf on 2019/3/27.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJCompanyTeacherCell.h"
#import "YSJCompanysModel.h"
#import "YSJCompanyInfoView.h"
#import "NSString+getSize.h"
@implementation YSJCompanyInfoView
{
    NSArray *_dataArr;
    
    NSMutableArray *_dataListArr;
    
    
    UIImageView *_img;
    
    UILabel *_name;
    
}

- (void)initUI{
    
    _dataListArr = @[].mutableCopy;
    
    _dataArr = @[@"名师风采",@"品牌介绍",@"办学特色",@"营业时间"];
    
    [self addSubview:self.tableView];
    
    [self setCloseButton];
    
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        YSJCompanyTeacherCell *cell = [YSJCompanyTeacherCell loadCode:tableView];
        cell.listArr = _dataListArr[0];
        return cell;
    }
    UITableViewCell *cell = [UITableViewCell loadCode:tableView];
    cell.textLabel.text = _dataListArr[indexPath.section];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = gray999999;
    cell.textLabel.font = font(14);
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [cell.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    return cell;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self sectionHeaderAtSection:section];
}

// title
-(UIView *)sectionHeaderAtSection:(NSInteger)section{
    
    UIView *base  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-2*kMargin, 40)];
    base.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 100, 30)];
    title.numberOfLines = 0;
    title.text = _dataArr[section];
    title.font = BoldFont(18);
    [base addSubview:title];
    
    return base;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",_dataListArr);
    if (indexPath.section==0) {
        NSArray *arr = _dataListArr[0];
        if (arr.count==0) {
            return 10;
        }
        return 152;
    }else if (indexPath.section==1){
        return  [_dataListArr[1] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }else if (indexPath.section==2){
        return  [_dataListArr[2] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }else if (indexPath.section==3){
        return  [_dataListArr[3] sizeWithFont:font(14) maxW:kWindowW-120].height+30;
    }
    return 0;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20,SafeAreaStateHeight+10, SCREEN_W-2*20, SCREEN_H2-SafeAreaStateHeight-KBottomHeight-50-10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.header;
        
        _tableView.layer.cornerRadius = 8;
        _tableView.clipsToBounds = YES;
    }
    return _tableView;
}

- (UIView *)header{
    if (!_header) {
        
        CGFloat imgWid = 94;
        CGFloat imgH = 94;
        
        _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-23, imgH/2+100+24)];
        _header.backgroundColor = [UIColor clearColor];
        _header.clipsToBounds = YES;
        
        UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, imgH/2, kWindowW-24, 100+54)];
        downView.layer.cornerRadius = 8;
        downView.clipsToBounds = YES;
        downView.backgroundColor = KWhiteColor;
        [_header addSubview:downView];
        
        _name = [[UILabel alloc]init];
        _name.font = Font(16);
        _name.text = @"李森";
        [downView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.height.offset(20);
            make.top.offset(imgH/2+10);
        }];
        
        UIButton *sendMessage = [[UIButton alloc]init];
        [sendMessage setTitle:@"发消息" forState:0];
        [sendMessage setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [sendMessage setBackgroundImage:[UIImage imageNamed:@"more_btn"] forState:0];
        sendMessage.titleLabel.font = font(12);
        [sendMessage addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
        [downView addSubview:sendMessage];
        [sendMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_name.mas_bottom).offset(10);
            make.width.offset(106);
            make.height.offset(31);
            make.centerX.offset(0);
        }];
        
        _img =  [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 0, imgWid, imgH)];
        _img.backgroundColor = grayF2F2F2;
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.layer.cornerRadius = imgH/2;
        _img.clipsToBounds = YES;
        [_header addSubview:_img];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.offset(imgWid);
            make.height.offset(imgH);
            make.top.equalTo(_header).offset(0);
        }];
        
    }
    return  _header;
}

-(void)setCloseButton{
    UIButton *shatBtn = [[UIButton alloc]init];
    [shatBtn setImage:[UIImage imageNamed:@"close"] forState:0];
    [shatBtn addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    [self addSubview:shatBtn];
    [shatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(40);
        make.height.offset(40);
        make.top.equalTo(_tableView.mas_bottom).offset(5);
    }];
}

-(void)sendMessage{
    
}

- (void)setModel:(YSJCompanysModel *)model{
    _model = model;
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.venue_pic]]placeholderImage:[UIImage imageNamed:@"bg"]];
    _name.text = model.name;
    
    
    [_dataListArr removeAllObjects];
    [_dataListArr addObject:model.teacherArr];
    [_dataListArr addObject:model.describe];
    [_dataListArr addObject:model.feature];
    [_dataListArr addObject:model.datetime];
    
    [self.tableView reloadData];
}
@end
