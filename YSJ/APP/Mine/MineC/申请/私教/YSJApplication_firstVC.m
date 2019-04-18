//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJApplication_secondVC.h"
#import "YSJCommonArrowView.h"
#import "YSJApplication_firstVC.h"
#define cellH 70
@interface YSJApplication_firstVC ()

@end

@implementation YSJApplication_firstVC
{
    YSJCommonArrowView *_nameCell;
    UITextField *_identifierTextFiled;
    YSJCommonArrowView *_sexCell;
    UIView *_tag;
    UIView *_tag0;
    UIView *_tag1;
    
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

-(void)initUI{
    
    [self topView];

    [self nameView];
    
    [self identifierView];
    
    [self sexView];
    
    [self setBottomView];
    
}


-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step1"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:topImg];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine];
    _tag = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
    }];
}
//姓名
-(void)nameView{
    
    YSJCommonArrowView *cell = [[YSJCommonArrowView alloc]initWithFrame:CGRectZero withTitle:@"姓名" subTitle:@""];
    [self.view addSubview:cell];
    _nameCell = cell;
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(cellH);
    make.top.equalTo(_tag.mas_bottom).offset(10);
    }];
     __weak typeof(cell) weakCell = cell;
    [cell addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [SPCommon creatAlertControllerTitle:@"姓名" subTitle:@"" _alertSure:^(NSString *text) {
            weakCell.rightSubTitle = text;
        }];
    }];
    _tag0 = cell;
}

-(void)identifierView
{
    //身份证号
    UILabel *leftText2 = [[UILabel alloc]init];
    leftText2.font = font(16);
    leftText2.text = @"身份证号";
    [self.view addSubview:leftText2];
    [leftText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(120);
        make.height.offset(cellH);
        make.top.equalTo(_tag0.mas_bottom).offset(0);
    }];
    
    UITextField *identifierFiled = [[UITextField alloc]init];
    _identifierTextFiled = identifierFiled;
    identifierFiled.backgroundColor = KWhiteColor;
    
    identifierFiled.font = font(14);
    identifierFiled.placeholder = @"请输入身份证号";
    identifierFiled.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:identifierFiled];
    [identifierFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin-20);
        make.width.offset(200);
        make.height.offset(cellH);
        make.centerY.equalTo(leftText2).offset(0);
    }];
    
    UIImageView *arrowImg2 = [[UIImageView alloc]init];
    arrowImg2.image = [UIImage imageNamed:@"arrow"];
    [self.view addSubview:arrowImg2];
    [arrowImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.width.offset(8);
        make.height.offset(14);
        make.centerY.equalTo(identifierFiled).offset(0);
    }];
    
    
    UIView *bottomLine2 = [[UIView alloc]init];
    bottomLine2.backgroundColor = grayF2F2F2;
    [self.view addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.height.offset(1);
        make.bottom.equalTo(identifierFiled.mas_bottom).offset(0);
    }];
    
    _tag1 = bottomLine2;
}

//性别
-(void)sexView{
    
    YSJCommonArrowView *cell = [[YSJCommonArrowView alloc]initWithFrame:CGRectZero withTitle:@"性别" subTitle:@""];
    [self.view addSubview:cell];
    _sexCell = cell;
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(kWindowW);
        make.height.offset(cellH);
        make.top.equalTo(_tag1.mas_bottom).offset(10);
    }];
    WeakSelf;
    [cell addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf showSheet];
    }];
    
}

-(void)setBottomView{
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"下一步" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(50);
        make.bottom.offset(-KBottomHeight-25);
    }];
}

-(void)next{
    YSJApplication_secondVC *vc = [[YSJApplication_secondVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSheet{
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"性别"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             _sexCell.rightSubTitle = @"男";                                }];
    UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //响应事件
                                                           NSLog(@"action = %@", action);
                                  _sexCell.rightSubTitle = @"女";                      }];
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
