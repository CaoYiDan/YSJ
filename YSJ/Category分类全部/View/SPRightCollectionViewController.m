//
//
//#import "SPRightCollectionViewController.h"
//
//#import "SPDynamicCategoryCell.h"
//#import "SPKungFuModel.h"
//#import "XLPlainFlowLayout.h"
//@interface SPRightCollectionViewController ()
//
//// 数据源数组
//@property (nonatomic, strong) NSMutableArray *detailCategoryList;
//
//@end
//
//@implementation SPRightCollectionViewController
//{
//    UICollectionReusableView *_monthHeader;
//}
//
//static NSString * const reuseIdentifierForCell       = @"Cell";
//
////
//#pragma mark - life cycle
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.collectionView.backgroundColor =[UIColor whiteColor];
//    __unsafe_unretained UICollectionView *tableView = self.collectionView;
//    //头部刷新
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    tableView.mj_header=header;
//    self.collectionView.bounces=YES;
//    // 注册cell
//    [self.collectionView registerClass:[SPDynamicCategoryCell class] forCellWithReuseIdentifier:SPDynamicCategoryCellID];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"section"];
//
//    self.collectionView.showsVerticalScrollIndicator = NO;
//
//
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(loadHeaderCategoryData:) name:NotificationCategorySelected object:nil];
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//#pragma  mark - 刷新
//-(void)refresh{
//    //刷新
////    if (self.delegate) {
////        [self.delegate SCCategoryDetailControllerRefresh];
////    }
//}
//
//#pragma  mark 结束刷新
//-(void)endRefresh{
//    [self.collectionView.mj_header endRefreshing];
//}
////
//#pragma mark 2. 请求二级分类数据(1.用于显示组的头标题2.用于请求详细分类数据)
//- (void)loadHeaderCategoryData:(NSNotification *)notification {
//
//    NSInteger index=[notification.object integerValue];
//
//
//    [self.view layoutIfNeeded];
//
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
//
//    self.detailCategoryList = @[].mutableCopy;
//
//    SPKungFuModel *model = self.dataArr[index];
//    self.detailCategoryList = (NSMutableArray *)model.subProperties;
//    [self.collectionView reloadData];
//}
//
//#pragma mark - <UICollectionViewDataSource>
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    return self.dataArr.count;
//}
////
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    SPKungFuModel*model = self.dataArr[section];
//    return 10;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    SCDetailCategoryCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierForCell forIndexPath:indexPath];
//
//    LGRecommendCategory*model = self.dataArr[indexPath.section];
//    LGRecommendUser*model2 = model.categoryList[indexPath.row];
//    // 取出模型数据
//    //        LGRecommendUser *detailCategory = self.detailCategoryList[indexPath.row];
//    cell.category = model2;
//    cell.backgroundColor=LGcateBaseColour;
//    return cell;
//}
////
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    // 取出模型数据
//    LGRecommendUser *detailCategory = self.detailCategoryList[indexPath.row];
//    // 跳转
//    LGOnleBmgSwitchVc*vc=[[LGOnleBmgSwitchVc alloc]init];
//    vc.cid=detailCategory.cid;
//    vc.titleName=detailCategory.name;
//
//    LGNavigationViewController*navigationVC = [[LGNavigationViewController alloc] initWithRootViewController:vc];
//    if ([self.view.superview.nextResponder isKindOfClass:[SCCategoryViewController class]]) {
//        SCCategoryViewController *categoryVC = (SCCategoryViewController *)self.view.superview.nextResponder;
//        categoryVC.hidesBottomBarWhenPushed = YES;
//        categoryVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//        [categoryVC presentViewController:navigationVC animated:YES completion:nil];
//    }
//}
////
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 0, 5, 0);
//}
////
//#pragma  mark 返回的header视图大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return  CGSizeMake(kWindowW, 40);
//}
//
//#pragma  mark 返回Header视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionReusableView *monthHeader =
//    [collectionView dequeueReusableSupplementaryViewOfKind:
//     UICollectionElementKindSectionHeader
//                                       withReuseIdentifier:@"section" forIndexPath:indexPath];
//    if (indexPath.section == 2) {
//        _monthHeader = monthHeader;
//        monthHeader.backgroundColor= [UIColor orangeColor];
//    }else{
//        monthHeader.backgroundColor= [UIColor whiteColor];
//    }
//
//    return monthHeader;
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGRect frame1 = [self.view convertRect:_monthHeader.frame fromView:scrollView];
//    NSLog(@"%f",frame1.origin.y);
//}
//
//#pragma mark -
//-(void)click:(UIButton*)btn{
//    if (btn.tag==12) {
//        /** 跳转到Lets购*/
//        LGLetsViewController*vc=[[LGLetsViewController alloc]init];
//        if ([self.view.superview.nextResponder isKindOfClass:[SCCategoryViewController class]]) {
//            SCCategoryViewController *categoryVC = (SCCategoryViewController *)self.view.superview.nextResponder;
//
//            categoryVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//            [categoryVC.navigationController pushViewController:vc animated:YES];
//        }
//    }
//}
//
//
//#pragma mark - 初始化
//- (instancetype)init {
//
//    return [super initWithCollectionViewLayout:[self flowLayout]];
//
//}
//
//- (UICollectionViewFlowLayout *)flowLayout {
//
//    XLPlainFlowLayout *layout = [XLPlainFlowLayout new];
//    layout.itemSize = CGSizeMake(20, (kWindowW-101)/3*1.5);
//    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
//    layout.naviHeight = 0.0;
//    return  layout;
//
//}
//
////@end
