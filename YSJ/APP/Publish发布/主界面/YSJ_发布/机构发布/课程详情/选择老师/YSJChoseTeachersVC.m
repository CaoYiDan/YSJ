
#import "YSJHeaderForPublishCompanyView.h"
#import "YSJTeacherForCompanyCollectionCell.h"
#import "YSJPopTextFiledView.h"
#import "LGTextView.h"
#import "SLLocationHelp.h"
#import "LGComposePhotosView.h"
#import "SPPublishLimitVC.h"
#import "SPPublishLocationVC.h"
#import "YSJAddTeacherVC.h"
#import "YSJChoseTeachersVC.h"
#import "ZLPhotoActionSheet.h"

#import "SPCommon.h"
//定位服务
#import <CoreLocation/CoreLocation.h>

@interface YSJChoseTeachersVC ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,AddTeacherDelegate>
//collection
@property(nonatomic,strong)UICollectionView*collectionview;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic,strong) NSMutableArray *listArr;

/**
 上课时间
 */
@property (nonatomic,strong) YSJPopTextFiledView *classTime;
/**
 课时数
 */
@property (nonatomic,strong) YSJPopTextFiledView *classNums;

@end

@implementation YSJChoseTeachersVC
{
    NSInteger _limitIndex;
    NSInteger _locationIndex;
    
    BOOL _locationEnabled;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择老师";
    
    //获取老师列表
    [self getTeacherList];
    
    [self creatCollection];
    
    [self setBottomView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc
{
    NSLog(@"销毁");
}

#pragma mark - 获取老师列表

-(void)getTeacherList{
    
    //网络请求
    NSString *url = [NSString stringWithFormat:@"%@?token=%@",YGetTeacherList,[StorageUtil getId]];
   
    [[HttpRequest sharedClient]httpRequestGET:url parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        self.listArr = responseObject[@"company_teachers"];
       
        NSLog(@"%@",self.listArr);
        
        [self.collectionview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count+1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item==self.listArr.count) {
        //添加按钮
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nothingCell" forIndexPath:indexPath];
        
        CGFloat imgWid = 70;
        
        CGFloat imgH = 70;
        
      UIImageView  *_img =  [[UIImageView alloc]initWithFrame:CGRectMake(cell.frameWidth/2-imgWid/2, cell.frameHeight/2-imgH/2, imgWid, imgH)];
        _img.image = [UIImage imageNamed:@"add_btn7"];
        _img.contentMode = UIViewContentModeScaleAspectFill;
        _img.layer.cornerRadius = 35;
        _img.clipsToBounds = YES;
        _img.clipsToBounds = YES;
        
        [cell addSubview:_img];
        
        return cell;
        
    }else{
        
    YSJTeacherForCompanyCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YSJTeacherCollectionCellID forIndexPath:indexPath];
     
        NSDictionary *dic = self.listArr[indexPath.row];
        cell.dic = dic;
        
        cell.selectedStatus = [self.selectedArr containsObject:dic];
        
    return cell;
        
    }
    return nil;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 10, 0, 10);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == self.listArr.count) {
        YSJAddTeacherVC *vc = [[YSJAddTeacherVC alloc]init];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        NSDictionary *dic = self.listArr[indexPath.item];
        //如果有，则移除，没有，则添加
        if ([self.selectedArr containsObject:dic]) {
            
            [self.selectedArr removeObject:dic];
            
        }else{
        
           [self.selectedArr addObject:dic];
       
        }
        
        NSLog(@"%@",self.selectedArr);
        
        [self.collectionview reloadData];
    }
  
}

#pragma mark - textViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self countWord:textView.text]>500) {
        Toast(@"您已超出了最大输入字符限制");
        return NO;
    }
    return YES;
}

-(int)countWord:(NSString *)s
{
    int i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

#pragma mark - 添加老师成功后的代理

- (void)addTeacherSucceed{
    
    //重新获取老师列表数据 刷新
    [self getTeacherList];
}

#pragma mark - setter

-(void)creatCollection{
    // 创建瀑布流布局
    UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat cellH = 150;
    
    layout.itemSize = CGSizeMake(SCREEN_W/4, cellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, kWindowW,kWindowH-SafeAreaTopHeight-KBottomHeight) collectionViewLayout:layout];
    //代理
    _collectionview.delegate=self;
    _collectionview.dataSource=self;
    _collectionview.backgroundColor=[UIColor whiteColor];
    _collectionview.contentInset = UIEdgeInsetsMake(0, 0, KBottomHeight +80, 0); _collectionview.showsVerticalScrollIndicator = NO;
 _collectionview.showsHorizontalScrollIndicator = NO;
    
    [_collectionview registerClass:[YSJTeacherForCompanyCollectionCell class] forCellWithReuseIdentifier:YSJTeacherCollectionCellID];
    [_collectionview registerClass:[YSJHeaderForPublishCompanyView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YSJHeaderForPublishCompanyViewID"];
     [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"nothingCell"];
    
    [self.view addSubview:_collectionview];
    
}

-(void)setBottomView{
    
    CGFloat btnW = (kWindowW-40-10)/2;
    
    //取消
    UIButton *cancleBtn = [[UIButton alloc]init];
    cancleBtn.backgroundColor = KWhiteColor;
    [cancleBtn setTitle:@"取消" forState:0];
    [cancleBtn setTitleColor:[UIColor hexColor:@"FE8600"] forState:0];
    cancleBtn.layer.cornerRadius = 5;
    cancleBtn.clipsToBounds = YES;
    cancleBtn.titleLabel.font = font(16);
    cancleBtn.layer.borderColor = [UIColor hexColor:@"FE8600"].CGColor;
    cancleBtn.layer.borderWidth = 1.0;
   
    [cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.width.offset(btnW);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-25);
    }];
    
    //确定
    UIButton *sureBtn = [[UIButton alloc]init];
    sureBtn.backgroundColor = KMainColor;
    [sureBtn setTitle:@"确定" forState:0];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    sureBtn.titleLabel.font = font(16);
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchDown];
  
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancleBtn.mas_right).offset(10);
        make.width.offset(btnW);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-25);
    }];
    
}

-(void)cancle{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)sure{
    
    [self.delegate choseTeacherFinishWithArr:self.selectedArr];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        
        _selectedArr = [[NSMutableArray alloc]init];
    }
    return _selectedArr;
}
@end
