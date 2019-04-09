//
//  SPSortView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/20.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSortView.h"

@interface SPSortView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SPSortView
{
    UITableView *_tableView;
    NSArray *_sortArr;
    NSArray *_correspindingFieldArr;//对应参数
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag=11;
        _sortArr = @[@"综合排序",@"距离最近",@"最新发布",@"人气最高",@"评价最多"];
        _correspindingFieldArr = @[@"DEFAULT",@"DISTINCE",@"TIME",@"READNUM",@"COMMENTNUM"];
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, 400) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag=11;
    _tableView.contentInset= UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.backgroundColor = RGBA(0, 0, 0, 0);
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    tapGestureRecognizer.numberOfTapsRequired = 1;
//    //    //将触摸事件添加到当前view
//        [_tableView addGestureRecognizer:tapGestureRecognizer];
}

//-(void)tap{
//    [UIView animateWithDuration:0.4 animations:^{
//        self.originY = SCREEN_H2;
//    }completion:^(BOOL finished) {
//
//    }];
//}
#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _sortArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
   
    cell.textLabel.text = _sortArr[indexPath.row];
    if (indexPath.row==self.index)
    {
        UIImageView *accessoryImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
        [accessoryImg setImage:[UIImage imageNamed:@"sy_px_xz"]];
        cell.accessoryView = accessoryImg;
         cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.accessoryView = [[UIView alloc]init];
         cell.textLabel.textColor = [UIColor darkGrayColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index = indexPath.row;
    
    [UIView animateWithDuration:0.4 animations:^{
         self.block(_correspindingFieldArr[indexPath.row]);
        self.originY = SCREEN_H2;
    }completion:^(BOOL finished) {
       
    }];
}

-(void)reloadTableView{
    [_tableView reloadData];
}
@end
