//
//  SPShareView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/10/10.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "WXApi.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "SPShareView.h"

@implementation SPShareView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLORA(0, 0, 0, 0.3);
        [self UI];
    }
    return self;
}

-(void)UI{
    
    NSArray *imgAtr = @[@"wx1",@"wx2",@"wb1"];
    
    for (int i=0; i<3; i++) {
        CGFloat btnW = SCREEN_W/3;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*btnW,IS_IPHONE_X?SCREEN_H2-88-49-btnW:SCREEN_H2-64-49-btnW, btnW, btnW);
        btn.tag= i;
        
        if (IS_IPHONE_6More) {
            btn.imageEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
        }else{
            btn.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 25, 25);
        }

        [btn setImage:[UIImage imageNamed:imgAtr[i]] forState:0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    }
}

-(void)btnClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            //朋友列表
            [self shareWXWithType:WXSceneSession];
            break;
        case 1:
            //朋友圈
            [self shareWXWithType:WXSceneTimeline];
            break;
        case 2:
            //微博
            [self shareSinaWeiboWithText:@"我在小猪约等你来！！(分享自 @小猪约)" image:self.shareImg];
            break;
        default:
            break;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = SCREEN_H2;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)shareWXWithType:(int)type{
    
    WXMediaMessage *message = [WXMediaMessage  message];
    message.title = self.title;
    message.description = self.subTitle;
    
    [message setThumbImage:[self image:self.shareImg size:CGSizeMake(80, 80)]];
    
    WXWebpageObject *web = [WXWebpageObject object];
    web.webpageUrl = self.shareUrl;
    NSLog(@"%@",self.shareUrl);
    message.mediaObject =web;
    
    SendMessageToWXReq *req  =[[SendMessageToWXReq alloc]init];
    req.bText =NO;
    req.message = message;
    req.scene = type;
    [WXApi sendReq:req];
}

//压缩图片
-(UIImage *)image:(UIImage *)image size:(CGSize)size{
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

// 发布图片文字等。
- (void)shareSinaWeiboWithText:(NSString *)text image:(UIImage *)image{
    
    if (![WeiboSDK isWeiboAppInstalled]) {
//        [self showLoadSinaWeiboClient];
    }else {
        
        WBMessageObject *message = [WBMessageObject message];
        message.text = text;
        
        // 消息的图片内容中，图片数据不能为空并且大小不能超过10M
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = UIImageJPEGRepresentation(image, 1.0);
        message.imageObject = imageObject;
        
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
    }
}

@end
