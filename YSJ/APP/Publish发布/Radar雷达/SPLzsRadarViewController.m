//
//  SPLzsRadarViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/12/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsRadarViewController.h"
#import "BYIndicatorView.h"
#import "BYRadarView.h"
#import "SPProfileVC.h"
@interface SPLzsRadarViewController ()
@property (nonatomic, strong)UIImageView * bView;
@property (nonatomic, strong)UIImageView * iconImageView;
@property (nonatomic, strong)UILabel * contentLabel;
@property (nonatomic, strong)UIButton * shareBtn;
@property (nonatomic,copy)NSString * headStr;
@property (nonatomic,strong)NSMutableArray * headListArr;
@property (nonatomic,strong)NSMutableArray * headListFrame;
@property (nonatomic,strong)NSMutableArray * frameXArr;
@property (nonatomic,strong)NSMutableArray * frameYArr;

@end

@implementation SPLzsRadarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self getFrame];
    
    
    [self initNav];
    [self loadData];
    //[self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    self.leftButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 0, 0) title:nil titleColor:nil imageName:nil backgroundImageName:nil target:nil selector:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
}

- (void)getFrame
{
    
    self.frameXArr = [[NSMutableArray alloc]init];
    
    CGPoint x2 = CGPointMake(90, 40);
    CGPoint x3 = CGPointMake(140, 40);
    CGPoint x4 = CGPointMake(190, 40);
    CGPoint x5 = CGPointMake(40, 230);
    CGPoint x6 = CGPointMake(80, 247);
    CGPoint x7 = CGPointMake(55, 170);
    
    CGPoint x1 = CGPointMake(70, 80);
    CGPoint x8 = CGPointMake(150, 85);
    CGPoint x9 = CGPointMake(200, 90);
    CGPoint x10 = CGPointMake(242,224 );
    CGPoint x11 = CGPointMake(100, 178);
    CGPoint x12 = CGPointMake(250, 75);
    
    
    CGPoint x13 = CGPointMake(198, 240);
    CGPoint x14 = CGPointMake(183, 183);
    CGPoint x15 = CGPointMake(255, 155);
    CGPoint x16 = CGPointMake(230, 190);
    //CGPoint x17 = CGPointMake(192, 40);
    
    CGPoint x18 = CGPointMake(40,75);
    CGPoint x19 = CGPointMake(52, 125);
    CGPoint x20 = CGPointMake(147, 210);
    [self.frameXArr addObject:NSStringFromCGPoint(x1)];
    [self.frameXArr addObject:NSStringFromCGPoint(x3)];
    [self.frameXArr addObject:NSStringFromCGPoint(x5)];
    [self.frameXArr addObject:NSStringFromCGPoint(x7)];
    [self.frameXArr addObject:NSStringFromCGPoint(x9)];
    [self.frameXArr addObject:NSStringFromCGPoint(x11)];
    [self.frameXArr addObject:NSStringFromCGPoint(x13)];
    [self.frameXArr addObject:NSStringFromCGPoint(x15)];
    //[self.frameXArr addObject:NSStringFromCGPoint(x17)];
    [self.frameXArr addObject:NSStringFromCGPoint(x19)];
    [self.frameXArr addObject:NSStringFromCGPoint(x2)];
    [self.frameXArr addObject:NSStringFromCGPoint(x4)];
    [self.frameXArr addObject:NSStringFromCGPoint(x6)];
    [self.frameXArr addObject:NSStringFromCGPoint(x8)];
    [self.frameXArr addObject:NSStringFromCGPoint(x10)];
    [self.frameXArr addObject:NSStringFromCGPoint(x12)];
    [self.frameXArr addObject:NSStringFromCGPoint(x14)];
    [self.frameXArr addObject:NSStringFromCGPoint(x16)];
    [self.frameXArr addObject:NSStringFromCGPoint(x18)];
    [self.frameXArr addObject:NSStringFromCGPoint(x20)];
    //self.frameYArr = [NSMutableArray arrayWithCapacity:0];
    
}
#pragma mark - lodaData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //self.idStr = @"218";
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@%@",URLOfGetRadarList,self.idStr] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"雷达%@雷达",responseObject);
        self.headStr = responseObject[@"data"][@"userESDTO"][@"avatar"];
        self.headListArr = responseObject[@"data"][@"listUser"];
        [self initUI];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Toast(error);
    }];
}

- (void)initUI{
    
    _bView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 20,300,300)];
    _bView.userInteractionEnabled = YES;
    //_bView.frame =self.view.bounds;
    _bView.image = [UIImage imageNamed:@"leidaquan.jpg"];
    _bView.backgroundColor = nil;
    
    [self.view addSubview:_bView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_bView addGestureRecognizer:tap];
    
    //圆圈
    BYRadarView * radView = [[BYRadarView alloc] initWithFrame:_bView.bounds];
    radView.backgroundColor = [UIColor clearColor];
    [_bView addSubview:radView];
    
    //雷达
    BYIndicatorView * view = [[BYIndicatorView alloc] initWithFrame:_bView.bounds];
    view.backgroundColor = [UIColor clearColor];
    [_bView addSubview:view];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _bView.frame.size.width * .25, _bView.frame.size.width * .25)];
    _iconImageView.center = _bView.center;
    _iconImageView.layer.cornerRadius = _bView.frame.size.width * .25 / 2;
    _iconImageView.layer.masksToBounds = YES;
    //定时
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:6.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        self.titleLabel.text = @"已发送";
        view.hidden = YES;
        
    }];
    //_iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    //_iconImageView.layer.borderWidth = 2.0;
    if (self.headStr) {
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.headStr]];
        
    }else{
        
        _iconImageView.image = [UIImage imageNamed:@"head"];
    }
    
    //_iconImageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_iconImageView];
    
    if (self.headListArr.count !=0) {
        for (int i = 0; i<self.headListArr.count; i++) {
            UIImageView * smallIV = [[UIImageView alloc]init];
            int arcFrame = [self getRandomNumber:0 to:18-i];
            
            //            //int right = [self getRandomNumber:0 to:1];
            //            int top = [self getRandomNumber:0 to:1];
            //
            //            CGFloat centerX ;
            //            int tempX = 1;
            //            while (tempX) {
            //                CGFloat minX = _bView.frame.origin.x +30;
            //                CGFloat maxX = _bView.frame.origin.x + _bView.frame.size.width-60;
            //
            //                //centerX = [self getRandomNumber:minX to:maxX];
            //                centerX = [self randomFloatBetween:minX andLargerFloat:maxX];
            //                NSLog(@"X随机数范围%.2f-%.2f,centerX%.2f,__bView.centerX%.2f",minX,maxX,centerX,_bView.centerX);
            //                if (centerX <= _bView.centerX-70 || centerX >= _bView.centerX+65) {
            //                    tempX = 0;
            //                    NSLog(@"centerX%.2f,__bView.centerX%.2f",centerX,_bView.centerX);
            //                }else{
            //                    tempX = 1;
            //                    NSLog(@"centerX%.2f,__bView.centerX%.2f",centerX,_bView.centerX);
            //                }
            //            }
            //
            //            CGFloat centerY ;
            //            int tempY = 1;
            //            while (tempY) {
            //                CGFloat minY = _bView.frame.origin.y +30;
            //                CGFloat maxY = _bView.frame.origin.y + _bView.frame.size.height-60;
            //
            //                //centerY = [self getRandomNumber:minY to:maxY];
            //                centerY = [self randomFloatBetween:minY andLargerFloat:maxY];
            //                 NSLog(@"Y随机数范围%.2f-%.2f,centerY%.2f,_bView.centerY%.2f",minY,maxY,centerY,_bView.centerY);
            //                if (centerY <= _bView.centerY-70 || centerY >= _bView.centerY+65) {
            //                    tempY = 0;
            //                }else{
            //                    tempY = 1;
            //                }
            //            }
            //            NSLog(@"中心圆中心点%.2f,%.2f,随机圆中心点%.2f,%.2f",
            //                  _bView.centerY,_bView.centerX,centerX,centerY);
            //CGFloat X = centerX;
            //CGFloat Y  = centerY;
            //            if (left==1) {
            //                int testMin = _bView.frame.origin.x;
            //                int testX = _iconImageView.frame.origin.x -60;
            //                X = [self getRandomNumber:testMin to:testX];
            //
            //            }else{
            //                int testX = _iconImageView.frame.origin.x+_iconImageView.frame.size.width ;
            //                int testMax = _bView.frame.size.width + _bView.frame.origin.x - 90;
            //
            //                X = [self getRandomNumber:testX to:testMax];
            //
            //            }
            //
            //            if (top==1) {
            //
            //                int testMin = _bView.frame.origin.y;
            //                int testY = _iconImageView.frame.origin.y-60;
            //                Y = [self getRandomNumber:testMin to:testY];
            //            }else{
            //                int testY = _iconImageView.frame.origin.y+_iconImageView.frame.size.height ;
            //                int testMax = _bView.frame.size.height + _bView.frame.origin.y - 100;
            //                Y = [self getRandomNumber:testY to:testMax];
            //            }
            //if (centerY !=0 & centerX !=0) {
            //smallIV.centerY = centerY;
            //smallIV.centerX = centerX;
            smallIV.center = CGPointFromString([self.frameXArr objectAtIndex:arcFrame]);
            [self.frameXArr removeObjectAtIndex:arcFrame];
            NSLog(@"arcFrame%d",arcFrame);
            smallIV.frameWidth = 50;
            smallIV.frameHeight = 50;
            //smallIV.frame = CGRectMake(X,Y, 50, 50 );
            smallIV.backgroundColor = [UIColor whiteColor];
            [smallIV sd_setImageWithURL:[NSURL URLWithString:self.headListArr[i][@"avatar"]]];
            smallIV.tag = i;
            smallIV.clipsToBounds = YES;
            smallIV.layer.cornerRadius = 25;
            UITapGestureRecognizer * smallTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(smallTapAction:)];
            smallIV.userInteractionEnabled = YES;
            [smallIV addGestureRecognizer:smallTap];
            [_bView addSubview:smallIV];
            //}
            
        }
    }
    
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _bView.frame.origin.y + _bView.frame.size.height + 50, self.view.frame.size.width, 25)];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:16.0];
        _contentLabel.backgroundColor = [UIColor whiteColor];
        //_contentLabel.text = @"附近没有更多的朋友了...";
        _contentLabel.textColor = [UIColor grayColor];
        //[self.view addSubview:_contentLabel];
    }
    
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(30, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 30, self.view.frame.size.width - 60, 55);
        _shareBtn.backgroundColor = [UIColor colorWithRed:1 green:218 / 255.0 blue:69 / 255.0 alpha:1];
        //[_shareBtn setTitle:@"分享给朋友吧" forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"leida"] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _shareBtn.layer.cornerRadius = 10.0;
        _shareBtn.layer.masksToBounds = YES;
        [self.view addSubview:_shareBtn];
    }
}

#pragma mark -  随机数取值范围
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

-(float)randomFloatBetween:(float)num1 andLargerFloat:(float)num2
{
    int startVal = num1*10000;
    int endVal = num2*10000;
    
    int randomValue = startVal +(arc4random()%(endVal - startVal));
    float a = randomValue;
    
    return(a / 10000.0);
}

#pragma mark - shareAction

- (void)shareAction:(UIButton *)btn
{
    NSLog(@"点击了分享按钮");
}

#pragma mark - tapAction

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if (fabs(point.x - _bView.center.x) <= 40 && fabs(point.y - _bView.center.y) <= 40) {
        BYRadarView * radView = [[BYRadarView alloc] initWithFrame:_bView.bounds];
        radView.backgroundColor = [UIColor clearColor];
        [_bView addSubview:radView];
        [self animationRadarIconImageView:_iconImageView];
    }
}

#pragma mark -  点击头像事件

- (void)smallTapAction:(UITapGestureRecognizer *)smallTap{
    
    NSDictionary *dic = self.headListArr[smallTap.view.tag];
    
    SPProfileVC *vc = [[SPProfileVC alloc]init];
    vc.code  = dic[@"code"];
    vc.titleName = dic[@"nickName"];
    [self.navigationController pushViewController:vc animated:YES
     ];
}

- (void)animationRadarIconImageView:(UIImageView *)iconImageView
{
    [UIView animateWithDuration:.25 animations:^{
        iconImageView.transform = CGAffineTransformMakeScale(.8, .8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            iconImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.25 animations:^{
                iconImageView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

#pragma mark - initNav

- (void)initNav{
    
    self.titleLabel.text = @"查找中..";
    //    self.navigationController.navigationBar.hidden = YES;
    [self.rightButton setTitle:@"关闭" forState:0];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:0];
    [self addRightTarget:@selector(shat)];
   
    
}

-(void)shat{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    //发送通知 跳转到首页
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NotificationJumpToHome object:nil];
}

#pragma mark -  lazyLoad
- (NSMutableArray *)headListArr{
    
    if (!_headListArr) {
        _headListArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _headListArr;
}

- (NSMutableArray *)headListFrame{
    
    if (!_headListFrame) {
        _headListFrame = [NSMutableArray arrayWithCapacity:0];
    }
    return _headListFrame;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

