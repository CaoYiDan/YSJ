//
//  SPLzsGetAddressVC.m
//  SmallPig
//
//  Created by 李智帅 on 2017/11/6.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPLzsGetAddressVC.h"
#import "SPLzsGetAddressModel.h"
#import "SPLzsGetAddressTableCell.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "SPCommon.h"
#import "SPKitExample.h"
@interface SPLzsGetAddressVC ()<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>{
    
    
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * data1Arr;
@property (nonatomic,strong) UITableView * recommendTableView;


@end

@implementation SPLzsGetAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WC;
    //[self getAddress];
    [self initNav];
    [self initUI];
    [self loadData];
    
    // Do any additional setup after loading the view.
}

#pragma mark - loadData
- (void)loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    //[dict setObject:@(_start) forKey:@"pageNum"];
    //[dict setObject:@(10) forKey:@"pageSize"];
    [dict setObject:self.contractDict forKey:@"mobiles"];
    [dict setObject:[SPCommon getLoncationDic] forKey:@"location"];
    [dict setObject:[StorageUtil getCode] forKey:@"code"];
    
    NSLog(@"%@",dict);
    [[HttpRequest sharedClient]httpRequestPOST:UrlOfContract parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"我的通讯录%@",responseObject);

            //SPLzsGetAddressModel * model = [[SPLzsGetAddressModel alloc]init];
            //[model setValuesForKeysWithDictionary:tempDict];
            //model.registerUserList = tempDict[@"registerUserList"];
            //model.unregisteredUserList = model.unregisteredUserList;
            if (responseObject[@"data"][@"registerUserList"]) {
                self.dataArr = responseObject[@"data"][@"registerUserList"];
            }
            if (responseObject[@"data"][@"unregisteredUserList"]) {
                self.data1Arr = responseObject[@"data"][@"unregisteredUserList"];
            }
        
        
        [_recommendTableView reloadData];
        //[_myNeededDetailTableView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

#pragma mark - initUI
- (void)initUI{
    
    self.recommendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    self.recommendTableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.recommendTableView.delegate=self;
    self.recommendTableView.dataSource=self;
    
    self.recommendTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //self.recommendTableView.backgroundColor = WC;
    self.recommendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recommendTableView.showsHorizontalScrollIndicator = NO;
    self.recommendTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.recommendTableView];
    //footVIew
    UIView * bottomView = [[UIView alloc]init];
    
    self.recommendTableView.tableFooterView = bottomView;
   
    
}


#pragma mark -  UItableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * myGetAddress = @"myGetAddress";
    
    //SPMineNeededTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mySkillCell];
    
    SPLzsGetAddressTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SPLzsGetAddressTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myGetAddress];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WC;
    }
    
        //if (self.dataArr) {
            
            //SPLzsGetAddressModel * model = self.dataArr[indexPath.section];
            //[cell initWithModel:model withSection:indexPath.section];
        //}
    if (indexPath.section==0) {
        if (self.dataArr) {
            [cell initWithDict:self.dataArr[indexPath.row] withSection:0];
        }
    }else if (indexPath.section==1){
    
        if (self.data1Arr) {
            
            [cell initWithDict:self.data1Arr[indexPath.row] withSection:1];
        }
    }
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section==0) {
        UILabel * textLab = [[UILabel alloc]init];
        textLab.frame = CGRectMake(15, 5, SCREEN_W-50, 20);
        textLab.textAlignment = NSTextAlignmentLeft;
        if (self.dataArr) {
            
            textLab.text = [NSString stringWithFormat:@"      %lu个好友待添加",(unsigned long)self.dataArr.count];
        }
        
        textLab.textColor = RGBCOLOR(95, 95, 95);
        textLab.font = Font(13);
        return textLab;
    }
    UILabel * textLab = [[UILabel alloc]init];
    textLab.frame = CGRectMake(15, 5, SCREEN_W-50, 20);
    textLab.textAlignment = NSTextAlignmentLeft;
    if (self.dataArr) {
        //NSDictionary * dict = self.data1Arr;
        textLab.text = [NSString stringWithFormat:@"      %lu个好友待邀请",(unsigned long)self.data1Arr.count];
    }
    
    textLab.textColor = RGBCOLOR(95, 95, 95);
    textLab.font = Font(13);
    return textLab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 76;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
       return self.dataArr.count;
    }
    return  self.data1Arr.count;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath.section==0) {
        //聊天 获取code
        NSString * codeNum = self.dataArr[indexPath.row][@"code"];
        NSLog(@"codeNum%@",codeNum);
        
        YWPerson *person = [[YWPerson alloc]initWithPersonId:codeNum];
        [[SPKitExample sharedInstance]exampleOpenConversationViewControllerWithPerson:person fromNavigationController:[SPCommon getCurrentVC].navigationController];
        
    }else if (indexPath.section==1){
    //邀请 获取手机号
        NSString * phoneNum = self.data1Arr[indexPath.row][@"mobile"];
        NSLog(@"phoneNum%@",phoneNum);
        
        [self sendMessageWithNumber:phoneNum];
    }
    
}
- (void)sendMessageWithNumber:(NSString *   )num{
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:num forKey:@"phone"];
    
    UIAlertAction * alertAc = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    
        [[HttpRequest sharedClient]httpRequestPOST:KUrlGetCity parameters:dict progress:^(NSProgress *downloadProgress) {
            
        } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            
            Toast(@"邀请短信发送成功");
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }];
    UIAlertAction * alertNo = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"邀请提示" message:@"您是否要邀请该用户" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:alertAc];
    [alertVC addAction:alertNo];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
- (void)getAddress{

    //判断授权状态
    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
        
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
                        
                        NSLog(@"电话:%@--姓名:%@", number.stringValue, familyName);
                    }
                    [self.contractDict setValue:familyName forKey:number.stringValue];
                }];
            } else {
                NSLog(@"授权失败");
            }
        }];
    }
    
    
}

#pragma mark -  lazyLoad
- (NSMutableArray * )dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
    }
    return _dataArr;
}

- (NSMutableArray * )data1Arr{
    
    if (!_data1Arr) {
        _data1Arr = [[NSMutableArray alloc]init];
        
    }
    return _data1Arr;
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
@end
