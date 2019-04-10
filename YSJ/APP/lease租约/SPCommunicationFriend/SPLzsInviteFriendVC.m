//
//  SPLzsInviteFriendVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "WXApi.h"
#import "WeiboSDK.h"
#import "SPLzsInviteFriendVC.h"
#import "SPIviteModel.h"
#import "SPInviteFriendTableCell.h"
#import "SPLzsGetAddressVC.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "SPCommon.h"
#import "SPKitExample.h"
@interface SPLzsInviteFriendVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * recommendTableView;
@property (nonatomic,strong) UIView * headView ;

@end

@implementation SPLzsInviteFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    [self getAddress];
    [self initNav];
    [self initUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - loadData
- (void)loadData{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    //[dict setObject:@(_start) forKey:@"pageNum"];
    //[dict setObject:@(10) forKey:@"pageSize"];
    //[dict setObject:self.contractDict forKey:@"mobiles"];
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"userCode"];
    
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:UrlOfLike parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"我的通讯录推荐%@",responseObject);
        for (NSDictionary * tempDict in responseObject[@"data"]) {
            SPIviteModel * model = [[SPIviteModel alloc]init];
            [model setValuesForKeysWithDictionary:tempDict];
            [self.dataArr addObject:model];
        }
        
        [_recommendTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - initUI
- (void)initUI{

    self.recommendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H2-SafeAreaTopHeight) style:UITableViewStylePlain];
    self.recommendTableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.recommendTableView.delegate=self;
    self.recommendTableView.dataSource=self;
    self.recommendTableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight, 0);
    self.recommendTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.recommendTableView.backgroundColor = WC;
    self.recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recommendTableView.showsHorizontalScrollIndicator = NO;
    self.recommendTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.recommendTableView];
    //footVIew
    UIView * bottomView = [[UIView alloc]init];
    
    self.recommendTableView.tableFooterView = bottomView;
    //HeadView
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 150)];
    self.headView.backgroundColor = WC;
    self.recommendTableView.tableHeaderView = self.headView;
    
    NSArray * imageArr = @[@"gtlb_txl",@"gtlb_wx",@"gtlb_qq",@"gtlb_wb"];
    for (int i =0; i<imageArr.count; i++) {
        
        UIImageView * inviteIV = [[UIImageView alloc]init];
        //边距
        //int backGauge = (SCREEN_W-((SCREEN_W-200)/4*4+4*50))/2;
        inviteIV.frame = CGRectMake(15+(SCREEN_W-200-30)/3*i+i*50, 20,50, 75);
        inviteIV.image = [UIImage imageNamed:imageArr[i]];
        inviteIV.tag = i+1;
        inviteIV.userInteractionEnabled = YES;
        inviteIV.contentMode = UIViewContentModeCenter;
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [inviteIV addGestureRecognizer:tapGR];
        
        [self.headView addSubview:inviteIV];
    }
    
    UILabel * recommendLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 40, 20)];
    recommendLab.textColor = [UIColor blackColor];
    recommendLab.text = @"推荐";
    recommendLab.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:recommendLab];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 149, SCREEN_W, 1)];
    lineView.backgroundColor = LineColor;
    [self.headView addSubview:lineView];
    
}

#pragma mark - tapClick
- (void)tapClick:(UITapGestureRecognizer *)tap{

    UIView * inviteIV = tap.view;
    if (inviteIV.tag==1) {//通讯录
        //Toast(@"点击了通讯录");
        if (self.contractDict.allKeys) {
            
            SPLzsGetAddressVC * addressVC = [[SPLzsGetAddressVC alloc]init];
            addressVC.contractDict = self.contractDict;
            [self.navigationController pushViewController:addressVC animated:YES];
        }else{
        
            Toast(@"暂时没有获取到通讯录信息");
        }
        
    }else if (inviteIV.tag==2){//微信
        
        WXMediaMessage *message = [WXMediaMessage  message];
        message.title = @"我在小猪约等你来 ！！";
        message.description = @"感受不一样的社交体验";
        
        [message setThumbImage:[self image:[UIImage imageNamed:@"app"] size:CGSizeMake(80, 80)]];
        
        WXWebpageObject *web = [WXWebpageObject object];
        web.webpageUrl = @"http://www.smallzhuyue.com/";
        message.mediaObject =web;
        
        SendMessageToWXReq *req  =[[SendMessageToWXReq alloc]init];
        req.bText =NO;
        req.message = message;
        //朋友列表
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    }else if (inviteIV.tag==3){//qq
        
        Toast(@"敬请期待");
        
    }else if (inviteIV.tag==4){//微博
        
        [self shareSinaWeiboWithText:@"我在小猪约等你来！！(分享自 @小猪约)" image:[UIImage imageNamed:@"app"]];
    }
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
#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * myInviteFiend = @"myInviteFiend";
    
    //SPMineNeededTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPInviteFriendTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SPInviteFriendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myInviteFiend];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WC;
    }
    
    if (self.dataArr.count) {
        if (self.dataArr) {
            
            SPIviteModel * model = self.dataArr[indexPath.row];
            [cell initWithModel:model];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 76;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPIviteModel * model = self.dataArr[indexPath.row];
    
    //跳转到个人详细
    YWPerson *person = [[YWPerson alloc]initWithPersonId:model.code];
    [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];

    
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}

- (NSMutableDictionary *)contractDict{
    
    if (!_contractDict) {
        _contractDict = [[NSMutableDictionary alloc]init];
    }
    return _contractDict;
}

#pragma mark -  initNav
- (void)initNav{

    self.titleLabel.text = @"通讯录";
    self.titleLabel.textColor = [UIColor blackColor];
}

- (void)getAddress{
    
    //判断授权状态
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined ||[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"授权成功");
                // 2. 获取联系人仓库
                CNContactStore * store = [[CNContactStore alloc] init];
                
                // 3. 创建联系人信息的请求对象
                NSArray * keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
                NSLog(@"%@",keys);
                // 4. 根据请求Key, 创建请求对象
                CNContactFetchRequest * request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                
                // 5. 发送请求
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    // 6.1 获取姓名
                    //NSString * givenName = contact.givenName;
                    NSString * familyName = contact.familyName;
                    
                    NSLog(@"%@",familyName);
                    
                    // 6.2 获取电话
                    NSArray * phoneArray = contact.phoneNumbers;
                    CNPhoneNumber * number;
                    NSLog(@"phoneArray%@",phoneArray);
                    for (CNLabeledValue * labelValue in phoneArray) {
                        
                        number = labelValue.value;
                        NSString * numberStr = [number.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
                       //NSString * numberStr1 = [numberStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                        NSString *cleaned = [[numberStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
                        [self.contractDict setValue:familyName forKey:cleaned];
                    }
                    //[self.contractDict setValue:familyName forKey:number.stringValue];
                    
                    
                }];
            } else {
                NSLog(@"授权失败");
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
