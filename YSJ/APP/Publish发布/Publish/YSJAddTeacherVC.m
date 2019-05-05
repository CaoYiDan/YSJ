//
//  YSJApplication_FirstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.

#import "YSJAddTeacherVC.h"
#import "YSJPopTextFiledView.h"
#import "BDImagePicker.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 70

@interface YSJAddTeacherVC ()

@property (nonatomic,strong) UIImageView *photo;

@end

@implementation YSJAddTeacherVC
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
    
    self.title = @"添加老师";
    
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
    
    NSDictionary *dic = @{cb_cellH:@"76",
                          cb_orY:@"151",
                         cb_cellArr:@[
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"老师姓名",
                                      },
                                  @{
                                      @"type":@(CellPopCouserChosed),
                                      @"title":@"授课类型",
                        
                                      },
                                  
                                  @{
                                      @"type":@(CellPopTextView),
                                      @"title":@"老师介绍",
                                      
                                      },@{
                                      cb_type:@(CellPushVC),
                                      cb_title:@"老师标签",
                                      
                                      },
                                  ]
                          };
    return dic;
}

#pragma mark  授课老师添加照片

-(void)topView{
    
    //授课老师
    UILabel * labForTitle = [[UILabel alloc]init];
    [_scroll addSubview:labForTitle];
    labForTitle.text = @"授课老师";
    labForTitle.textColor = [UIColor blackColor];
    labForTitle.font = Font(16);
    labForTitle.baselineAdjustment =UIBaselineAdjustmentAlignCenters;
    [labForTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(22);
        make.left.offset(kMargin);
        make.width.offset(160);
        make.height.offset(20);
        
    }];
    
    CGFloat photoW = 70;
    //身份证正面照
    self.photo = [[UIImageView alloc]init];
    [_scroll addSubview:self.photo];
    self.photo.clipsToBounds = YES;
    self.photo.backgroundColor =grayF2F2F2;
    self.photo.layer.cornerRadius = photoW/2;
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    self.photo.userInteractionEnabled = YES;
    self.photo.image = [UIImage imageNamed:@"add_btn7"];
    
    [self.photo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(labForTitle.mas_bottom).offset(15);
        make.left.offset(kMargin);
        make.width.offset(photoW);
        make.height.offset(photoW);
    }];
    WeakSelf;
    [self.photo addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [weakSelf addPhotobtn1Click];
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
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

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

- (void)addPhotobtn1Click{
    
    //吊起相册
    WeakSelf;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        
        if (image) {
            //添加进img数组
           
         self.photo.image = image;
            
        }
        
    }];
    
}
@end
