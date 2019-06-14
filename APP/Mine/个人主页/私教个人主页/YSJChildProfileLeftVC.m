//
//  YSJTeacherInfoView.m
//  SmallPig
//
//  Created by xujf on 2019/3/27.
//  Copyright © 2019年 lisen. All rights reserved.
//
#import "YSJUserModel.h"
#import "YSJMyRequimentCell.h"
#import "YSJChildProfileLeftVC.h"

@implementation YSJChildProfileLeftVC
{
    NSArray *_dataArr;
    
    NSMutableArray *_dataListArr;
    
    UIImageView *_img;
    
    UILabel *_name;
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor hexColor:@"F5F5F5"];
    
    [self initUI];
}

- (void)initUI{
    
    _dataArr = @[].mutableCopy;
    
    _dataListArr = @[@"个人介绍",@"需求课程"].mutableCopy;
    
    [self.view addSubview:self.tableView];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return self.model.classArr.count;
    }
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        YSJMyRequimentCell *cell = [YSJMyRequimentCell loadCode:tableView];
        cell.model = self.model.classArr[indexPath.row];
        return cell;
    }else{
        return [self normaleCellWithTableView:tableView indexPath:indexPath];
    }
    return nil;
}

-(UITableViewCell *)normaleCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [UITableViewCell loadCode:tableView];

    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, kWindowW-2*kMargin, [self.model.describe sizeWithFont:font(14) maxW:kWindowW-25].height+20)];
    text.text = self.model.describe;
    text.textColor = gray999999;
    text.font = font(14);
    text.numberOfLines = 0;
    [cell addSubview:text];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
       return [self.model.describe sizeWithFont:font(14) maxW:kWindowW-25].height+30;
    }
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25+13*2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin+kMargin, 0,kWindowW-40, 25+13*2)];
    title.backgroundColor = KWhiteColor;
    title.font = font(16);
    title.textColor = [UIColor hexColor:@"020433"];
    title.text = [NSString stringWithFormat:@"  %@",_dataListArr[section]];
    return title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(kMargin,0, SCREEN_W-24, SCREEN_H-348) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight, 0);
        _tableView.rowHeight = 70;
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.header;
       
    }
    return _tableView;
}

- (void)setModel:(YSJUserModel *)model{
    
    _model = model;
    
    if (model==NULL) {
        return;
    }
    
//    [_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,model.photo]]placeholderImage:[UIImage imageNamed:@"120"]];
//
//    _name.text = model.realname;
//
//    [_dataListArr removeAllObjects];
//
//    [_dataListArr addObject:model.describe];
//    [_dataListArr addObject:model.school];
//    [_dataListArr addObject:model.teach_time];
//    [_dataListArr addObject:model.qualifications];
//
//    [self.tableView reloadData];
}

@end
