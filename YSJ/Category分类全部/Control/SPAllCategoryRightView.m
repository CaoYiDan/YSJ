//
//  SPAllCategoryRightView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/9/1.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPAllCategoryRightView.h"
#import "SPCategoryRightTabCell.h"
#import "SPKungFuModel.h"
@interface SPAllCategoryRightView ()

@property(nonatomic, assign)BOOL isScrollUp;//是否是向上滚动
@property(nonatomic, assign)CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量
@end

@implementation SPAllCategoryRightView
{
    NSMutableArray *_cellHeightArr;
    NSInteger _firstSelected;
}
#pragma  mark - -----------------life cycle-----------------
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(getNotificationget:) name:NotificationCategorySelected object:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - --------- 获取到通知 滚动到对应位置
- (void)getNotificationget:(NSNotification *)notification {

    NSInteger index=[notification.object integerValue];
    if (_firstSelected!=0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        _firstSelected = 1;
    }
    
    
}

#pragma  mark - 得到数据源

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr  = dataArr;
    //1.获取一个全局串行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //2.把任务添加到队列中执行
    dispatch_async(queue, ^{
//        计算出每个cell的高度
        [self getTableCellHeightArr];
        
        //3.回到主线程，创建UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //创建collectionView
            [self.tableView reloadData];
        });
        
    });

}

#pragma  mark - -----------------计算出每个cell的高度-----------------
-(void)getTableCellHeightArr{
    
    _cellHeightArr = @[].mutableCopy;
    
    int i=0;
    for (SPKungFuModel *model1 in self.dataArr) {
        CGFloat cellH = 0;
        for (SPKungFuModel *model2 in model1.subProperties) {
            cellH +=30;
            cellH+= model2.subProperties.count/3*80;
            cellH +=model2.subProperties.count%3==0?0:80;
        }
        cellH+=1;
        [_cellHeightArr addObject:@(cellH)];
        i++;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPCategoryRightTabCell *cell = [tableView dequeueReusableCellWithIdentifier:SPCategoryRightTabCellID];
    if (cell==nil) {
        cell = [[SPCategoryRightTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPCategoryRightTabCellID];
    }
    
   SPKungFuModel *model1 = self.dataArr[indexPath.section];
    cell.secondLevelDataArr =(NSMutableArray *)model1.subProperties;
    cell.type = self.type;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-100, 40)];
    headerLab.font = font(16);
    headerLab.textColor = [UIColor lightGrayColor];
    headerLab.backgroundColor = CategoryBaseColor;
    headerLab.textAlignment = NSTextAlignmentCenter;
    SPKungFuModel *model1 = self.dataArr[section];
    headerLab.text = [NSString stringWithFormat:@"——  %@  ——",model1.value];
    NSRange range = NSMakeRange(2, headerLab.text.length-4);
   [headerLab setAttributeTextWithString:headerLab.text range:range WithColour:[UIColor blackColor]];
    return headerLab;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==_cellHeightArr.count-1) {
        return [_cellHeightArr[indexPath.section] floatValue]<SCREEN_H?SCREEN_H:  [_cellHeightArr[indexPath.section] floatValue];
    }
    return _cellHeightArr.count ==0? 700:[_cellHeightArr[indexPath.section] floatValue];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] != _isScrollUp &&tableView.isDragging) {
        [self.delegate willDisplayHeaderView:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isScrollUp &&tableView.isDragging) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"_lastOffsetY : %f,scrollView.contentOffset.y : %f", _lastOffsetY, scrollView.contentOffset.y);
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
    NSLog(@"______lastOffsetY: %f", _lastOffsetY-scrollView.contentSize.height);
}
@end
