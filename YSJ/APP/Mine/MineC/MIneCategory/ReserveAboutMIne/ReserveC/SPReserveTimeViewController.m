//
//  SPReserveTimeViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPReserveTimeViewController.h"
#import "YQCalendarView.h"//日历选择器
@interface SPReserveTimeViewController ()<YQCalendarViewDelegate>

@property (nonatomic,strong)YQCalendarView *view2;
@end

@implementation SPReserveTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    
    [self createClendar];
    
    [self loadData];
    
    
    
    
    //单独添加选中个某一天
    //[view AddToChooseOneDay:@"2017-02-10"];
    
    //--------------------------------------------------自定义显示
    
    
    //    //整体背景色
    //    view.backgroundColor   = [UIColor whiteColor];
    //    //选中的日期的背景颜色
    //    view.selectedBackColor = [UIColor darkGrayColor];
    //    //选中的日期下方的图标
    //    view.selectedIcon      = [UIImage imageNamed:@""];
    //    //下一页按钮的图标
    //    view.nextBTNIcon       = [UIImage imageNamed:@""];
    //    //前一页按钮的图标
    //    view.preBTNIcon        = [UIImage imageNamed:@""];
    //    //上方日期标题的字体
    //    view.titleFont         = [UIFont systemFontOfSize:17];
    //    //上方日期标题的颜色
    //    view.titleColor        = [UIColor blackColor];
    //    //下方日历的每一天的字体
    //    view.dayFont           = [UIFont systemFontOfSize:17];
    //    //下方日历的每一天的字体颜色
    //    view.dayColor          = [UIColor redColor];
    
    
    //--------------------------------------------------如果需要接
}

#pragma mark - loadData

- (void)loadData{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1549950269066756729" forKey:@"userCode"];

    
    [[HttpRequest sharedClient]httpRequestPOST:MineReserveTime parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"yuyue%@",responseObject);
        NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:0];
        self.view2.selectedArray = responseObject[@"data"];
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - uploadData 上传设置的时间
- (void)upLoadData{

    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:@"1549950269066756729" forKey:@"userCode"];
    [dict setObject:self.view2.selectedArray forKey:@"timeList"];
    
    [[HttpRequest sharedClient]httpRequestPOST:UPLoadMineReserveTime parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"yuyue%@",responseObject);
        
        [self backClick];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}
#pragma mark - createClendar
- (void)createClendar{

    YQCalendarView *view = [[YQCalendarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    //CGRectMake(20,100,self.view.frame.size.width-40,300)
    self.view2 = view;
    view.dayColor = [UIColor orangeColor];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    //设置选中的日期，格式 yyyy-MM-dd (数组)
    //view.selectedArray = @[@"2017-06-23"];
                           
    //点击后的代理
    view.delegate = self;
    
}

//接收点击的代理方法
//使用String格式，是为了避免因时区可能会导致的不必要的麻烦
-(void)YQCalendarViewTouchedOneDay:(NSString *)dateString{
    NSLog(@"点击了：%@",dateString);
    
    NSString * deleteStr = nil;
    NSString * addStr = nil;
    for (int i =0 ;i<self.view2.selectedArray.count;i++) {
        
        //NSLog(@"%@",tempStr);
        if ([self.view2.selectedArray[i] isEqualToString:dateString]) {
            
            
            deleteStr = dateString;
        }else{
            
            
            addStr = dateString;
        }
    }
    if (deleteStr) {
        [self.view2.selectedArray removeObject:dateString];
    }else{
        
        [self.view2.selectedArray addObject:dateString];
    }
    NSLog(@"selectedArray%@",self.view2.selectedArray);
    [self.view2 loadData];
    
}

#pragma mark - createNav
- (void)createNav{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    self.titleLabel.text = dateTime;
    self.titleLabel.textColor = TitleColor;
    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - backClick
- (void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - rightButtonClick
- (void)rightButtonClick{

    //提交选择的日期
    [self upLoadData];
}
@end
