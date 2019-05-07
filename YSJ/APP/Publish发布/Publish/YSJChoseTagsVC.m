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
    
    [self  getTagRequestisScu:^(BOOL isScu) {
        [self.view addSubview:self.tableView];
    }];
    
    [self setBottomView];
}

#pragma mark - 获取标签

- (void)getTagRequestisScu:(void(^)(BOOL isScu))requestisScu{
    
    NSString *url = [NSString stringWithFormat:@"%@?type=%@",YLables,self.type];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[HttpRequest sharedClient]httpRequestGET:url parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"label_list"];
        
        _commentModel = [FFDifferentWidthTagModel new];
        _commentModel.selectedArr = @[].mutableCopy;
        
        NSMutableArray *tagsArrM = [NSMutableArray array];
        
        for (int j = 0; j < arr.count; j++){
            
            [_commentModel.selectedArr addObject:@(0)];
            
            [tagsArrM addObject:arr[j]];
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
        
        [weakSelf addTag:text];
        
    } keyBoard:UIKeyboardTypeDefault];
}

-(void)addTag:(NSString *)text{
    
    //保存tagsArr
    NSMutableArray *arr = _commentModel.tagsArrM;
    [arr addObject:text];
    
    //保存selectedArr
    NSMutableArray *selectedArr = _commentModel.selectedArr;
    [selectedArr addObject:@(1)];
    
    //重新创建一个新的model
    _commentModel = [FFDifferentWidthTagModel new];
    _commentModel.tagsArrM = arr;
    _commentModel.selectedArr = selectedArr;
    
    [self.tableView reloadData];
    
    //每添加一个标签，需要向后台发送一个添加标签的请求
    [self postTag:text];
}

//每添加一个标签，需要向后台发送一个添加标签的请求
-(void)postTag:(NSString *)text{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:text forKey:@"name"];
    [dic setObject:self.type forKey:@"type"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YLables parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(UITableView *)tableView
{
    if (!_tableView )
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_W, SCREEN_H-60-KBottomHeight-SafeAreaTopHeight-25) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[YSJChoseTagCell class] forCellReuseIdentifier:@"YSJChoseTagCell"];
    _tableView.showsVerticalScrollIndicator = NO;
        
    }
    
    
    return _tableView;
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"确认" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}

-(void)next{
    
    NSMutableArray *arr = @[].mutableCopy;
    int i = 0;
    for (NSNumber *num in _commentModel.selectedArr) {
        if ([num integerValue]==1) {
            [arr addObject:_commentModel.tagsArrM[i]];
        }
        i++;
    }
    !self.block?:self.block(arr);
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
