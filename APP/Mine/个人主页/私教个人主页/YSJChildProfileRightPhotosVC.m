//
//  YSJChildProfileRightPhotosVC.m
//  SmallPig
//
//  Created by xujf on 2019/5/21.
//  Copyright © 2019年 lisen. All rights reserved.


#import "YSJPhotosForProfileView.h"
#import "YSJChildProfileRightPhotosVC.h"

@interface YSJChildProfileRightPhotosVC ()
@property (nonatomic,strong) YSJPhotosForProfileView *photosV;
@property (nonatomic,strong) NSMutableArray *urlArr;
@property (nonatomic,strong) UIScrollView *scroll;
@end

@implementation YSJChildProfileRightPhotosVC
{
    
    NSMutableArray *_bannerArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setBaseView];
    
    self.photosV.backgroundColor = KWhiteColor;
    
    [self getBannerBaseRequestisScu:^(BOOL isScu) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor hexColor:@"F5F5F5"];

}

#pragma mark 获取轮播图基本信息

-(void)getBannerBaseRequestisScu:(void(^)(BOOL isScu))requestisScu{
    self.urlArr = @[].mutableCopy;
    [[HttpRequest sharedClient]httpRequestGET:[NSString stringWithFormat:@"%@?id=%@",YTeacherBanner,@"17610240017"] parameters:nil progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        self.urlArr = responseObject[@"pic_url"];
        
        _bannerArr = @[].mutableCopy;
        _bannerArr = responseObject[@"pic_url"];
        
//        for (NSString *str in responseObject[@"pic_url"]) {
//            [_bannerArr addObject:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,str]];
//        }
//
        [self.photosV setPhotoImg:_bannerArr];
        
        requestisScu(YES);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        requestisScu(NO);
        
    }];
    
}


-(void)setBaseView{
    
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(kMargin, 0, kWindowW-2*kMargin, kWindowH-348)];
    _scroll.backgroundColor = KWhiteColor;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scroll];
}

- (YSJPhotosForProfileView *)photosV{
    if (!_photosV) {
        _photosV = [[YSJPhotosForProfileView alloc]initWithFrame:CGRectMake(0, 0, kWindowW-2*kMargin, kWindowH)];
//        _photosV.backgroundColor  = KMainColor;
        [_scroll addSubview:_photosV];
        WeakSelf;
        _photosV.block = ^{
            //刷新
            [weakSelf getBannerBaseRequestisScu:^(BOOL isScu) {}];
             };
        _photosV.contentofYChangeBlock = ^(CGFloat contentofY) {
            weakSelf.scroll.contentSize = CGSizeMake(0, contentofY<(kWindowH-348)?(kWindowH-328):contentofY);
        };
    }
    return _photosV;
}
@end
