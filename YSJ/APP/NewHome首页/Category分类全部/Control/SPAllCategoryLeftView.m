
#import "SPAllCategoryLeftView.h"
#import "SPCategoryLeftCell.h"
#import "SPKungFuModel.h"

#define SCCellTextFont [UIFont systemFontOfSize:15]

@interface SPAllCategoryLeftView ()

@property (nonatomic, weak) SPKungFuModel *selectedCategory;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSArray *categories;

@end

@implementation SPAllCategoryLeftView

static NSString * const SPCategoryLeftCellID = @"categoryId1";

#pragma  mark - life-cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.frameWidth = 100;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;// 去除分割线
    self.tableView.showsVerticalScrollIndicator = NO;// 取消滚动条
    self.tableView.rowHeight=60;
    [self.tableView registerClass:[SPCategoryLeftCell class] forCellReuseIdentifier:SPCategoryLeftCellID];
    _selectedIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    self.isfirstLoadVc=YES;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    // 返回本页面时，重新选中原来的选项
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    if (self.isfirstLoadVc) {
        // 加载即选中第一行
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
    self.isfirstLoadVc=NO;
}

#pragma  mark -重新加载最近数据
-(void)reloadMyTableView{
    //刷新tableView
    [self.tableView reloadData];
    // 选中当前选中的行数
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    // 发送通知给collectionView,传递参数，---二级分类的显示数据。
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCategorySelected object:@(_selectedIndexPath.row)];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPCategoryLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:SPCategoryLeftCellID];
    if (cell==nil) {
        cell = [[SPCategoryLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPCategoryLeftCellID];
    }
    
    cell.model = self.dataArr[indexPath.row];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row>=self.dataArr.count) {
        return;
    }
    // 保存所选cell位置
    _selectedIndexPath = indexPath;
    
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    // 取出分类id
   SPKungFuModel*selectedCategory = self.dataArr[indexPath.row];

    _selectedCategory = selectedCategory;
    // 发送通知,传递参数cid
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCategorySelected object:@(indexPath.row)];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - 初始化
- (instancetype)init {
    return [super initWithStyle:UITableViewStylePlain];
}

-(void)selectedIndex:(NSInteger)section{
    if (section>=self.dataArr.count) {
        return;
    }
 [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];

}
@end
