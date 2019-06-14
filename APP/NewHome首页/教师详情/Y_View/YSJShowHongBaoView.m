//
//  YSJTeacherInfoView.m
//  SmallPig
//
//  Created by xujf on 2019/3/27.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJTeacherModel.h"
#import "YSJHongBaoCell.h"
#import "YSJShowHongBaoView.h"
#import "YSJGBModel.h"
#import "YSJCourseModel.h"

@implementation YSJShowHongBaoView
{
    NSArray *_dataArr;
    
    NSMutableArray *_dataListArr;
    
    UIImageView *_img;
    
    UILabel *_name;
    
}

- (void)initUI{
    
    _dataListArr = @[].mutableCopy;
    
    _dataArr = @[@"个人介绍",@"教育背景",@"教学时段",@"资质证书"];
    
    [self addSubview:self.header];
    
    [self addSubview:self.tableView];
    
    [self setCloseButton];
    
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.model.red_packet.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSJHongBaoCell *cell = [YSJHongBaoCell loadCode:tableView];
    if (self.type==1) {
          cell.type = HBTypeUse;
    }else{
          cell.type = HBTypeOnlyGet;
    }
  
    cell.model = self.model.red_packet[indexPath.row];
    cell.block = ^{
        
        self.block(indexPath.row);
        
        [self shat];
    };
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20,SafeAreaStateHeight+10+94/2+100, SCREEN_W-40, SCREEN_H2-SafeAreaStateHeight-KBottomHeight-50-10-(94/2+100)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _tableView.rowHeight =96+70+18-35;
        
        _tableView.separatorColor = [UIColor whiteColor];
        
        _tableView.showsVerticalScrollIndicator = NO;
    
    }
    return _tableView;
}

- (UIView *)header{
    if (!_header) {
        
        CGFloat imgWid = 94;
        CGFloat imgH = 94;
        
        _header = [[UIView alloc]initWithFrame:CGRectMake(20, SafeAreaStateHeight+10, kWindowW-40, imgH/2+100)];
        _header.backgroundColor = [UIColor clearColor];
        _header.clipsToBounds = YES;
        
        UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0, imgH/2+5, kWindowW-40, 100+54)];
        downView.layer.cornerRadius = 8;
        downView.clipsToBounds = YES;
        downView.backgroundColor = KWhiteColor;
        [_header addSubview:downView];
        
        _name = [[UILabel alloc]init];
        _name.font = Font(22);
        _name.text = @"专享红包";
        [downView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.height.offset(20);
            make.top.offset(imgH/2+10);
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

- (void)setModel:(YSJTeacherModel *)model{
    _model = model;
    if (model==NULL) {
        return;
    }
    
    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"120"]];
    
    [self.tableView reloadData];
}

- (void)setHbArr:(NSMutableArray *)hbArr{
    _hbArr = hbArr;
    self.model = [[YSJTeacherModel alloc]init];
    self.model.red_packet = hbArr;
    [self.tableView reloadData];
}

@end
