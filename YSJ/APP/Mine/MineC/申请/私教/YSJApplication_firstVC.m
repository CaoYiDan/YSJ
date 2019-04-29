//
//  YSJApplication_FirstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJApplication_SecondVC.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_FirstVC.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 70
@interface YSJApplication_FirstVC ()

@end

@implementation YSJApplication_FirstVC
{
    UIScrollView *_scroll;
    YSJFactoryForCellBuilder  *_builder;
    YSJPopTextFiledView *_nameCell;
    UITextField *_identifierTextFiled;
    YSJPopTextFiledView *_sexCell;
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
    
    YSJFactoryForCellBuilder *builder = [[YSJFactoryForCellBuilder alloc]init];
    
    _builder = builder;
    
    _scroll = [builder createViewWithDic:[self getCellDic]];
    
    [self.view addSubview:_scroll];
    
    _tag =builder.lastBottomView;
    
    [self topView];
    
    [self setBottomView];
    
}

-(NSDictionary *)getCellDic{
    
    NSDictionary *dic = @{@"cellH":@"76",
                          @"orY":@"111",
                          @"arr":@[
                                  @{
                                      @"type":@(CellPopCouserChosed),
                                      @"title":@"姓名",
                                      },
                                  @{
                                      @"type":@(CellTextFiled),
                                      @"title":@"身份证号",
                                      @"placeholder":@"请输入身份证号",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopSheet),
                                      @"title":@"性别",
                                      @"sheetText":@"男,女",
                                      },
                                  ]
                          };
    return dic;
}

-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step1"];
    topImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:topImg];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = grayF2F2F2;
    [_scroll addSubview:bottomLine];
    _tag = bottomLine;
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(6);
        make.top.equalTo(topImg.mas_bottom).offset(32);
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

    NSArray *arr = @[@"realname",@"secu_id",@"sex"];
    NSMutableArray *valueArr = [_builder getAllContent];
    if (arr.count!=valueArr.count) {
        Toast(@"请填写完整信息");
        return;
    }
    
    //网络请求
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    int i=0;
    for (NSString *value in valueArr) {
         [dic setObject:value  forKey:arr[i]];
        i++;
    }
    
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YTeacherStep1 parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        YSJApplication_SecondVC *vc = [[YSJApplication_SecondVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
//
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
