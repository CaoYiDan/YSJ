//
//  SPCategorySwichVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/24.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPCategorySwichVC.h"
CGFloat const titleHeightCategory = 43;
@interface SPCategorySwichVC ()<UIScrollViewDelegate>
@property(nonatomic , strong)UIScrollView *contentView;
@property(nonatomic , strong)UIView *titleView;
@property(nonatomic ,strong)UIButton *selectedButton;
@property(nonatomic ,strong)UIImageView *silderImg;

@end

@implementation SPCategorySwichVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self contentView];
    
    [self ls_titleHeader];
    
    [self switchController:0];
}

-(void)ls_titleHeader{
    
    NSArray *titleArr = [[NSArray alloc]init];
    
    if (self.delegate) {
        titleArr = [self.delegate titleArrInSwitchView];
    }
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,titleHeightCategory)];
    _titleView = titleView;
    NSInteger i = 0;
    
    CGFloat wid = 60;
    
    for (NSString *titleText in titleArr) {
        
        UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-wid+i*wid, 0, wid, titleHeightCategory-3)];
        btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
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
    UIImageView *silderImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/2-wid,titleHeightCategory-4, wid, 3)];
    _silderImg = silderImg;
    _silderImg.image = [UIImage imageNamed:@"yy_r1_c3"];
    [_titleView addSubview:silderImg];
    
    //设置contentView的可滑动区域
    _contentView.contentSize = CGSizeMake(i*[UIScreen mainScreen].bounds.size.width, 0) ;
    [self.view addSubview:titleView];
    
    //    titleView.ls_titleBlock = ^(NSInteger index){
    
    //    };
}

-(UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,titleHeightCategory, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
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
    UIViewController *vc = nil;
    
    if (self.delegate) {
        vc = [self.delegate swithchVCForRowAtIndex:index];
        [self addChildViewController:vc];
    }
    
    vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width* index, 0, [UIScreen mainScreen].bounds.size.width,SCREEN_H2-64-titleHeightCategory);
    
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.2 animations:^{
        _silderImg .originX = scrollView.contentOffset.x/scrollView.contentSize.width*120+SCREEN_W/2-60;
    }];
}
#pragma mark - createNav
- (void)createNav{
    
//    self.titleLabel.text = @"网站建设";
//    self.titleLabel.textColor = [UIColor blackColor];
//    
//    [self.rightButton setTitle:@"附近" forState:UIControlStateNormal];
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addRightTarget:@selector(rightButtonClick)];
}

#pragma mark - 附近
- (void)rightButtonClick{
    
    
}

@end
