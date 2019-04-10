//
//  SPProfileDetailVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPNewMyProfileVC.h"
#import "SPUser.h"
#import "SPTagCell.h"
#import "NSString+getSize.h"
#import "SPCommentModel.h"
#import "SPProfileCommentCell.h"
#import "SPSection2MoreTextCell.h"
#import "SPSection2Cell.h"
#import "SPSecton0Cell.h"
#import "SPKungFuModel.h"
#import "SPLucCommentModel.h"
#import "SPPublishModel.h"
#import "SDPhotoBrowser.h"
#import "SPSkillSectionHeaderView.h"
#import "SPProfileDetailHeaderView.h"
#import "SPProfileCommentFrame.h"
#import "SPMyTagVC.h"
#import "SPEditMyProfileVC.h"
@interface SPNewMyProfileVC ()<UITableViewDelegate,UITableViewDataSource,SPSkillSectionHeaderViewDelegate,SDPhotoBrowserDelegate,SPEditMyProfileVCDelegate>
@property(nonatomic,strong)SPUser *profileM;
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;
@property(nonatomic,strong)SPProfileDetailHeaderView *header;
@end

@implementation SPNewMyProfileVC
{
    NSArray *_section0Arr;
    NSArray *_section2Arr;
    NSInteger _selectedIndex;
    UIView *_photosView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedIndex = 0;
    
    self.navigationItem.title = self.nickName;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _section0Arr = @[@"经常出没",@"我的签名"];
    _section2Arr = @[@"技能相册",@"",@"技能等级",@"技能认证",@"服务价格",@"服务时间",@"服务介绍",@"服务优劣",@"备注"];
    [self.view addSubview:self.tableView];
    [self getData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSInteger count = self.navigationController.viewControllers.count;
    self.navigationController.interactivePopGestureRecognizer.enabled = count > 1;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)getData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dic setObject:[StorageUtil  getCode] forKey:@"code"];
    [dic setObject:[StorageUtil getCode] forKey:@"readerCode"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlProfileDetail parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"详细%@",responseObject);
        
        [NSObject propertyCodeWithDictionary:responseObject[@"data"]];
        
        self.profileM = [SPUser mj_objectWithKeyValues:responseObject[@"data"]];
        
        //遍历评价数组 计算评价高度，并存储到模型commentListVOFrameList中。
        for (SPLucCommentModel *lucM in self.profileM.userLucCommentDtoList) {
            lucM.commentListVOFrameList =@[].mutableCopy;
            for (SPCommentModel *commentM in lucM.commentListVOList) {
                SPProfileCommentFrame *proCommentF = [[SPProfileCommentFrame alloc]init];
                proCommentF.status = commentM;
                [lucM.commentListVOFrameList addObject:proCommentF];
            }
        }
        
        self.header.profileM = self.profileM;
        [_tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SPLucCommentModel *lucM = nil;
    if (self.profileM.userLucCommentDtoList.count==0) {
        lucM = [[SPLucCommentModel alloc]init];
    }else{
        lucM = self.profileM.userLucCommentDtoList[0];
    }
    
    switch (section) {
        case 0:
            return _section0Arr.count;
            break;
        case 1:
            return self.profileM.tags.count;
            break;
        case 2:
            return 9;
            break;
        case 3:
            return  lucM.commentListVOFrameList.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        SPSecton0Cell*cell = [tableView dequeueReusableCellWithIdentifier:SPSecton0CellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPSecton0Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPSecton0CellID];
        }
        
        NSString *detailText = nil;
        if (indexPath.row==0) {//经常出没
            detailText = self.profileM.haunt;
            NSLog(@"%@",self.profileM.haunt);
        }else{//签名
            NSLog(@"%@",self.profileM.signature);
            detailText = self.profileM.signature;
        }
        [cell setText:_section0Arr[indexPath.row] subText:detailText];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    //标签
    if (indexPath.section == 1) {
        SPTagCell*cell = [tableView dequeueReusableCellWithIdentifier:SPTagCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPTagCellID];
        }
        SPKungFuModel *model1 = self.profileM.tags[indexPath.row];
        [cell setMyCenterModel:model1];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return  [[UITableViewCell alloc]init];
}

-(NSString *)detailTextInSection2WithIndexRow:(NSInteger)row{
    
    if (self.profileM.userLucCommentDtoList.count==0) return @"";
    
    SPLucCommentModel *lucCommentM = self.profileM.userLucCommentDtoList[_selectedIndex];
    SPPublishModel *skillM = lucCommentM.lucrativetDto;
    NSString *detailText = nil;
    switch (row) {
        case 0:
            detailText = @"";
            break;
        case 1:
            detailText = @"";
            break;
        case 2:
            detailText = @"";
            break;
        case 3:
            detailText = @"";
            break;
        case 4:
            detailText = skillM.serPrice;
            break;
        case 5:
            detailText = skillM.serTime;
            break;
        case 6:
            detailText = skillM.serIntro;
            break;
        case 7:
            detailText = skillM.serContent;
            break;
        case 8:
            detailText = skillM.serRemark;
            break;
            
        default:
            break;
    }
    return detailText;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    SPNewHomeCellFrame *frame = self.listArray[indexPath.row];
    //    return frame.cellHeight;
    
    SPLucCommentModel *lucM = nil;
    
    if (self.profileM.userLucCommentDtoList.count!=0) {
        lucM = self.profileM.userLucCommentDtoList[_selectedIndex];
    }
    
    if (indexPath.section==1) {
        
        SPKungFuModel *model1  =self.profileM.tags[indexPath.row];
        
        return model1.subProperties.count/4*40+(model1.subProperties.count%4==0?0:1)*40;
    }else if (indexPath.section==2 && indexPath.row==1){
        return (SCREEN_W-2*kMargin-4*10)/5+15;
    }else if (indexPath.section==2 &&indexPath.row==6){
        
        return  [lucM.lucrativetDto.serIntro sizeWithFont:font(13) maxW:SCREEN_W-2*kMargin].height+40;
    }else if (indexPath.section==2 &&indexPath.row==8){
        
        return  [lucM.lucrativetDto.serRemark sizeWithFont:font(14) maxW:SCREEN_W-2*kMargin].height+40;
    }else if (indexPath.section==3){
        SPLucCommentModel *lucM = self.profileM.userLucCommentDtoList[_selectedIndex];
        SPProfileCommentFrame *statusFrame = lucM.commentListVOFrameList[indexPath.row];
        return statusFrame.cellHeight;
    }
    
    return 40;
}

#pragma  mark section-头部

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 120;
            break;
        case 3:
            return 40;
            break;
        default:
            break;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:
            return [self sectionHeaderView1];
            break;
        default:
            break;
    }
    return nil;
}

#pragma  mark  - SPSkillSectionHeaderViewDelegate

-(void)SPSkillSectionHeaderViewDidSelectedIndex:(NSInteger)indexRow{
    _selectedIndex = indexRow;
    [self.tableView reloadData];
}

#pragma  mark - --------- -action -----------------
//获取技能图片数组
-(NSMutableArray *)getPhotosUrlArr{
    SPLucCommentModel *lucM = self.profileM.userLucCommentDtoList[_selectedIndex];
    NSMutableArray *imgUrlArr = @[].mutableCopy;
    for (NSDictionary *dic in lucM.lucrativetDto.skillImgList) {
        [imgUrlArr addObject:dic[@"url"]];
    }
    return imgUrlArr;
}

-(void)skillImgTap:(UIGestureRecognizer *)tap{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    UIView *img = tap.view;
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = img.tag;
    photoBrowser.imageCount = [self getPhotosUrlArr].count;
    photoBrowser.sourceImagesContainerView = _photosView;
    [photoBrowser show];
}
-(void)commentClick{
    
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = [self getPhotosUrlArr][index];
    return [NSURL URLWithString:urlString];
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self getPhotosUrlArr][index]]];
    return imageView.image;
}

#pragma  mark - -----------------setter-----------------

- (NSMutableArray *)listArray
{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(UITableView *)tableView{
    
    if (!_tableView ) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HomeBaseColor;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
        [_tableView registerClass:[SPTagCell class] forCellReuseIdentifier:SPTagCellID];
        [_tableView registerClass:[SPSecton0Cell class] forCellReuseIdentifier:SPSecton0CellID];
        [_tableView registerClass:[SPSection2Cell class] forCellReuseIdentifier:SPSection2CellID];
        [_tableView registerClass:[SPSection2MoreTextCell class] forCellReuseIdentifier:SPSection2MoreTextCellID];
        _tableView.showsVerticalScrollIndicator = NO;
        
        //header
        _tableView.tableHeaderView = self.header;
    }
    
    return _tableView;
}

-(SPProfileDetailHeaderView *)header{
    WeakSelf;
    if (!_header) {
        _header = [[SPProfileDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W,bannerHeight+profileHeight+visterHeight+10)];
        _header.block = ^{
            [weakSelf gotoEditVC];
        };
        _header.type = 1;
    }
    return _header;
}

#pragma  mark  技能相册

-(UIView *)createPhotosView{
    UIView *photosView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_W-2*kMargin-4*10)/5+15)];
    _photosView = photosView;
    photosView.backgroundColor = [UIColor whiteColor];
    SPLucCommentModel *lucM = self.profileM.userLucCommentDtoList[_selectedIndex];
    NSLog(@"%@",lucM.lucrativetDto.skillImgList);
    int i=0;
    CGFloat imgW = (SCREEN_W-2*kMargin-4*10)/5;
    UIImageView *fiveImg = nil;
    
    for (NSDictionary *skillDic in lucM.lucrativetDto.skillImgList) {
        
        //如果有第六张图片，则在第五张图片上添加一张 + 图片 表示。
        if (i>5) {
            UIImageView *moreImg = [[UIImageView alloc]init];
            [moreImg setImage:[UIImage imageNamed:@"fx_tj"]];
            [fiveImg addSubview:moreImg];
            moreImg.tag = 4;
            moreImg.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skillImgTap:)];
            tap.numberOfTapsRequired = 1;
            [moreImg addGestureRecognizer:tap];
            [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.offset(0);
            }];
            
            return photosView;
        }
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin+i*(imgW+10), 7.5, imgW, imgW)];
        [img sd_setImageWithURL:[NSURL URLWithString:skillDic[@"url"]]];
        img.userInteractionEnabled = YES;
        img.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(skillImgTap:)];
        tap.numberOfTapsRequired = 1;
        [img addGestureRecognizer:tap];
        
        [photosView addSubview:img];
        if (i==4) {
            fiveImg = img;
        }
        i++;
    }
    return photosView;
}

-(UIView *)sectionHeaderView1{
    UIView *baseSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    baseSectionView.backgroundColor = [UIColor whiteColor];
    
    UILabel*section1 = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 80, 40)];
    section1.backgroundColor = [UIColor whiteColor];
    section1.font = kFontNormal_14;
    section1.text = @"我的标签";
    [baseSectionView addSubview:section1];
    
    UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-80, 5, 70, 30)];
    editBtn.backgroundColor = [UIColor whiteColor];
    editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    editBtn.layer.cornerRadius = 5;
    editBtn.clipsToBounds = YES;
    editBtn.layer.borderWidth = 1;
    [editBtn setTitle:@"编辑" forState:0];
    [editBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    editBtn.titleLabel.font = font(14);
    [editBtn addTarget:self action:@selector(tapTag) forControlEvents:UIControlEventTouchDown];
    [baseSectionView addSubview:editBtn];
    
    return baseSectionView;
}

-(void)gotoEditVC{
    SPEditMyProfileVC *vc = [[SPEditMyProfileVC alloc]init];
    vc.user = self.profileM;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)sectionHeaderView2{
    SPSkillSectionHeaderView *sectionHeader2 = [[SPSkillSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 120)];
    sectionHeader2.categoryArr = self.profileM.userLucCommentDtoList;
    sectionHeader2.delegate = self;
    sectionHeader2.selectedIndex = _selectedIndex;
    return sectionHeader2;
}

-(void)tapTag{
    SPMyTagVC *vc = [[SPMyTagVC alloc]init];
    vc.formMyCenter = YES;
    //保存完 pop回来，刷新
    WeakSelf;
    vc.perfaceBlock = ^(NSDictionary *dict){
        weakSelf.profileM = [SPUser mj_objectWithKeyValues:dict];
        [weakSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - SPEditMyProfileVCDelegate

-(void)backLastUser:(SPUser *)user{
    
    self.header.profileM = user;
}
@end


