//
//  SPDetailIntroductionWebVC.m
//  SmallPig

#import "SPProfileVC.h"
#import "SPKitExample.h"
#import "SPShareView.h"
#import "SPKitExample.h"
#import "SPProfileDetailVC.h"
#import "SPUser.h"
#import "UIImage+XW.h"
#import "SPKitExample.h"
#import "SPProfileCommentFrame.h"
#import "SPCommentModel.h"
#import "SPLucCommentModel.h"
#import "SPProfileSetVC.h"
#import "SPProfileDynamicVC.h"

@interface SPProfileVC ()<UIWebViewDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIWebView*webView;

@property(nonatomic,strong)SPShareView *shareView;

@property(nonatomic,strong)UIView *moreView;

@property(nonatomic,strong)UIButton *selectedBtn;
//模型
@property(nonatomic,strong)SPUser *profileM;

@property(nonatomic,strong) UIButton *leftBtn;

@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic,strong) UIButton *praisedBtn;

@end

@implementation SPProfileVC

#pragma  mark - -----------------life cycle-----------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.titleName;
   
    [self setRightItem];
    
    [self setBottomView];
    
    //后台不加字段，非得另外请求接口，不想争，妥协
    [self getIfFollowed];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    
}

-(void)getIfFollowed{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"followerCode"];
    [dic setObject:self.code forKey:@"userCode"];
    [[HttpRequest sharedClient]httpRequestPOST:KUrlIfFollowed parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        self.leftBtn.selected = [responseObject[@"data"] integerValue];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma  mark - -----------------switchDelegate-----------------
-(NSArray*)titleArrInSwitchView{
    return @[@"个人信息",@"动态"];
}

-(UIViewController *)swithchVCForRowAtIndex:(NSInteger)index{
    if (index==0) {
        SPProfileDetailVC *vc= [[SPProfileDetailVC alloc]init];
        vc.code = self.code;
        WeakSelf;
        vc.block = ^(NSDictionary *profileDic) {
            NSLog(@"%@",profileDic[@"praised"]);
            if ([profileDic[@"praised"] integerValue]==0) {
                
                weakSelf.praisedBtn.selected = NO;
            }else{
                weakSelf.praisedBtn.selected = YES;
            }
            
            [weakSelf.praisedBtn setTitle:[NSString stringWithFormat:@"%@",profileDic[@"praisedNum"]] forState:UIControlStateNormal];

            NSLog(@"%@",profileDic);
            if (isEmptyString(profileDic[@"shareImgUrl"])) {
                weakSelf.shareImg = [UIImage imageNamed:@"app"];
                return ;
            }
         
            weakSelf.shareImg = [UIImage getImageFromURL:profileDic[@"shareImgUrl"][@"url"]];
        };
        return vc;
    }else{
        SPProfileDynamicVC *vc= [[SPProfileDynamicVC alloc]init];
        vc.code = self.code;
        
        return vc;
    }
    
    return nil;
}

#pragma  mark - -----------------setter-----------------

-(void)setRightItem{
    
    //查看自己
    if ([[StorageUtil getCode] isEqualToString:self.code])
    {

    }else
    {//查看他人
         [self.rightButton setImage:[UIImage imageNamed:@"gd_"] forState:0];
    }

    [self addRightTarget:@selector(rightClick)];
}

-(void)setBottomView{
        //查看自己
    if ([[StorageUtil getCode] isEqualToString:self.code]) {
        [self setLookAtMyselfBottom];
    }else{//查看他人
        [self setLookAtOtherBottom];
    }
}

-(void)setLookAtMyselfBottom{

    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-bottomH-SafeAreaBottomHeight-SafeAreaTopHeight, SCREEN_W, bottomH+SafeAreaBottomHeight)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, SCREEN_W-30, bottomH-10)];
    shareBtn.layer.cornerRadius = 5;
    shareBtn.clipsToBounds = YES;
    shareBtn.backgroundColor = [UIColor redColor];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchDown];
    shareBtn.titleLabel.font = font(13);
    [shareBtn setTitle:@"分享自己让更多好友认识你" forState:0];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [baseView addSubview:shareBtn];
}

-(void)setLookAtOtherBottom{
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_H2-bottomH-SafeAreaBottomHeight-SafeAreaTopHeight, SCREEN_W, bottomH)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    //关注
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,5,80,40)];
    _leftBtn = leftBtn;
    [leftBtn addTarget:self action:@selector(flowedClick:) forControlEvents:UIControlEventTouchDown];
    leftBtn.titleLabel.font = font(14);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    leftBtn.backgroundColor = RGBCOLOR(253,56, 101);
    [leftBtn setTitleColor:[UIColor whiteColor] forState:0];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [leftBtn setTitle:@"关注" forState:0];
    [leftBtn setTitle:@"已关注" forState:UIControlStateSelected];
    leftBtn.layer.cornerRadius = 20;
    leftBtn.clipsToBounds = YES;
    
    [baseView addSubview:leftBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2+20, 10, 1, 30)];
    line.backgroundColor = [UIColor grayColor];
    [baseView addSubview:line];
    
    //邀请Ta
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(kMargin+80+20, 5, 80, 40)];
    rightBtn.titleLabel.font = font(14);
    _rightBtn = rightBtn;
    rightBtn.layer.cornerRadius = 20;
    rightBtn.clipsToBounds = YES;
    rightBtn.backgroundColor = RGBCOLOR(253,56, 101);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:0];
    [rightBtn addTarget:self action:@selector(inviteClick) forControlEvents:UIControlEventTouchDown];
    [rightBtn setTitle:@"邀请Ta" forState:0];
    [baseView addSubview:rightBtn];
    
    //点赞按钮
    UIButton *praisedNumber = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-kMargin-80, 5, 70, 40)];
    self.praisedBtn = praisedNumber;
    praisedNumber.backgroundColor = [UIColor whiteColor];
    [praisedNumber setImage:[UIImage imageNamed:@"sy_gr_andz_"] forState:UIControlStateSelected];
    [praisedNumber setImage:[UIImage imageNamed:@"sy_gr_anwdz_"] forState:0];
    [praisedNumber setBackgroundImage:[UIImage imageNamed:@"sy_gr_anh_"] forState:0];
    praisedNumber.layer.cornerRadius = 20;
    praisedNumber.clipsToBounds = YES;
    [praisedNumber addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchDown];
    [praisedNumber setTitleColor:[UIColor redColor] forState:0];
    praisedNumber.titleLabel.font = font(13);
    [baseView addSubview:praisedNumber];
}

-(void)addTopLine{
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H-bottomH, SCREEN_W, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line2];
}

//分享界面
-(SPShareView*)shareView{
    if (!_shareView) {
        _shareView = [[SPShareView alloc]initWithFrame:self.view.bounds];
        //        _shareView.shareImg = self..image;
    }
    return _shareView;
}

#pragma  mark - -----------------action-----------------

#pragma  mark  分享

-(void)shareClick{
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view addSubview:self.shareView];
        NSLog(@"%@",self.shareImg);
      
//        self.shareView.shareImg = [UIImage imageNamed:@"app"];
        self.shareView.hidden = NO;
       
        self.shareView.shareUrl = [NSString stringWithFormat:@"http://59.110.70.112:8080/web/info.html?code=%@&share=true&userid=%@",self.code,[StorageUtil getCode]];
        self.shareView.title = @"我在小猪约";
        
        self.shareView.subTitle =[NSString stringWithFormat:@"我给你分享了%@",self.titleName];
       
        self.shareView.shareImg = self.shareImg ;
        
        self.shareView.originY = 0;
    }];
}

-(void)inviteClick{
    
    if ([SPCommon gotoLogin]) return;
    
    YWPerson *person = [[YWPerson alloc]initWithPersonId:self.code];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
   
}

-(void)flowedClick:(UIButton *)btn{
    
    //如果没有登录，就弹出登录界面
    if ([SPCommon gotoLogin]) return;
    
        NSString * kurl;
        if (!btn.isSelected) {

            kurl = FollowUrl;
        }else{

            kurl = CancelFollowUrl;
        }
    
        NSDictionary * dict = @{@"followerCode":[StorageUtil getCode],@"userCode":self.code};
    NSLog(@"%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            NSLog(@"%@",responseObject);
            
            btn.selected = !btn.isSelected;
            
            if (btn.isSelected) {
                //打招呼
                [[SPKitExample sharedInstance]sendMessageWithPersonId:self.code content:@"你好，很高兴认识你。"];
            }
            
            
            !self.block?:self.block(@"followed");
         
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
}

-(void)praiseClick:(UIButton *)btn{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:self.code forKey:@"bePraisedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
    [dict setObject:@"USER" forKey:@"type"];
    NSString *url  = @"";
    
    if (btn.isSelected) {
        url = kUrlDeletePraise;
    }else{
        url = kUrlAddPraise;
    }
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        btn.selected = !btn.isSelected;
        if (btn.isSelected) {
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]+1] forState:0];
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]-1] forState:0];
        }
        !self.block?:self.block(@"praised");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        Toast(@"O，出错啦！");
    }];
}

#pragma  mark  切换 分享举报View的显示与隐藏

-(void)rightClick{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self shareClick];
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self report];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(UIView *)moreView{
    if (!_moreView) {
        _moreView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W-105, 0-SafeAreaTopHeight-SafeAreaBottomHeight, 100, 80)];
        _moreView.layer.borderColor = [UIColor grayColor].CGColor;
        _moreView.layer.borderWidth = 1;
        _moreView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_moreView];
        
        UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        [firstBtn setTitle:@"分享" forState:0];
        [firstBtn setTitleColor:[UIColor blackColor] forState:0];
        [firstBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchDown];
        firstBtn.titleLabel.font = font(14);
        [_moreView addSubview:firstBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 100, 1)];
        line.backgroundColor = [UIColor grayColor];
        [_moreView addSubview:line];
        
        UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 41, 100, 40)];
        [secondBtn setTitleColor:[UIColor blackColor] forState:0];
        [secondBtn setTitle:@"举报" forState:0];
        [secondBtn addTarget:self action:@selector(report) forControlEvents:UIControlEventTouchDown];
        secondBtn.titleLabel.font = font(14);
        [_moreView addSubview:secondBtn];
    }
    return _moreView;
}

//举报
-(void)report{
    
    UIAlertAction * alertAc = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *dic = @{}.mutableCopy;
        //            [dic setObject:@"" forKey:@"reportContent"];
        [dic setObject:[StorageUtil getCode] forKey:@"code"];
        [dic setObject:self.code forKey:@"reportCode"];
        NSLog(@"%@",dic);
        [[HttpRequest sharedClient]httpRequestPOST:kUrlReport parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            Toast(@"我们已将信息发送到我们的检测中心");
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    }];
    UIAlertAction * alertNo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self rightClick];
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"是否举报" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:alertAc];
    [alertVC addAction:alertNo];
    
    [self presentViewController:alertVC animated:YES completion:nil];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x<-45) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
