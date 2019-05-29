//
//  SPChooseView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPIndustryView.h"

@interface SPIndustryView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@end
@implementation SPIndustryView
{
    NSString *_title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGBCOLORA(0, 0, 0,0.4);
        
        [self getLoad];
        [self configUI];
    
    }
    return self;
}

-(void)configUI{
    [self addSubview:self.tableView];
}

-(void)getLoad{
    [[HttpRequest sharedClient]httpRequestGET:kUrlGetIndustryList parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        self.listArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 40, SCREEN_W-40,SCREEN_H-80) style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
//        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    NSDictionary *dic = self.listArray [indexPath.row];
    cell.textLabel.text = dic[@"value"];
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 100;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    SPChooseHeaderView *sectionHeader = [[SPChooseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frameWidth, 80) Title:_title];
////    //点击 X 退出
////    sectionHeader.SPChooseHeaderViewBlock = ^(NSInteger tag){
////        [UIView animateWithDuration:0.4 animations:^{
////            self.originY = SCREEN_H2;
////        }];
////    };
////    return sectionHeader;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 50;
//}
//
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frameWidth, 60)];
//    view.backgroundColor = [UIColor whiteColor];
//
//    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake( self.tableView.frameWidth/2-20, 5, 40, 40)];
//    [okBtn setImage:[UIImage imageNamed:@"grxx6_r4_c5"] forState:0];
//    [okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchDown];
//    [view addSubview:okBtn];
//    return view;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.listArray[indexPath.row];
    !self.chooseBlock?:self.chooseBlock(dic[@"value"]);
    [self quit];
}

//点击 确认按钮 退下
-(void)quit{
   
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }];
}
@end

