//
//  ViewController.m
//  TopSelectBar
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 付耀辉. All rights reserved.
//

#import "SXMainViewController.h"
#import "SXSearchHeadView.h"
#import "common.h"

@interface SXMainViewController ()
@property (nonatomic,copy) SXSearchHeadView *headView;

@end

@implementation SXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = RGB(230, 230, 230);
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-104)];
//    imageView.image = [UIImage imageNamed:@"liuzheng.jpg"];
//    [self.view addSubview:imageView];
    [self configHeadView];
}

- (void)configHeadView{
    
    NSArray *Arr = @[@[@"类型",@"抒情",@"春天",@"夏天",@"秋天",@"冬天",@"写雨",@"写雪",@"写风",@"写景",@"梅花",@"菊花",@"荷花",@"写花",@"柳树",@"长江",@"黄河",@"山水",@"爱国",@"离别",@"思念",@"战争",@"讽刺",@"爱情",@"友情",@"亲情",@"抱负",@"故事",@"赞美",@"悲叹",@"惋惜",@"缅怀",@"豪放",@"婉约"],@[@"朝代",@"先秦",@"两汉",@"魏晋",@"南北朝",@"隋朝",@"唐代",@"五代",@"宋辽金",@"元代",@"明代",@"清代",@"近代"],@[@"形式",@"诗",@"词",@"曲",@"文言文",@"辞赋"]];
    
    _headView=[[SXSearchHeadView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth, 40*almightyHeight) andDataSource:Arr];
    __weak SXMainViewController *vc=self;
    
    //接受点击button时的下标
    _headView.titleBlock=^(NSInteger index){
        [vc showOrHiddenWhenTheValueChanged:index];
    };
    
    //接收点击cell时的消息
    //当headView的cell被点击时，收回tableView
    __weak SXSearchHeadView *view=_headView;
    
    _headView.selectBlock=^(NSString *str){
        [UIView animateWithDuration:.6 animations:^{
            float height=40*almightyHeight;
            
            CGRect rect=view.frame;
            
            rect.size.height=height;
            
            view.frame=rect;
            
        }];
        
        [vc showInfoWithDynasty:view.dynastyButton.currentTitle andPeomType:view.dataButton.currentTitle andForm:view.formButton.currentTitle];
    };
    
    [self.view addSubview:_headView];
}

//选择完成之后调用
- (void)showInfoWithDynasty:(NSString *)dynasty andPeomType:(NSString *)type andForm:(NSString *)form{

    self.navigationItem.title = [NSString stringWithFormat:@"%@%@的%@",dynasty,type,form];
    
}



#pragma mark - 根据回调回来的index来改变headView的frame
-(void)showOrHiddenWhenTheValueChanged:(NSInteger)value{
    
//    高度都是我随便写的，如有不同需要，比如数组的数据个数不一样，可以再调
    __block float height;
/*
    加__block原因是：block块里面不可以对局部变量赋值。
    想要在block块里对局部变量赋值有两个方案：
    1.将局部变量升级为全局变量
    2.局部变量前加__block
    */
    
//    当两次点击的是同一个按钮时，value为0
    if (value==0) {
        
        [UIView animateWithDuration:.3 animations:^{
            height=40;
            
            CGRect rect=_headView.frame;
            
            rect.size.height=height;
            
            _headView.frame=rect;
            
        }];
        
    }else if (value==102){
        
        [UIView animateWithDuration:.2 delay:0 usingSpringWithDamping:1 initialSpringVelocity:.5 options:0 animations:^{
            
            height=320;
            
            CGRect rect=_headView.frame;
            
            rect.size.height=height;
            
            _headView.frame=rect;
            
        } completion:nil];
        
    }else if(value==101){
        
        [UIView animateWithDuration:.3 animations:^{
            height=ScreenHeight-60;
            
            CGRect rect=_headView.frame;
            
            rect.size.height=height;
            
            _headView.frame=rect;
        }];
        
    }else if (value==100){
        
        if (_headView.dataButton.currentTitle) {

        }
        
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
            
            float height=ScreenHeight-60;
            
            CGRect rect=_headView.frame;
            
            rect.size.height=height;
            
            _headView.frame=rect;
            
        } completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
