//
//  SPChooseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPChooseView.h"
#import "SPChooseCell.h"
#import "SPChooseHeaderView.h"
#import "SPKungFuModel.h"

@interface SPChooseView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@end
@implementation SPChooseView
{
    NSString *_title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLORA(0, 0, 0,0.4);
        [self configUI];
    }
    return self;
}

-(void)configUI{
    [self addSubview:self.tableView];
}

-(void)loadWithCode:(NSString *)code withAllArray:(NSArray *)allArr haveChosedArr:(NSMutableArray *)choosedArr headerTitle:(NSString *)title{
    
    //将数组传给本类数据源
    self.listArray = (NSMutableArray*)allArr;
    
    //标题
    _title = title;
    
    /** 双遍历 全部Model 和传过来的 model ,相同，则 将falg设置为YES,显示对勾*/
    for (SPKungFuModel *model in self.listArray) {
        model.flag = @"NO";
        for (SPKungFuModel *choosedModel in choosedArr) {
            if ([choosedModel.code isEqualToString: model.code]) {
                model.flag = @"YES";
            }
        }
    }
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    [self.tableView reloadData];
}
#pragma  mark - setter
- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        
        _listArray = [NSMutableArray array];
        
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_W-40, SCREEN_H2-80)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorColor = [UIColor clearColor];
//        [_tableView registerClass:[S class] forCellReuseIdentifier:SPKungFuCellID];
   
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:SPChooseCellID];
    if (cell==nil) {
        cell = [[SPChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPChooseCellID];
    }
    SPKungFuModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SPChooseHeaderView *sectionHeader = [[SPChooseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frameWidth, 80) Title:_title];
    //点击 X 退出
    sectionHeader.SPChooseHeaderViewBlock = ^(NSInteger tag){
        [UIView animateWithDuration:0.4 animations:^{
            self.originY = SCREEN_H2;
        }];
    };
    return sectionHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frameWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake( self.tableView.frameWidth/2-20, 5, 40, 40)];
    [okBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
    [okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchDown];
    [view addSubview:okBtn];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    SPKungFuModel *model = self.listArray [indexPath.row];
    if ([model .flag isEqualToString:@"NO"]) {
        model.flag = @"YES";
    }else{
        model.flag = @"NO";
    }
    [self.tableView reloadData];
}

//点击 确认按钮 退下
-(void)ok{
    NSMutableArray *chooseArr = [[NSMutableArray alloc]init];
    
    for (SPKungFuModel *model in self.listArray) {
        if ([model.flag isEqualToString:@"YES"]) {
            [chooseArr addObject:model];
        }
    }
    NSLog(@"%@",chooseArr);
    !self.chooseBlock?:self.chooseBlock(chooseArr);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }];
}
@end
