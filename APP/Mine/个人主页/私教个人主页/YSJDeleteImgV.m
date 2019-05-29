//
//  SPCanDeleteImgView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/14.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "YSJDeleteImgV.h"

@implementation YSJDeleteImgV
{
    UIButton *_deleteBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addUI];
    }
    return self;
}

-(void)addUI{
    
    _img = [[UIImageView alloc]init];
    _img.layer.cornerRadius = 8;
    _img.clipsToBounds =YES;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.userInteractionEnabled = YES;
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.offset(5);
        make.right.offset(-5);
        make.bottom.offset(-5);
    }];
    
    UIButton *delete = [[UIButton alloc]initWithFrame:CGRectMake(0 , 0, 20, 20)];
    [delete setImage:[UIImage imageNamed:@"shanchu2"] forState:0];
    _deleteBtn = delete;
    delete.hidden = YES;
    [delete addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:delete];
    

    //长按事件
     UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
     longPress.minimumPressDuration = 0.8; //定义按的时间
     [self addGestureRecognizer:longPress];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
       if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
           
//           CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//           animation.keyPath = @"transform.scale";
//           animation.values = @[@1.0,@1.2,@0.9,@1.0];
//           animation.duration = 0.3;
//           animation.calculationMode = kCAAnimationCubic;
//           //添加动画
//           [self.layer addAnimation:animation forKey:nil];
       }else if ([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
           
           _deleteBtn.hidden = NO;
       }else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
           
           _deleteBtn.hidden = NO;
       }
}

-(void)deleteClick{
    
    !self.deleteblock?: self.deleteblock(self.tag);
    
    [self removeFromSuperview];
    [self.superview layoutSubviews];
    [self.superview layoutIfNeeded];
    [self deleteImg];
}

-(void)deleteImg{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:self.url forKey:@"imgurl"];
   
    
    NSLog(@"%@",dic);
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    // 在parameters里存放照片以外的对象
    [manager POST:YShow parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];
    
}

@end
