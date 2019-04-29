//
//  SPCategoryChoseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSiftingKungFu.h"
#import "SPKungFuModel.h"
static CGFloat tabWid = 150;
@interface SPSiftingKungFu ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray*listArray1;

@property(nonatomic,strong)UITableView*levelTab1;
@property(nonatomic,strong)UITableView*levelTab2;

@end

@implementation SPSiftingKungFu
{
    NSInteger _index;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
        [self load];
    }
    return self;
}

//请求一二级数据
-(void)load{
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",kUrlBase,@"/v1/user/listSkills/false"] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        self.listArray1 = [SPKungFuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        _index = 0;
        [self.levelTab1 reloadData];
        [self.levelTab2 reloadData];
        [self.levelTab1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [MBProgressHUD hideHUDForView:self animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)sUI{
    
    //base
    UIView *base1 = [self baseView];
    
    [base1 addSubview:[self shatBtn]];
    [base1 addSubview:self.levelTab1];
    [base1 addSubview:self.levelTab2];
    [base1 addSubview:[self confirmBtn]];
}

#pragma  mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.levelTab1) {
        
        return self.listArray1.count;
        
    }else{
        
        if (self.listArray1.count == 0)  return 0;
        
        SPKungFuModel *model = self.listArray1[_index];
        return model.subProperties.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (tableView == self.levelTab1) {
        SPKungFuModel *model1 = self.listArray1[indexPath.row];
        [self setModel:model1 ForCell:cell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        SPKungFuModel *model1 = self.listArray1[_index];
        SPKungFuModel *model2 = model1.subProperties[indexPath.row];
        [self setModel:model2 ForCell:cell];
    }
    cell.textLabel.font = kFontNormal;
    
    return cell;
}

-(void)setModel:(SPKungFuModel *)model ForCell:(UITableViewCell *)cell{
    if (model.chosed) {
        [cell.imageView setImage:[UIImage imageNamed:@"grxx6_r4_c5-1"]];
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@""]];
    }
    cell.textLabel .text = model.value;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.levelTab1) {
        //一级点击
        _index = indexPath.row;
        
        [self.levelTab2 reloadData];
        
    }else{

        //二级点击
        SPKungFuModel *model1  = self.listArray1[_index];
        SPKungFuModel *model2 = model1.subProperties[indexPath.row];
        
        //改变选中状态
        model2.chosed = !model2.chosed;
        
        //根据二级的选择情况 判定一级需不需要被选中
        [self  setTab1ChosedWithModel1:model1];
        
        [self.levelTab1 reloadData];
        [self.levelTab2 reloadData];
    }
}

//根据二级的选择情况 判定一级需不需要被选中
-(void)setTab1ChosedWithModel1:(SPKungFuModel *)model1{
    BOOL choseTab1 = NO;
    for (SPKungFuModel *model22 in model1.subProperties) {
        //只要二级有一个选中了，一级就被选中
        if (model22.chosed) {
            choseTab1 = YES;
        }
    }
    model1.chosed = choseTab1;
}

#pragma  mark - action

-(void)confirmClick{
    
    [self chosedResult];
    
    [self shat];
    
}

-(void)chosedResult{
    NSMutableArray *chosedArr = @[].mutableCopy;
    for (SPKungFuModel *mode1 in self.listArray1) {
        if (mode1.chosed) {
            for (SPKungFuModel *mode2 in mode1.subProperties){
                if (mode2.chosed) {
                    [chosedArr addObject:mode2.value];
                }
            }
        }
    }
    !self.siftingKungFuBlock?:self.siftingKungFuBlock(chosedArr);
}

-(void)shat{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = SCREEN_H+100;
    }];
}

#pragma  mark - setter

#pragma  mark 关闭按钮
-(UIButton *)shatBtn {
    UIButton *shat = [[UIButton alloc]initWithFrame:CGRectMake(0, 5,300,40)];
        [shat setImage:[UIImage imageNamed:@"grxx_r3_c1"] forState:0];
//    [shat setTitle:@"武功" forState:0];
    [shat addTarget:self action:@selector(shat) forControlEvents:UIControlEventTouchDown];
    return shat;
}

-(UIView *)baseView{
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_W-tabWid*2)/2,SCREEN_H/2-170, tabWid*2,340+60)];
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

-(UITableView *)levelTab2{
    if (!_levelTab2 ) {
        _levelTab2 = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.levelTab1.frame)+1,50, tabWid, 300)style:UITableViewStyleGrouped];
        _levelTab2.delegate = self;
        _levelTab2.dataSource = self;
        _levelTab2.rowHeight = 40;
        _levelTab2.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        //        [_tableView registerClass:[S class] forCellReuseIdentifier:SPKungFuCellID];
        
    }
    return _levelTab2;
}

-(UIButton *)confirmBtn{
    UIButton *confirm = [[UIButton alloc]initWithFrame:CGRectMake(0, 355,40, 50)];
    [confirm setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
    [confirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchDown];
    return confirm;
}

- (NSMutableArray *)listArray1
{
    if (_listArray1 == nil) {
        
        _listArray1 = [NSMutableArray array];
        
    }
    return _listArray1;
}
@end
