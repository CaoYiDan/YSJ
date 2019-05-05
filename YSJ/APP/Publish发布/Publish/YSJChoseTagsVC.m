//
//  YSJChoseTagsVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/30.
//  Copyright © 2019年 lisen. All rights reserved.

#import "SPProfileCommentCell.h"
#import "YSJChoseTagCell.h"
#import "YSJChoseTagsVC.h"
#import "FFDifferentWidthTagModel.h"
@interface YSJChoseTagsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YSJChoseTagsVC
{
    //标签模型
    FFDifferentWidthTagModel *_commentModel;
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择标签";
    
    _commentModel = [FFDifferentWidthTagModel new];

    NSMutableArray *tagsArrM = [NSMutableArray array];
    NSArray *arr = @[@"fdfjsfkj将放到事就烦",@"fjdsjfls九分裤大V是"];
    for (int j = 0; j < arr.count; j++){
        
        [tagsArrM addObject:arr[j]];
    }
    
    _commentModel.tagsArrM = tagsArrM;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 获取标签

- (void)getTagRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
  
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?teacherid=%@",YTeacherPingJia,@""] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
      
        NSArray *arr = responseObject[@"label_count"];
        
        _commentModel = [FFDifferentWidthTagModel new];
        
        _commentModel.reputation = [responseObject[@"reputation"] doubleValue];
        
        NSMutableArray *tagsArrM = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++){
            
            [tagsArrM addObject:[NSString stringWithFormat:@"%@ %@",arr[j][@"label"],arr[j][@"num"]]];
        }
        
        _commentModel.tagsArrM = tagsArrM;
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
    }];
}

#pragma  mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YSJChoseTagCell *cell = [YSJChoseTagCell loadCode:tableView];
    cell.tagModel = _commentModel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

   return _commentModel.cellHeight;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
    
    UIButton *addTagBtn = [[UIButton alloc]initWithFrame:CGRectMake(kMargin, 4, 80, 32)];
    addTagBtn.backgroundColor = grayF2F2F2;
    [addTagBtn addTarget:self action:@selector(addTagClick) forControlEvents:UIControlEventTouchDown];
    [addTagBtn setTitle:@"+添加标签" forState:0];
    [addTagBtn setTitleColor:[UIColor hexColor:@"FF7F72"] forState:0];
    addTagBtn.titleLabel.font = font(12);
    addTagBtn.layer.cornerRadius = 4;
    addTagBtn.clipsToBounds = YES;
    [footer addSubview:addTagBtn];
    return footer;
}

-(void)addTagClick{
    
    WeakSelf;
    
    [SPCommon creatAlertControllerTitle:@"新标签" subTitle:@"" _alertSure:^(NSString *text ) {
        NSMutableArray *arr = _commentModel.tagsArrM;
        [arr addObject:text];
        
        _commentModel = [FFDifferentWidthTagModel new];
         _commentModel.tagsArrM = arr;
        [weakSelf.tableView reloadData];
        
    } keyBoard:UIKeyboardTypeDefault];
}

-(UITableView *)tableView
{
    if (!_tableView )
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_W, SCREEN_H-60-KBottomHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[YSJChoseTagCell class] forCellReuseIdentifier:@"YSJChoseTagCell"];
    _tableView.showsVerticalScrollIndicator = NO;
        
    }
    
    return _tableView;
}

@end
