//
//  AppDelegate.h
//  SmallPig
//
//  Created by 李智帅 on 2017/5/26.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@end

