//
//  YSJApplication_firstVC.m
//  SmallPig
//
//  Created by xujf on 2019/4/17.
//  Copyright © 2019年 lisen. All rights reserved.
#import "YSJCommonSwitchView.h"
#import "YSJPopTextFiledView.h"
#import "YSJApplication_SecondVC.h"
#import "YSJApplicationCompany_SecondVC.h"
#import "YSJApplicationCompany_FirstVC.h"
#import "YSJPopCourserCellView.h"
#import "YSJFactoryForCellBuilder.h"

#define cellH 76

@interface YSJApplicationCompany_FirstVC ()

@end

@implementation YSJApplicationCompany_FirstVC
{
    UIScrollView  *_scroll;

    YSJFactoryForCellBuilder *_builder;
    
    UIView *_tag;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"机构申请";
    
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - UI

-(void)initUI{

    [self setUI];

}


-(void)topView{
    
    UIImageView *topImg = [[UIImageView alloc]initWithFrame:CGRectMake(27, 32, kWindowW-54, 47)];
    topImg.backgroundColor = [UIColor whiteColor];
    topImg.image = [UIImage imageNamed:@"step2_1"];
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

#pragma mark - UI

-(void)setUI{
    
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
                                      @"type":@(CellPopNormal),
                                      @"title":@"机构名称",
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"机构电话",          @"keyBoard":@(UIKeyboardTypePhonePad)
                                      },
                                  
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"营业时间",
                                      },
                                  @{
                                      @"type":@(CellPopNormal),
                                      @"title":@"机构地址",
                                      },
                                 @{
                                      @"type":@(CellPopCouserChosed),
                                      @"title":@"营业项目",
                                      },
                                  ]
                          };
    return dic;
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
    
    NSArray *keyArr = @[@"name",@"otherphone",@"datetime",@"address",@"sale_item"];
    
    int i = 0 ;
    NSMutableDictionary *dic = @{}.mutableCopy;
    for (NSString *value in [_builder getAllContent]) {
        if (isEmptyString(value)) {
            Toast(@"请填写完整信息");
            return;
        }else{
            [dic setObject:value forKey:keyArr[i]];
        }
        i++;
    }
    
    [dic setObject:[StorageUtil getId] forKey:@"token"];
   
    NSLog(@"%@",dic);
    
    [[HttpRequest sharedClient]httpRequestPOST:YcompanyStep1 parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
    pushClass(YSJApplicationCompany_SecondVC);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


@end
