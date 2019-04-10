//
//  SPMyTagVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/6/7.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMyHeader.h"
#import "SPTagCell.h"
#import "SPThirdLevelVC.h"
#import "SPKungFuModel.h"
#import "SPChooseView.h"
#import "SPMyTagVC.h"
#import "SPPrefectPhotosVC.h"
#import "SPMyInterestVC.h"

@interface SPMyTagVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)SPMyHeader *tableHeader;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic ,strong)SPChooseView *chooseView;

@end

@implementation SPMyTagVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //背景图片
    [self setBaseImgViewWithImgage:[UIImage imageNamed:@"gr_sex"]];
    //tableview
    [self.view insertSubview:self.tableView atIndex:1];
    //myHeader
    [self.view insertSubview:self.tableHeader atIndex:2];
    //请求数据
    [self loadData];
}

#pragma  mark - 请求数据
-(void)loadData{
    NSLog(@"%@",kUrllistTag);
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    [dict setObject:TAG forKey:@"rootType"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:listTagsByUser parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
//        NSLog(@"%@",responseObject[@"data"]);
        self.listArray = (NSMutableArray*)[SPKungFuModel objectArrayWithKeyValuesArray:responseObject[@"data"]];
        for (SPKungFuModel *model1 in self.listArray) {
            //初始化都 折叠
            model1.flag = @"NO";
            //一定要先初始化一下，不然为空
            if (model1.thirdLevelArr==nil) {
                model1.thirdLevelArr = [[NSMutableArray alloc]init];
            }
            for (SPKungFuModel *model2 in model1.subProperties) {
                if (model2.selected) {
                    [model1.thirdLevelArr addObject:model2];
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma  mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPTagCell*cell = [tableView dequeueReusableCellWithIdentifier:SPTagCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SPTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPTagCellID];
    }
    SPKungFuModel *model1 = self.listArray[indexPath.row];
    cell.model = model1;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPKungFuModel *model1 = self.listArray[indexPath.row];
    
    if (model1.thirdLevelArr.count==0) {
        return 40;
    }
    return model1.thirdLevelArr.count/4*40+(model1.thirdLevelArr.count%4==0?0:1)*40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPKungFuModel *model1 = self.listArray[indexPath.row];
   
    [self.chooseView loadWithCode:nil withAllArray:model1.subProperties haveChosedArr:model1.thirdLevelArr headerTitle:model1.value];
    WeakSelf;
    self.chooseView.chooseBlock = ^(NSArray *arr){
        
        //将选中的数组，传给模型
        model1.thirdLevelArr = (NSMutableArray *)arr;
        //更新相关界面
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
        [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    };
    [UIView animateWithDuration:0.4 animations:^{
        self.chooseView.frame = self.view.bounds;
    }];
    return;
//    
//    SPThirdLevelVC *vc= [[SPThirdLevelVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//    
    //    NSLog(@"%@", [[[[self.listArray objectAtIndex:indexPath.section] objectForKey:@"city"] objectAtIndex:indexPath.row] objectForKey:@"name"]);
    //
    //    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
    // 下面方法更好使
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma  mark - setter

//选择标签View
-(SPChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[SPChooseView alloc]initWithFrame:CGRectMake(0, SCREEN_H2, SCREEN_W, SCREEN_H)];
        [self.view addSubview:_chooseView];
    }
    return _chooseView;
}

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        
        _listArray = [NSMutableArray array];
        
    }
    return _listArray;
}

-(UITableView *)tableView{
    if (!_tableView ) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,headerHeight1, SCREEN_W, SCREEN_H2-headerHeight1) style:UITableViewStylePlain];
        _tableView.alpha = 0.9;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
        _tableView.contentInset =  UIEdgeInsetsMake(0, 0, 80, 0);
    }
    return _tableView;
}

-(SPMyHeader *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[SPMyHeader alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, headerHeight1)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        _tableHeader.alpha = 0.9;
        [_tableHeader setImg:[UIImage imageNamed:@"tag"]];
      
    }
    return _tableHeader;
}

-(void)jump{
    [self pushViewCotnroller:NSStringFromClass([SPMyInterestVC class])];
}

-(void)next{
    self.needShow = NO;
    NSMutableArray *skillArr = [[NSMutableArray alloc]init];
    //二级遍历，将选择的标签 存储到数组
    for (SPKungFuModel *model1 in self.listArray) {
        
            if (model1.thirdLevelArr.count!=0) {
                for (SPKungFuModel *model2 in model1.thirdLevelArr) {
                    [skillArr addObject:[NSString stringWithFormat:@"%@:%@:%@",model2.code,model2.value,model1.code]];
                }
            }
    }
    //将数组元素 用 "," 拼接（  ）
    NSString *skillSrt = [skillArr componentsJoinedByString:@","];
    NSLog(@"%@",skillSrt);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:skillSrt forKey:@"tagsStr"];
    [self postMessage:dict pushToVC:NSStringFromClass([SPPrefectPhotosVC class])];
}

-(void)back{
    //拦截返回按钮 显示提示框
    [self showAliterView];
}

-(void)save{
    self.needShow = NO;
    NSMutableArray *skillArr = [[NSMutableArray alloc]init];
    //二级遍历，将选择的标签 存储到数组
    for (SPKungFuModel *model1 in self.listArray) {
        
        if (model1.thirdLevelArr.count!=0) {
            for (SPKungFuModel *model2 in model1.thirdLevelArr) {
                [skillArr addObject:[NSString stringWithFormat:@"%@:%@:%@",model2.code,model2.value,model1.code]];
            }
        }
    }
    //将数组元素 用 "," 拼接（  ）
    NSString *skillSrt = [skillArr componentsJoinedByString:@","];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:skillSrt forKey:@"tagsStr"];
    [self postMessage:dict pushToVC:@"pop"];
}
@end

