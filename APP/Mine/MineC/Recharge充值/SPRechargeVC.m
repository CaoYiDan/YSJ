//
//  SPRechargeVC.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/4.
//  Copyright © 2017年 李智帅. All rights reserved.

#import "WXApi.h"
#import "SPRechargeModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SPRechargeVC.h"
#import "SP.h"
#import "SPPayTypeCell.h"
#import "UILabel+Extension.h"
#import "SPRechargeCell.h"
#import "SPReusableViewFooter.h"
#import "SPReusableViewHeader.h"

@interface SPRechargeVC ()<SPPayTypeCellTapDelegate,UICollectionViewDataSource,UICollectionViewDelegate,WXApiDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UICollectionView*collectionview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)UILabel *payTitle;

@property(nonatomic,strong)UILabel *bottomTip;

@end

@implementation SPRechargeVC
{
    UILabel *_totalMoney;
    CGFloat _payMoney;
    BOOL _ifPayOtherMoney;//是否是其他金额
    NSString *_payType;
    SPRechargeModel *_chosedModel;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = HomeBaseColor;
    self.navigationItem.title = @"充值";

    
    //默认支付方式
    _payType = WXPay;
    
    [self createTitle];
    
    [self.view addSubview:self.collectionview];

    [self createFooter];
    
    [self getRechargeList];
}


#pragma  mark - -----------------数据请求-----------------
#pragma  mark  获取充值数值列表

-(void)getRechargeList{
    showMBP;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"NORMAL" forKey:@"status"];
    [[HttpRequest sharedClient]httpRequestPOST:KUrlRechargeList parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"返回数据%@",responseObject);
        self.dataArr = [SPRechargeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.collectionview reloadData];
        hidenMBP;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        hidenMBP;
    }];
}

#pragma  mark  从后台获取签名String

-(void)getOrderStringFromJava
{
    
    if (isEmptyString(_payType))
    {
        Toast(@"请选择支付方式");
        return;
    }
    
    if (isEmptyString(_totalMoney.text))
    {
        Toast(@"请选择支付金额");
        return;
    }
    
    showMBP;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[StorageUtil getCode] forKey:@"code"];
    
    if (_ifPayOtherMoney)
    {
        [dic setObject:@(_payMoney) forKey:@"fee"];
    }else
    {
        [dic setObject:_chosedModel.rechargeId forKey:@"rechargeId"];
    }
    
    [dic setObject:_payType forKey:@"payChannel"];
    
    [[HttpRequest sharedClient]httpRequestPOST:kUrlForPay parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj)
    {
        hidenMBP;
        
        if ([_payType isEqualToString:WXPay])
        {
           
            [self WXPayWithDict:responseObject[@"data"][@"data"]];
            
        }else if ([_payType isEqualToString:AliPay])
        {
          
            [[AlipaySDK defaultService] payOrder:responseObject[@"data"][@"data"] fromScheme:@"smallpigalipay" callback:^(NSDictionary *resultDic)
            {
                
            }];
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"服务器错误");
        hidenMBP;
    }];
}

#pragma  mark  调用微信客户端

-(void)WXPayWithDict:(NSDictionary*)credential{
    
    NSString* timeStamp = [NSString stringWithFormat:@"%@",[credential objectForKey:@"timestamp"]];
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = [credential objectForKey:@"partnerid"];
    request.prepayId= [credential objectForKey:@"prepayid"];
    request.package = @"Sign=WXPay";
    request.nonceStr= [credential objectForKey:@"noncestr"];
    request.timeStamp= [timeStamp intValue];
    request.sign= [credential objectForKey:@"sign"];
    [WXApi sendReq:request];
}

#pragma  mark - -----------------UICollectionViewDelegate-----------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0) return self.dataArr.count==0?0:self.dataArr.count+1;
    return 2;
}

#pragma  mark 返回 UICollectionViewCell*

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0)
    {
        SPRechargeCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPRechargeCellID forIndexPath:indexPath];
        if (indexPath.row == self.dataArr.count)
        {
            cell.indexRow = indexPath.row;
        }else
        {
       cell.rechargeModel = self.dataArr[indexPath.row];
        }
        return cell;
    }else if (indexPath.section==1)
    {
    SPPayTypeCell*  cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPPayTypeCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.indexPath = indexPath;
        if (indexPath.row==0) {
            [cell setCellSelected:YES];
        }
    return cell;
    }
    return nil;
}

#pragma  mark 返回的cell大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return CGSizeMake(SCREEN_W/2, 65);
    }
    return CGSizeMake(SCREEN_W, 60);
}

#pragma  mark 边缘大小

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0)
    {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
        return UIEdgeInsetsMake(1, 0, 0, 0);
}

#pragma  mark cell水平间距

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma  mark 竖间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) return 1;
    return 0;
}

#pragma  mark 返回的header视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==1)  return CGSizeMake(SCREEN_W, 60);
    return CGSizeZero;
}

#pragma  mark 返回的footer大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section==1)  return CGSizeMake(SCREEN_W, 50);
    return CGSizeZero;
}

#pragma  mark 返回Header视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind==UICollectionElementKindSectionHeader) {
      SPReusableViewHeader *reusableview =
        [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SPReusableViewHeaderID forIndexPath:indexPath];
        reusableview.backgroundColor = [UIColor whiteColor];
        [reusableview addSubview:self.payTitle];
        return reusableview;
       
    }else{
        
        SPReusableViewFooter *reusableview =
        [collectionView dequeueReusableSupplementaryViewOfKind:
kind                                           withReuseIdentifier:SPReusableViewFooterID forIndexPath:indexPath];
        [reusableview addSubview:self.bottomTip];
        return reusableview;
    }
}

#pragma mark 点击cell

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==self.dataArr.count)
    {
        _ifPayOtherMoney = YES;
        [self otherTextFiled];
    }else
    {
        _ifPayOtherMoney = NO;
       
        SPRechargeModel *rechargeM = self.dataArr[indexPath.row];
        _chosedModel = rechargeM;
        [self getTotalMoney:rechargeM.rechargeFee];
    }
}

#pragma  mark - -----------------选择支付方式的代理回传-----------------

-(void)SPPayTypeCellSelectedIndex:(NSIndexPath *)selectedIndexPath{
    
//    if (selectedIndexPath.row==0) {
//        Toast(@"微信支付咱不支持");
//        return;
//    }
    
    //更改支付方式参数
    NSArray *payTypeArr = @[WXPay,AliPay];
    _payType = payTypeArr[selectedIndexPath.row];

    //选中当前cell（小红点）
    SPPayTypeCell *cell = (SPPayTypeCell *)[self.collectionview cellForItemAtIndexPath:selectedIndexPath];
    [cell setCellSelected:YES];

    //获取未选中的cell
    NSInteger indexRow =  (selectedIndexPath.row+1)%2;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexRow inSection:1];
    //置灰色
    SPPayTypeCell *cell2 = (SPPayTypeCell *)[self.collectionview cellForItemAtIndexPath:indexPath];
    [cell2 setCellSelected:NO];
    
}

#pragma  mark - -----------------textFieldDelegate-----------------
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
     [textField.superview removeFromSuperview];
    
    if ([textField.text doubleValue]<10 || [textField.text doubleValue]>2999)
    {
        
        MBProgressHUD  *HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES]; //HUD效果添加哪个视图上
        HUD.labelText = @"不能小于10或者大于2999";
        
        [HUD hide:YES afterDelay:1.5];
        
        return ;
    }
    
    [self getTotalMoney:[NSString stringWithFormat:@"%.2f",[textField.text doubleValue]]];
    
}

#pragma  mark - -----------------action-----------------

#pragma  mark  输入其他金额 点击确认

-(void)sure:(UIButton *)btn{
    
    [self.view endEditing:YES];
    [btn.superview removeFromSuperview];
}

#pragma  mark  确认付款

-(void)gotoRecharge{
    //从后台获取签名String
    [self getOrderStringFromJava];
}

#pragma  mark  根据选择的价格，更改底部价钱显示数额

-(void)getTotalMoney:(NSString *)totalMoney{
    _payMoney = [totalMoney doubleValue];
    _totalMoney.text = [NSString stringWithFormat:@"金额:%@元",totalMoney];
    NSRange range = NSMakeRange(0, 3);
    [_totalMoney setAttributeTextWithString:_totalMoney.text range:range WithColour:[UIColor blackColor]];
}

#pragma  mark - -----------------setter-----------------
-(void)createFooter{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H2-50-SafeAreaTopHeight-SafeAreaBottomHeight, SCREEN_W, 50+SafeAreaBottomHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel *totalMoney = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, SCREEN_W-150-kMargin, 50)];
    totalMoney.textColor = PrinkColor;
    
    totalMoney.adjustsFontSizeToFitWidth = YES;
    _totalMoney = totalMoney;
    [bottomView addSubview:totalMoney];
    
    UIButton *gotoRecharge = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-150, 0, 150, 50)];
    gotoRecharge.backgroundColor = PrinkColor;
    [gotoRecharge setTitleColor:[UIColor whiteColor] forState:0];
    [gotoRecharge setTitle:@"确认充值" forState:0];
    gotoRecharge.titleLabel.font = font(14);
    [gotoRecharge addTarget:self action:@selector(gotoRecharge) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:gotoRecharge];
}


-(void)createTitle
{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 40)];
    title.font = kFontNormal;
    title.adjustsFontSizeToFitWidth = YES;
    title.textColor = [UIColor grayColor];
    title.text = @"请选择你需要充值的金额，可充值金额10-2999元";
    [self.view addSubview:title];
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

#pragma  mark 创建collectionView

-(UICollectionView *)collectionview
{
    if (!_collectionview)
    {
        // 创建瀑布流布局
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, [UIScreen mainScreen].bounds.size.width,SCREEN_H-40-50) collectionViewLayout:layout];
        //代理
        _collectionview.delegate=self;
        _collectionview.dataSource=self;
        
        _collectionview.backgroundColor = HomeBaseColor;
        _collectionview.showsVerticalScrollIndicator = NO;
        
        //注册
        [_collectionview registerClass:[SPRechargeCell class] forCellWithReuseIdentifier:SPRechargeCellID];
        [_collectionview registerClass:[SPPayTypeCell class] forCellWithReuseIdentifier:SPPayTypeCellID];
        
        //        reusableViewHeaderID
        [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPReusableViewHeaderID];
        
        [_collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SPReusableViewFooterID];
    }
    return _collectionview;
}

#pragma  mark  其他金额View

-(void)otherTextFiled{
    
    UIView *base = [[UIView alloc]initWithFrame:self.view.bounds];
    base.backgroundColor = RGBA(0, 0,0, 0.5);
    [self.view addSubview:base];
    
    UITextField *otherFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, SCREEN_H/1.5,SCREEN_W-150,50)];
    otherFiled.backgroundColor = [UIColor whiteColor];
    otherFiled.placeholder = @"其他金额";
    otherFiled.delegate = self;
    [otherFiled becomeFirstResponder];
    otherFiled.textAlignment=NSTextAlignmentCenter;
    otherFiled.keyboardType = UIKeyboardTypeNumberPad;
    [base addSubview:otherFiled];
    
    UIButton *gotoRecharge = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-150, SCREEN_H/1.5, 150, 50)];
    gotoRecharge.backgroundColor = PrinkColor;
    [gotoRecharge setTitleColor:[UIColor whiteColor] forState:0];
    [gotoRecharge setTitle:@"确定" forState:0];
    gotoRecharge.titleLabel.font = font(14);
    [gotoRecharge addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchDown];
    [base addSubview:gotoRecharge];
}

-(UILabel *)payTitle{
    if (!_payTitle) {
        _payTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W, 65)];
        _payTitle.textColor = [UIColor grayColor];
        _payTitle.text = @"支付方式";
    }
    return _payTitle;
}

-(UILabel *)bottomTip
{
    if (!_bottomTip)
    {
        _bottomTip = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 40)];
        _bottomTip.adjustsFontSizeToFitWidth = YES;
        _bottomTip.text = @"注：充值返现为限时活动，最终解释权归小猪约平台所有";
    }
    return _bottomTip;
}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                Toast(@"充值成功！");
                break;
           
            default:
             Toast(@"充值失败。");
                break;
        }
    }
}

@end
