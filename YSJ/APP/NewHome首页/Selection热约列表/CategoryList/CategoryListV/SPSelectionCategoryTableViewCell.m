//
//  SPSelectionCategoryTableViewCell.m
//  SmallPig
//
//  Created by 李智帅 on 2017/8/30.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSelectionCategoryTableViewCell.h"
#import "SPCommon.h"
#import "SPKitExample.h"
@implementation SPSelectionCategoryTableViewCell

//- (instancetype)initWithFrame:(CGRect)frame{
//
//    if (self = [super initWithFrame:frame]) {
//        
//        
//    }
//    return self;
//}

- (void)initWithModel:(SPSelectionCategoryModel *)model{

    
    self.codeStr = model.code;
    self.topView = [[SPSelectionCategoryView alloc]initWithFrame:CGRectMake(0,-50, SCREEN_W, 200)];
    
    self.topView.user = model;
    [self addSubview:self.topView];
    //武功标签
    CGFloat wid = (SCREEN_W-60-20-20)/3;
    
    NSMutableArray *textArr = [[NSMutableArray alloc]init];
    int bottomMark=200;
    int type =0;
    
    if (model.skills.count>0) {
        for (int i=0; i<model.skills.count; i++) {
            [textArr addObject:model.skills[i]];
        }
        
        NSArray *colorArr = @[LIGHTPURPLECOLOR,LIGHTPRINKCOLOR,LIGHTGREENCOLOR,LIGHTBULECOLOR,LIGHTBLUECOLOR2,LIGHTORANGECOLOR];
        
        for (int i=0; i<model.skills.count; i++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10+i%3*(wid+10), CGRectGetMaxY(self.topView.frame)+65+i/3*35, wid, 30)];
            
            lab.textAlignment= NSTextAlignmentCenter;
            lab.adjustsFontSizeToFitWidth = YES;
            lab.textColor = [UIColor blackColor];
            lab.layer.cornerRadius = 5;
            lab.text = textArr[i];
            lab.backgroundColor = colorArr[i];
            lab.clipsToBounds  = YES;
            lab.font = font(12);
            [self addSubview:lab];
            
            //        //更改一下self的高度，适配
            //        if (i==textArr.count-1) {
            //            self.frameHeight = CGRectGetMaxY(lab.frame)+20;
            //        }
        }
        bottomMark = 250;
        type=1;
    }
    
    if (model.tags.count>0) {
        NSMutableArray *tagsArr = [[NSMutableArray alloc]init];
        
        if (model.tags.count>3) {
            for (int i=0; i<3; i++) {
                [tagsArr addObject:model.tags[i]];
            }
            NSArray *colorArr = @[LIGHTBULECOLOR,LIGHTBLUECOLOR2,LIGHTORANGECOLOR,LIGHTPURPLECOLOR,LIGHTPRINKCOLOR,LIGHTGREENCOLOR];
            
            for (int i=0; i<3; i++) {
                
                
                UILabel *lab = [[UILabel alloc]init];
                if (type==1) {
                    
                    lab.frame= CGRectMake(10+i%3*(wid+10), 200+65+i/3*35, wid, 30);
                }else{
                    
                    lab.frame= CGRectMake(10+i%3*(wid+10), CGRectGetMaxY(self.topView.frame)+65+i/3*35, wid, 30);
                }
                lab.textAlignment= NSTextAlignmentCenter;
                lab.adjustsFontSizeToFitWidth = YES;
                lab.textColor = [UIColor blackColor];
                lab.layer.cornerRadius = 5;
                lab.text = tagsArr[i];
                lab.backgroundColor = colorArr[i];
                lab.clipsToBounds  = YES;
                lab.font = font(12);
                [self addSubview:lab];
                
                //        //更改一下self的高度，适配
                //        if (i==textArr.count-1) {
                //            self.frameHeight = CGRectGetMaxY(lab.frame)+20;
                //        }
            }
        }else{
        
            for (int i=0; i<model.tags.count; i++) {
                [tagsArr addObject:model.tags[i]];
            }
            
            NSArray *colorArr = @[LIGHTBULECOLOR,LIGHTBLUECOLOR2,LIGHTORANGECOLOR,LIGHTPURPLECOLOR,LIGHTPRINKCOLOR,LIGHTGREENCOLOR];
            
            for (int i=0; i<model.tags.count; i++) {
                
                UILabel *lab = [[UILabel alloc]init];
                if (type==1) {
                    
                    lab.frame= CGRectMake(10+i%3*(wid+10), 200+65+i/3*35, wid, 30);
                }else{
                
                    lab.frame= CGRectMake(10+i%3*(wid+10), CGRectGetMaxY(self.topView.frame)+65+i/3*35, wid, 30);
                }
                lab.textAlignment= NSTextAlignmentCenter;
                lab.adjustsFontSizeToFitWidth = YES;
                lab.textColor = [UIColor blackColor];
                lab.layer.cornerRadius = 5;
                lab.text = tagsArr[i];
                lab.backgroundColor = colorArr[i];
                lab.clipsToBounds  = YES;
                lab.font = font(12);
                [self addSubview:lab];
                
                //        //更改一下self的高度，适配
                //        if (i==textArr.count-1) {
                //            self.frameHeight = CGRectGetMaxY(lab.frame)+20;
                //        }
            }
        }
        
        if (type==1) {
            bottomMark =310;
        }else{
        
            bottomMark=250;
        }
    }
    
    
    UIView * firstView = [[UIView alloc]initWithFrame:CGRectMake(10, bottomMark, SCREEN_W-20, 1)];
    
    firstView.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1];
    
    [self addSubview:firstView];
    //沟通
    self.chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chatBtn.frame = CGRectMake(0, bottomMark+5, SCREEN_W/2, 30);
    //self.chatBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.chatBtn.layer.borderWidth = 1;
    [self.chatBtn setTitle:@"沟通" forState:UIControlStateNormal];
    [self.chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.chatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.chatBtn];
    //关注
    
    UIView * secondView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/2, bottomMark+5,1,30)];
    
    secondView.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1];
    
    [self addSubview:secondView];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn.frame = CGRectMake(SCREEN_W/2, bottomMark+5, SCREEN_W/2, 30);
    //self.focusBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //self.focusBtn.layer.borderWidth = 1;
    [self.focusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[self.focusBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.focusBtn addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (model.followed) {
        //self.focusBtn.selected = YES;
        [self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        
        //self.focusBtn.selected = NO;
        [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
    
    [self addSubview:self.focusBtn];
    
    UIView * thirdView = [[UIView alloc]initWithFrame:CGRectMake(10,bottomMark+40,SCREEN_W-20, 1)];
    
    thirdView.backgroundColor = [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1];
    
    [self addSubview:thirdView];
}

//沟通
- (void)chatBtnClick{

    if (!isEmptyString([StorageUtil getCode])) {
        YWPerson *person = [[YWPerson alloc]initWithPersonId:self.codeStr];
        
        [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
    }else{
    
        RegisterViewController * registerVC = [[RegisterViewController alloc]init];
        [[SPCommon getCurrentVC] presentViewController:registerVC animated:YES completion:nil];
    }
    
 
}
//关注
- (void)focusBtnClick:(UIButton *)btn{
    
    
    if (!isEmptyString([StorageUtil getCode])){
        NSLog(@"%@getCode",[StorageUtil getCode]);
        NSString * kurl;
        if ([btn.titleLabel.text isEqualToString:@"关注"]) {
            //[self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
            kurl = FollowUrl;
        }else{
            
            //[self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
            kurl = CancelFollowUrl;
        }
        NSDictionary * dict = @{@"followerCode":[StorageUtil getCode],@"userCode":self.codeStr};
        
        NSLog(@"%@",dict);
        [[HttpRequest sharedClient]httpRequestPOST:kurl parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
            //NSLog(@"yuyue%@",responseObject);
            if ([btn.titleLabel.text isEqualToString:@"关注"]) {
                [self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
                
            }else{
                
                [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
                
            }
            Toast(@"操作成功");
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else{
        
        RegisterViewController * registerVC = [[RegisterViewController alloc]init];
        [[SPCommon getCurrentVC] presentViewController:registerVC animated:YES completion:nil];
    }
    
    
    
}
@end
