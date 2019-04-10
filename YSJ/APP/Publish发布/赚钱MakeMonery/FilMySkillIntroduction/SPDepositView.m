//
//  SPDepositView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 2017/12/4.
//  Copyright © 2017年 李智帅. All rights reserved.
//
#import "SPDepositModel.h"
#import "SPDepositView.h"
#import "NSString+getSize.h"
@implementation SPDepositView
{
    UIButton *_selectedDepositButton;
    NSArray *_textArr;
    UILabel *_description;
    double _totalFeeStr;
    double _selectedMoney;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (instancetype)initWithFeeType:(NSString *)feeType
{
    self = [super init];
    if (self) {
        _textArr = @[].mutableCopy;
        self.feeType= feeType;
        [self getData];
    }
    return self;
}

//获取我的钱包，查看我有多少钱
-(void)getMyWall
{
    [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[StorageUtil getCode] forKey:@"accountUserId"];
    [[HttpRequest sharedClient]httpRequestPOST:URLOfMineWallet parameters:dict progress:^(NSProgress *downloadProgress) {
        
    } sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"我的钱包%@",responseObject);
        
        [MBProgressHUD hideHUDForView:self.superview animated:YES];
        
        _totalFeeStr = [responseObject[@"data"][@"totalFee"] doubleValue];
        
        SPDepositModel *bailM = _textArr[_selectedDepositButton.tag];
        [self ifBailEnoughWithModel:bailM];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUDForView:self.superview animated:YES];
        
    }];
}

-(void)getData{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"NORMAL" forKey:@"status"];
    [dic setObject:self.feeType forKey:@"feeType"];
    [[HttpRequest sharedClient]httpRequestPOST:kUrlBailList parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        _textArr = [SPDepositModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self setUI];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)setUI
{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 120, 40)];
    title.font = BoldFont(18);
    title.text = @"需求描述";
    [self addSubview:title];
    
    SPDepositModel *bailM = _textArr[0];
    
    NSString * descriptionText = [NSString stringWithFormat:@"%@\n%@",@"温馨提示：有60%的用户支付了100元诚意金找到了满意的服务者，我们将为您优先通知性别、年龄、服务均符合的服务者，若您的需求过期或取消，诚意金将退回您的小猪约账户。注：服务者会优先接受诚意金订单，提高诚意金有助于服务者快速接单。",bailM.note];
    CGFloat descriptionH = [descriptionText sizeWithFont:font(13) maxW:SCREEN_W-2*kMargin].height;
    UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10+40, SCREEN_W-2*kMargin,descriptionH)];
    description.font = font(13);
    description.numberOfLines = 0;
    _description = description;
    description.textColor = PrinkColor;
    description.text = descriptionText;
    [self addSubview:description];
    
    //价格标签
    CGFloat wid = (SCREEN_W-20-40)/5;
    
    for (int i=0; i<_textArr.count; i++) {
        
        UIButton *lab = [[UIButton alloc]initWithFrame:CGRectMake(10+i%5*(wid+10), 10+40+descriptionH+10+i/5*35, wid, 25)];
        
        lab.titleLabel.textAlignment= NSTextAlignmentCenter;
        lab.titleLabel.adjustsFontSizeToFitWidth = YES;
        lab.tag = i;
        [lab setTitleColor:[UIColor blackColor] forState:0];
        [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        lab.layer.cornerRadius = 5;
        SPDepositModel *bailM = _textArr[i];
        lab.titleLabel.font = font(14);
        [lab setTitle:[NSString stringWithFormat:@"%@元",bailM.bailFee] forState:0];
        lab.backgroundColor = HomeBaseColor;
        [lab addTarget:self action:@selector(choseDeposit:) forControlEvents:UIControlEventTouchDown];
        lab.clipsToBounds  = YES;
//        lab.titleLabel.font = font(13);
//        if ([_textArr[i][@"bailFee"] isEqualToString:@"0"]) {
//            [lab setTitleColor:[UIColor grayColor] forState:0];
//        }
        [self addSubview:lab];
        //选中后台返回的默认选中
        if (bailM.selected) {
            [self choseDeposit:lab];
        }
    }
    
    CGFloat depositH = (_textArr.count/5+1)*(25+10);
    
    UIButton *delegateTip = [[UIButton alloc]init];
    delegateTip.titleLabel.font = font(13);
    [delegateTip setTitle:@"发布需求成功，即为同意《小猪约服务协议》" forState:0];
    delegateTip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [delegateTip setTitleColor:PrinkColor forState:0];
    [delegateTip addTarget:self action:@selector(checkDelegate) forControlEvents:UIControlEventTouchDown];
    [self addSubview:delegateTip];
   
    [delegateTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.width.offset(SCREEN_W);
        make.bottom.offset(0);
        make.left.offset(10);
    }];
    
     self.totalH = 10+40+descriptionH+depositH+40;
}


//选择了保证金

-(void)choseDeposit:(UIButton *)btn{
    
    //更改选中的按钮
    [self changeSelectedBtn:btn];
    
    SPDepositModel *bailM = _textArr[btn.tag];
    
    //更改提示语
    _description.text = [NSString stringWithFormat:@"%@\n\n%@",bailM.prompt,bailM.note];
    NSRange range =NSMakeRange(0,bailM.prompt.length);
    [_description setAttributeTextWithString:_description.text range:range WithColour:[UIColor grayColor]];
    
    //判断保证金 够不够
    [self ifBailEnoughWithModel:bailM];
    
}

//判断保证金 够不够
-(void)ifBailEnoughWithModel:(SPDepositModel *)bailM{
    
    //判断保证金 够不够
    if (_totalFeeStr < [bailM.bailFee doubleValue])
    {
        !self.block?:self.block(@"金额不够",@"");
    }
    else
    {
        !self.block?:self.block(@"保证金ID",bailM.bailId);
    }
}

-(void)changeSelectedBtn:(UIButton *)btn{
    _selectedDepositButton.selected = NO;
    [_selectedDepositButton setBackgroundColor:HomeBaseColor];
    _selectedDepositButton.selected = NO;
    
    [btn setBackgroundColor:[UIColor redColor]];
    btn.selected = YES;
    _selectedDepositButton = btn;
    
}

-(void)checkDelegate{
    !self.block?:self.block(@"协议",@"");
}
@end

