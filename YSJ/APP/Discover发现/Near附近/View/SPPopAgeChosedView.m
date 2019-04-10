//
//  SPCategoryChoseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPPopAgeChosedView.h"

static CGFloat tabWid = 300;

@interface SPPopAgeChosedView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray*listArray1;

@property(nonatomic,strong)UITableView*levelTab1;

@end

@implementation SPPopAgeChosedView
{
    NSInteger _index;
    NSArray *_parameterArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.listArray1 = @[@"25岁以下",@"25-35岁",@"35岁以上"];
       
        _parameterArr = @[@"LESS",@"BETWEEN",@"ABOVE"];
        
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    //base
    UIView *base1 = [self baseView];
    
    [base1 addSubview:[self shatBtn]];
    
    [base1 addSubview:self.levelTab1];
   
    [base1 addSubview:[self confirmBtn]];
}

#pragma  mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.listArray1.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.listArray1[indexPath.row];
    
    cell.textLabel.font = kFontNormal;
    
    if (_index == indexPath.row+1000) {
        [cell.imageView setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"]];
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@""]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _index = indexPath.row+1000;
    [_levelTab1 reloadData];
}

#pragma  mark - action

-(void)confirmClick{
    
    if (_index!=0) {
    self.block(_listArray1[_index-1000],_parameterArr[_index-1000]);
    }
    
    [self shat];
}

-(void)shat{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = SCREEN_H+100;
    }];
}

#pragma  mark - setter

#pragma  mark 关闭按钮

-(UIButton *)shatBtn {
    UIButton *shat = [[UIButton alloc]initWithFrame:CGRectMake(0, 5,300,44)];
    [shat setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
    //    [shat setTitle:@"武功" forState:0];
    [shat addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    return shat;
}

-(UIView *)baseView{
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_W-300)/2,SCREEN_H/2-170, 300,340+60)];
    base.layer.cornerRadius = 5;
    base.clipsToBounds= YES;
    base.backgroundColor = [UIColor whiteColor];
    base.center = self.center;
    [self addSubview:base];
    return base;
}

-(UITableView *)levelTab1{
    if (!_levelTab1 ) {
        
        _levelTab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 50,tabWid,300) style:UITableViewStyleGrouped];
        
        _levelTab1.delegate = self;
        _levelTab1.dataSource = self;
        _levelTab1.rowHeight = 40;
        _levelTab1.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
    }
    return _levelTab1;
}

-(UIButton *)confirmBtn{
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(0, 355,tabWid, 44)];
    [confirm setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchDown];
    return confirm;
}

@end

