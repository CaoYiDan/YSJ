//

//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/16.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPMySkillDetailVC.h"
#import "SDPhotoBrowser.h"
#import "SPMyskillDetailBottomToolView.h"
#import "SPLzsGetMoneyVC.h"
#import "NSString+getSize.h"
#import "SPSection2MoreTextCell.h"
#import "SPSection2Cell.h"
#import "SPLzsMySkillModel.h"

@interface SPMySkillDetailVC ()<UITableViewDelegate,UITableViewDataSource,SPMyskillDetailBottomToolViewDelegate,SDPhotoBrowserDelegate>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *listArray;

@end

@implementation SPMySkillDetailVC
{
    NSArray *_section2Arr;
    NSInteger _selectedIndex;
    SPMyskillDetailBottomToolView *_bottomView;
    UIView *_photosView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedIndex = 0;
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"我的技能";
    _section2Arr = @[@"技能",@"技能相册",@"",@"创建时间",@"状态",@"服务价格",@"保证金",@"服务时间",@"服务介绍",@"服务优劣",@"备注"];
    [self.view addSubview:self.tableView];
    
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _section2Arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //技能
    if (indexPath.row==9 || indexPath.row == 11) {
        SPSection2MoreTextCell*cell = [tableView dequeueReusableCellWithIdentifier:SPSection2MoreTextCellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPSection2MoreTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPSection2MoreTextCellID];
        }
        
        [cell setText:_section2Arr[indexPath.row] subText:[self detailTextInSection2WithIndexRow:indexPath.row]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        SPSection2Cell*cell = [tableView dequeueReusableCellWithIdentifier:SPSection2CellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[SPSection2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SPSection2CellID];
        }
        [cell setText:_section2Arr[indexPath.row] subText:[self detailTextInSection2WithIndexRow:indexPath.row]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row==2) {
            [cell.contentView addSubview:[self createPhotosView]];
        }
        return cell;
    }
    
    return  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCellStyleValue1"];
}

-(NSString *)detailTextInSection2WithIndexRow:(NSInteger)row{
    
    NSString *detailText = @"";
    switch (row) {
        case 0:
            detailText = self.model.skill;
            break;
        case 1:
            detailText = @"";
            break;

        case 3:
            detailText = self.model.updatedAt;
            break;
        case 4:
            if ([self.model.status isEqualToString:@"NORMAL"])
            {
                detailText = @"发布赚钱";
            }else
            {
                detailText = @"暂不赚钱";
            }
            
            break;
        case 5:
            detailText = self.model.serPrice;
            break;
        case 6:
            detailText = [NSString stringWithFormat:@"%@元",self.model.bailFee];
            break;
        case 7:
            detailText = self.model.serTime;
            break;
        case 8:
            detailText = self.model.serIntro;
            break;
        case 9:
            detailText = self.model.serContent;
            break;
        case 10:
            detailText = self.model.serRemark;
            break;
        case 11:
            detailText = self.model.serRemark;
            break;
            
        default:
            break;
    }
    return detailText;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==9) {
        
        return  [self.model.serIntro sizeWithFont:font(13) maxW:SCREEN_W-2*kMargin].height+40;
        
    }else if (indexPath.row==11){
        
        return  [self.model.serRemark sizeWithFont:font(14) maxW:SCREEN_W-2*kMargin].height+40;
    }else if (indexPath.row==2){
        return (SCREEN_W-2*kMargin-4*10)/5+15;
    }
    
    return 40;
}

#pragma  mark section-bottom

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SPMyskillDetailBottomToolView *footerView = [[SPMyskillDetailBottomToolView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 50)];
    footerView.delegate = self;
    _bottomView = footerView;
    [footerView initWithStatus:self.model.status];
    return footerView;
}

-(void)commentClick{
    
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight-SafeAreaBottomHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_tableView registerClass:[SPSection2Cell class] forCellReuseIdentifier:SPSection2CellID];
        [_tableView registerClass:[SPSection2MoreTextCell class] forCellReuseIdentifier:SPSection2MoreTextCellID];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

#pragma  mark - -----------------底部按钮处理事件-----------------

-(void)SPMyskillDetailBottomToolViewDidSelectedTag:(NSInteger)tag{
    
    if (tag==1) {
        SPLzsGetMoneyVC *vc = [[SPLzsGetMoneyVC alloc]init];
        vc.skillCode = self.model.skillCode;
        vc.skill = self.model.skill;
        
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.model.code forKey:@"code"];
    [dic setObject:self.model.ID forKey:@"id"];
    [dic setObject:self.model.lucCode forKey:@"lucCode"];
    NSString *statusText = @"";
    if (tag==0 && [self.model.status isEqualToString:@"NORMAL"]) {
        
        statusText = @"STOP";
    }else if (tag==0 && [self.model.status isEqualToString:@"STOP"]){
        statusText = @"NORMAL";
    }else if (tag==2){
        statusText = @"DELETED";
    }
    [dic setObject:statusText forKey:@"status"];
    NSLog(@"%@",dic);
    [[HttpRequest sharedClient]httpRequestPOST:kUrlUpdateSkill parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        Toast(@"更改成功");
        if (tag==2){
            Toast(@"删除成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            Toast(@"更改成功");
        }
        self.model.status = statusText;
        //更改信息
        [_bottomView initWithStatus:statusText];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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

//获取技能图片数组
-(NSMutableArray *)getPhotosUrlArr{
    
    NSMutableArray *imgUrlArr = @[].mutableCopy;
    for (NSDictionary *dic in self.model.skillImgList) {
        [imgUrlArr addObject:dic[@"url"]];
    }
    return imgUrlArr;
}

#pragma  mark  技能相册

-(UIView *)createPhotosView{
    UIView *photosView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_W-2*kMargin-4*10)/5)];
    _photosView = photosView;
    photosView.backgroundColor = [UIColor whiteColor];
    
    int i=0;
    CGFloat imgW = (SCREEN_W-2*kMargin-4*10)/5;
    UIImageView *fiveImg = nil;
    
    for (NSDictionary *skillDic in self.model.skillImgList) {
        
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
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
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

-(void)skillImgTap:(UIGestureRecognizer *)tap{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    UIView *img = tap.view;
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = img.tag;
    photoBrowser.imageCount = [self getPhotosUrlArr].count;
    photoBrowser.sourceImagesContainerView = _photosView;
    [photoBrowser show];
}
@end

