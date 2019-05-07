//
//  SPCategoryChoseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/7/13.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "YSJPopTeachTypeView.h"
#import "YSJCourseTypeModel.h"

static CGFloat tabWid = 150;

@interface YSJPopTeachTypeView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray*listArray1;

@property(nonatomic,strong)UITableView*levelTab1;

@property(nonatomic,strong)UITableView*levelTab2;

@end

@implementation YSJPopTeachTypeView
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
    [[HttpRequest sharedClient]httpRequestGET:YAllCourseType parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);

        
        self.listArray1 = [YSJCourseTypeModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        int i = 0;
        
        for (YSJCourseTypeModel *model1 in self.listArray1) {
            
            NSDictionary *di = responseObject[i];
            NSMutableArray *arr2 = [[NSMutableArray alloc]init];
            for (NSString *str2 in di[@"coursetypes_value"]) {
                YSJCourseTypeModel *model2 = [[YSJCourseTypeModel alloc]init];
                model2.value = str2;
                [arr2 addObject:model2];
            }
            model1.subProperties = arr2;
            i++;
        }
        
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
    UIButton *confirm = [self confirmBtn];
    [base1 addSubview:confirm];
    [confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.offset(60);
        make.height.offset(50);
        make.top.equalTo(base1).offset(0);
    }];
    
}

#pragma  mark - tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.levelTab1) {
        
        return self.listArray1.count;
        
    }else{
        
        if (self.listArray1.count == 0)  return 0;
        
        YSJCourseTypeModel *model = self.listArray1[_index];
        return model.subProperties.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = font(14);
        cell.textLabel.textColor = black666666;
    }
    
    if (tableView == self.levelTab1) {
        YSJCourseTypeModel *model1 = self.listArray1[indexPath.row];
        [self setModel:model1 ForCell:cell tableView:tableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        YSJCourseTypeModel *model1 = self.listArray1[_index];
        YSJCourseTypeModel *model2 = model1.subProperties[indexPath.row];
        [self setModel:model2 ForCell:cell tableView:tableView];
    }
    
    return cell;
}

-(void)setModel:(YSJCourseTypeModel *)model ForCell:(UITableViewCell *)cell tableView:(UITableView *)tableView{
    
    if (model.chosed && tableView == self.levelTab2) {
        
        [cell.imageView setImage:[UIImage imageNamed:@"duigou12"]];
        cell.textLabel.textColor =KMainColor;
    }else{
        [cell.imageView setImage:[UIImage imageNamed:@""]];
        cell.textLabel.textColor = gray999999;
    }
    cell.textLabel .text = model.value;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.levelTab1) {
        //一级点击
        _index = indexPath.row;
        
        [self.levelTab2 reloadData];
        YSJCourseTypeModel *model1  = self.listArray1[_index];
       NSLog(@"%@", [model1 mj_JSONObject]);
        
    }else{
        
        //二级点击
        YSJCourseTypeModel *model1  = self.listArray1[_index];
        YSJCourseTypeModel *model2 = model1.subProperties[indexPath.row];
        
        //改变选中状态
        model2.chosed = !model2.chosed;
        
        //根据二级的选择情况 判定一级需不需要被选中
        [self  setTab1ChosedWithModel1:model1];
        
        [self.levelTab2 reloadData];
        
        /** type
         0：多选
         1：只能选择一个
         */
        if (self.type==1) {
            [self confirmClick];
            //单选 要把这个chose置于NO
            model2.chosed = NO;
        }
        
    }
}

//根据二级的选择情况 判定一级需不需要被选中
-(void)setTab1ChosedWithModel1:(YSJCourseTypeModel *)model1{
    BOOL choseTab1 = NO;
    for (YSJCourseTypeModel *model22 in model1.subProperties) {
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
    
    for (YSJCourseTypeModel *mode1 in self.listArray1) {
        if (mode1.chosed) {
            for (YSJCourseTypeModel *mode2 in mode1.subProperties){
                if (mode2.chosed) {
                    [chosedArr addObject:[NSString stringWithFormat:@"%@-%@",mode1.value,mode2.value]];
                }
            }
        }
    }
    !self.block?:self.block(chosedArr);
}

-(void)shat{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = SCREEN_H+100;
    }];
}

#pragma  mark - setter


-(UIView *)baseView{
    UIView *base = [[UIView alloc]initWithFrame:CGRectMake(0,0, tabWid*2,350+0)];
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
        
        _levelTab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 50,tabWid,300) style:UITableViewStyleGrouped];
        _levelTab1.backgroundColor = grayF2F2F2;
        _levelTab1.separatorColor = grayF2F2F2;
        _levelTab1.delegate = self;
        _levelTab1.dataSource = self;
        _levelTab1.rowHeight = 40;
        _levelTab1.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        _levelTab1.showsVerticalScrollIndicator = NO;
        _levelTab1.showsHorizontalScrollIndicator = NO;
    }
    return _levelTab1;
}

-(UITableView *)levelTab2{
    if (!_levelTab2 ) {
        _levelTab2 = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.levelTab1.frame)+1,50, tabWid, 300)style:UITableViewStyleGrouped];
        _levelTab2.showsVerticalScrollIndicator = NO;
        _levelTab2.showsHorizontalScrollIndicator = NO;
        _levelTab2.delegate = self;
        _levelTab2.dataSource = self;
        _levelTab2.rowHeight = 40;
        _levelTab2.backgroundColor = grayF2F2F2;
        _levelTab2.separatorColor = grayF2F2F2;
        _levelTab2.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0);
        //        [_tableView registerClass:[S class] forCellReuseIdentifier:SPKungFuCellID];
        
    }
    return _levelTab2;
}

-(UIButton *)shatBtn {
    
    UIButton *shat = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,300,50)];
    shat.backgroundColor = KMainColor;
    [shat setTitle:@"可授课程" forState:0];
    return shat;
}

-(UIButton *)confirmBtn{
    
    UIButton *confirm = [[UIButton alloc]init];
    [confirm setTitle:@"确定" forState:0];
    confirm.titleLabel.font = font(14);
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
