//
//  YSJTeacherInfoView.m
//  SmallPig
//
//  Created by xujf on 2019/3/27.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJTeacherModel.h"
#import "YSJTeacherInfoView.h"

@implementation YSJTeacherInfoView
{
    NSArray *_dataArr;
    
    NSMutableArray *_dataListArr;
    
    
    UIImageView *_img;
    
    UILabel *_name;
  
}

- (void)initUI{
    
    _dataListArr = @[].mutableCopy;
    
    _dataArr = @[@"个人介绍",@"教育背景",@"教学时段",@"资质证书"];
    
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
    UITableViewCell *cell = [UITableViewCell loadCode:tableView];
    cell.textLabel.text = _dataListArr[indexPath.section];
    cell.textLabel.textColor = gray999999;
    cell.textLabel.font = font(14);
    cell.textLabel.numberOfLines = 0;
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

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20,SafeAreaStateHeight+10, SCREEN_W-40, SCREEN_H2-SafeAreaStateHeight-KBottomHeight-50-10) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //        _tableView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, 0, 0);
        _tableView.rowHeight = 70;
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
        _img.backgroundColor = KMainColor;
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

- (void)setModel:(YSJTeacherModel *)model{
    _model = model;
    if (model==NULL) {
        return;
    }
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"placeholder2"]];
    _name.text = model.realname;
    [_dataListArr removeAllObjects];
    
    [_dataListArr addObject:model.describe];
    [_dataListArr addObject:model.school];
    [_dataListArr addObject:model.teach_time];
    [_dataListArr addObject:model.qualifications];
    
    [self.tableView reloadData];
}
@end
