//
//  SPCategoryChoseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "YSJDrawBackCauseView.h"

@interface YSJDrawBackCauseView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *listArray1;

@property(nonatomic,strong)UITableView*levelTab1;

@end

@implementation YSJDrawBackCauseView
{
    NSInteger _index;
    UIView *baseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _index = -1;
        [self sUI];
        [self load];
    }
    return self;
}

//请求一二级数据
-(void)load{
    
    self.listArray1 = @[@"买错了/重复下单",@"无法按时参加",@"课程不符合要求",@"课程与实际不符"].mutableCopy;
    
    
    [self.levelTab1 reloadData];
    
}

-(void)sUI{
    
    //base
    UIView *base1 = [self baseView];
    baseView = base1;
    [base1 addSubview:self.levelTab1];
   
    [self setTitle];
    
   [self confirmBtn];
    
}

#pragma  mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.listArray1.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = font(16);
        cell.textLabel.textColor = black666666;
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"未选择"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.listArray1[indexPath.row];
    if (_index == indexPath.row) {
          cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"选中"]];
    }else{
          cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"未选择"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    _index = indexPath.row;
    
    self.block(@[self.listArray1[indexPath.row]
                 ]);
    [self.levelTab1 reloadData];
    [self shat];
}

#pragma  mark - action

-(void)confirmClick{
    
    [self shat];
    
}

-(void)shat{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = SCREEN_H+100;
    }];
}

#pragma  mark - setter


-(UIView *)baseView{
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0,0, kWindowW,350+0)];
    base.layer.cornerRadius = 5;
    base.clipsToBounds= YES;
    base.backgroundColor = [UIColor whiteColor];
    base.centerX = self.centerX;
    base.centerY = self.centerY - SafeAreaTopHeight;
    [self addSubview:base];
    return base;
}

-(UITableView *)levelTab1{
    if (!_levelTab1 ) {
        
        _levelTab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,kWindowW,300) style:UITableViewStyleGrouped];
        _levelTab1.backgroundColor = KWhiteColor;
        _levelTab1.separatorColor = grayF2F2F2;
        _levelTab1.delegate = self;
        _levelTab1.dataSource = self;
        _levelTab1.rowHeight = 72;
        _levelTab1.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        _levelTab1.showsVerticalScrollIndicator = NO;
        _levelTab1.showsHorizontalScrollIndicator = NO;
    }
    return _levelTab1;
}
-(void)setTitle{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
    lab.textAlignment  = NSTextAlignmentCenter;
    lab.text = @"退款原因";
    lab.font  = font(16);
    lab.textColor = KBlack333333;
    [baseView addSubview:lab];
    
}

-(void)confirmBtn{
    
//    UIButton *confirm = [[UIButton alloc]init];
//    [confirm setTitle:@"确定" forState:0];
//    confirm.titleLabel.font = font(14);
//    confirm.layer.cornerRadius = 5;
//    confirm.clipsToBounds = YES;
//    confirm.backgroundColor = KMainColor;
//    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchDown];
//    [baseView addSubview:confirm];
//    [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.offset(kWindowW-2*kMargin);
//        make.left.offset(kMargin);
//        make.height.offset(50);
//        make.bottom.equalTo(baseView).offset(10);
//    }];
   
}

- (NSMutableArray *)listArray1
{
    if (_listArray1 == nil) {
        
        _listArray1 = [NSMutableArray array];
        
    }
    return _listArray1;
}
@end
