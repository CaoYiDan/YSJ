//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJCommonArrowView.h"
#import "YSJApplication_secondVC.h"

#import "YSJAlpplication_thirdVC.h"

#define cellH 76

@interface YSJAlpplication_thirdVC ()

@end

@implementation YSJAlpplication_thirdVC
{
    UIScrollView  *_scroll;
    UILabel *_name;
    UITextField *_identifierTextFiled;
    UILabel *_sex;
    
    YSJCommonSwitchView *_supportHome;
    
    UIView *_tag;
    UIView *_tag0;
    UIView *_tag1;
    UIView *_tag2;
    UIView *_tag3;
    UIView *_tag4;
    
    NSMutableArray *_cellViewArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"私教申请";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark - UI

-(void)initUI{
    
    [self setBase];
    
    [self topView];
    
    [self setView1];
    
    [self setSwitchView];
    
    [self setBottomView];
    
}


-(void)setBase{
    
    UIScrollView  *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    _scroll = scrollView;
    _scroll.backgroundColor = KWhiteColor;
    [self.view addSubview:_scroll];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.contentSize = CGSizeMake(kWindowW, 800);
}

-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step3"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:topImg];
    
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    _tag = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
    }];
}

-(void)setView1{
    
    _cellViewArr = @[].mutableCopy;
    NSArray *arr = @[@"可授课程",@"授课地点",@"职业",@"工作单位/学校",@"学历",@"个人介绍"];
    int i=0;
    for (NSString *str in arr) {
        
        YSJCommonArrowView *cell = [[YSJCommonArrowView alloc]initWithFrame:CGRectMake(0, cellH*i+(i>=2?(111+cellH+6):111), kWindowW, cellH) withTitle:str subTitle:@""];
        [_scroll addSubview:cell];
        [_cellViewArr addObject:cell];
        __weak typeof(cell) weakCell = cell;
        [cell addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [SPCommon creatAlertControllerTitle:str subTitle:@"" _alertSure:^(NSString *text) {
                weakCell.rightSubTitle = text;
            }];
        }];
        if (i==1) {
            _tag = cell;
        }
        i++;
    }
}

-(void)setSwitchView{
    
    YSJCommonSwitchView *switchView = [[YSJCommonSwitchView alloc]initWithFrame:CGRectZero withTitle:@"上门服务" selected:YES];
    [_scroll addSubview:switchView];
    _supportHome = switchView;
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(cellH);
    make.top.equalTo(_tag.mas_bottom).offset(0);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(6);
        make.top.equalTo(switchView.mas_bottom).offset(0);
    }];
    
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"下一步" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
 
}

#pragma mark - action

-(void)next{
    
    for (YSJCommonArrowView *cell in _cellViewArr) {
        NSLog(@"%@",cell.rightSubTitle);
    }
    
}

- (void)showSheet:(UIButton *)sender {
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             _sex.text = @"男";                                }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                                           _sex.text = @"女";                      }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
