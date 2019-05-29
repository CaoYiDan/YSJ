//
//  LS_SwitchVC.m
//  LS_Small_Switch
//
//  Created by 融合互联-------lisen on 17/6/22.
//  Copyright © 2017年 RTWM. All rights reserved.
//

#import "LS_SwitchVC.h"
//#import "LS_TitleBtn_View.h"
CGFloat const titleHeight = 43;
@interface LS_SwitchVC ()<UIScrollViewDelegate>
@property(nonatomic , strong)UIScrollView *contentView;
@property(nonatomic , strong)UIView *titleView;
@property(nonatomic ,strong)UIButton *selectedButton;
@property(nonatomic ,strong)UIImageView *silderImg;
@end

@implementation LS_SwitchVC
{
    BOOL _push;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self contentView];
  
    [self ls_titleHeader];
    
    [self switchController:0];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
////    if (_push) {
////        _titleView.originY = 64;
////        _contentView.originY = 64+40;
////    }
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
////    _push = YES;
//}

-(void)ls_titleHeader{
    
    NSArray *titleArr = [[NSArray alloc]init];
    
    if (self.delegate) {
       titleArr = [self.delegate titleArrInSwitchView];
    }

    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,titleHeight)];
    _titleView = titleView;
    NSInteger i = 0;
    
    CGFloat wid = SCREEN_W/titleArr.count;
    
    for (NSString *titleText in titleArr) {
        
        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-wid+i*wid, 0, wid, titleHeight-3)];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        btn.titleLabel.font = font(15);
        [btn setTitle:titleText forState:0];
        [titleView addSubview:btn];
        
        if (self.delegate) {
            UIViewController *vc = [self.delegate swithchVCForRowAtIndex:i];
            [self addChildViewController:vc];
        }
        if (i==0) {
            btn.selected = YES;
            self.selectedButton = btn;
        }
        i++;
    }
    
    //底部滑动View
    UIImageView *silderImg = [[UIImageView alloc]initWithFrame:CGRectMake(wid/2-35,titleHeight-4, 70, 3)];
    _silderImg = silderImg;
    _silderImg.image = [UIImage imageNamed:@"yy_r1_c3"];
//    [_titleView addSubview:silderImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2, 5, 1, 30)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_titleView addSubview:line];
    
    //设置contentView的可滑动区域
    _contentView.contentSize = CGSizeMake(i*[UIScreen mainScreen].bounds.size.width, 0) ;
    [self.view addSubview:titleView];
    
//    titleView.ls_titleBlock = ^(NSInteger index){
    
//    };
}

-(UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,titleHeight+1, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _contentView.delegate  = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator   = NO;
        _contentView.pagingEnabled                  = YES;
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

-(void)click:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    self.selectedButton.selected = !self.selectedButton.isSelected;
    self.selectedButton =  btn;
    
    [self switchController:btn.tag];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        _silderImg .centerX = btn.centerX;
//    }];
}

- (void)switchController:(NSInteger)index
{
    UIViewController *vc = [[UIViewController alloc]init];
    
    if (self.delegate) {
        vc = [self.delegate swithchVCForRowAtIndex:index];
        [self addChildViewController:vc];
    }
    
   vc = self.childViewControllers[index];
   vc.view.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width* index, 0, [UIScreen mainScreen].bounds.size.width,SCREEN_H2-SafeAreaTopHeight-titleHeight-SafeAreaBottomHeight);
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:vc.view];
    
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.frame.size.width, self.contentView.contentOffset.y) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(nonnull UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self click:self.titleView.subviews[index]];
    [self switchController:index];
}

- (void)scrollViewDidEndScrollingAnimation:(nonnull UIScrollView *)scrollView
{
    [self switchController:(int)(scrollView.contentOffset.x / scrollView.frame.size.width)];
}

#pragma mark - createNav
- (void)createNav{

    self.titleLabel.text = @"关注";
    self.titleLabel.textColor = TitleColor;
    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backClick{

    [self.navigationController popViewControllerAnimated:YES];
}

@end
