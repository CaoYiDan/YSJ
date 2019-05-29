//
//  YSJPaySuccessVC.m
#import "YSJApplication_SuccessVC.h"

@interface YSJApplication_SuccessVC ()

@end

@implementation YSJApplication_SuccessVC



#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleName;
    
    [self setUI];
    
}

-(void)setUI{
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"succeed"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.offset(78);
        make.height.offset(78);
        make.top.equalTo(self.view).offset(70);
    }];
    
    UILabel *statusLab =[[UILabel alloc]init];
    statusLab.text = @"您的申请已提交成功";
    statusLab.font = font(16);
    [self.view addSubview:statusLab];
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img);
        make.height.offset(20);
        make.top.equalTo(img.mas_bottom).offset(37);
    }];
    
    UILabel *tip1 = [FactoryUI createLabelWithFrame:CGRectZero text:@"恭喜您，您的申请提交成功！艺术加的客服会尽快验证您的信息，届时将在1～3个工作日内消息通知您，谢谢您对我们工作的支持！" textColor:gray999999 font:font(13)];
    tip1.numberOfLines = 0;
    tip1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tip1];
    [tip1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(kWindowW-2*kMargin);
         make.top.equalTo(statusLab.mas_bottom).offset(24);
    }];
    
    UIButton *connectBtn = [[UIButton alloc]init];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:@"返回我的主页" forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    [connectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.width.offset(kWindowW-40);
        make.height.offset(50);
        make.top.equalTo(tip1.mas_bottom).offset(42);
    }];
   
}

#pragma mark - action

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

#pragma mark UITableviewDelegate

#pragma mark UITableviewDataSource

#pragma mark CustomDelegate

#pragma mark event response

-(void)finishClick{
    
}
#pragma mark private methods

#pragma mark getters and setters


@end
