//
//  GTBHomeVC.m
//  GuideTestBao

#import "HttpRequest.h"
#import "GTBProfileVC.h"
#import "CMInputView.h"
#import "YSJUserModel.h"
#import "BDImagePicker.h"

@interface GTBProfileVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *valueArr;
@property(nonatomic,strong)UIImageView *iconImg;
@property (nonatomic,strong) UIView *genderView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;

@end

@implementation GTBProfileVC
{
    CGFloat cellHeight;

    NSInteger _genderIndex;
    
    
}
-(NSString *)getNotNullWith:(NSString *)value{
  return  isEmptyString(value)?@"":value;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"个人信息";
 
    [self setData];
    
    cellHeight = 60;

    [self setTableView];
}

-(void)setData{
    self.dataArr =
    @[ @[@{@"img":@"",@"text":@"头像",@"pushVC":@""},@{@"img":@"",@"text":@"昵称",@"pushVC":@"",@"key":@"nickname",@"value":[self getNotNullWith:self.model.nickname]},@{@"img":@"",@"text":@"性别",@"pushVC":@"",@"key":@"sex",@"value":[self getNotNullWith:self.model.sex]},@{@"img":@"",@"text":@"生日",@"pushVC":@"",@"key":@"birth",@"value":[self getNotNullWith:self.model.birth]}],
       @[@{@"img":@"",@"text":@"职业",@"pushVC":@"",@"key":@"job",@"value":[self getNotNullWith:self.model.job]},@{@"img":@"",@"text":@"工作单位/学校",@"pushVC":@"",@"key":@"company_school",@"value":[self getNotNullWith:self.model.company_school]},@{@"img":@"",@"text":@"技能",@"pushVC":@"",@"key":@"skills",@"value":[self getNotNullWith:self.model.skills]}],
       @[@{@"img":@"",@"text":@"常住地",@"pushVC":@"",@"key":@"permanent",@"value":[self getNotNullWith:self.model.permanent]},@{@"img":@"",@"text":@"个人介绍",@"pushVC":@"",@"key":@"describe",@"value":[self getNotNullWith:self.model.describe]}]];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//MARK:- tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataArr[section];
    
    return arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [self getNormalCell:tableView];
    
    NSArray *arr = self.dataArr[indexPath.section];
    
    cell.textLabel.text = arr[indexPath.row][@"text"];
    
    if (indexPath.section==0 && indexPath.row==0){
        //头像
        
        [self setIconCell:cell];
        
    }else{
        
        cell.detailTextLabel.text =arr[indexPath.row][@"value"];
        
    }
        
    return cell;
}

-(void)setIconCell:(UITableViewCell *)cell{
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kWindowW-80, 10, 40, 40)];
    self.iconImg = img;
    img.backgroundColor= KMainColor;
    img.contentMode = UIViewContentModeScaleAspectFill;
    img.layer.cornerRadius = 20;
    img.clipsToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YUrlBase_YSJ,self.model.photo]] placeholderImage:[UIImage imageNamed:@"img2"]];
    [cell.contentView addSubview:img];
}

-(UITableViewCell *)getNormalCell:(UITableView*)tableView{
    
    NSString *normalID = @"normalID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalID];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:normalID];
        
        cell.textLabel.font = Font(14);
        cell.detailTextLabel.font = Font(13);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor hexColor:@"333333"];
        cell.detailTextLabel.textColor = [UIColor hexColor:@"9B9B9B"];
        [self setBottomLineForCell:cell];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)setBottomLineForCell:(UITableViewCell*)cell{
    UIView *line  = [[UIView alloc]initWithFrame:CGRectMake(15, cellHeight-1, kWindowW-2*15+5, 1)];
    line.backgroundColor = grayF2F2F2;
    [cell addSubview:line];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndexPath = indexPath;
    
    NSArray *arr = self.dataArr[indexPath.section];
    
    if (indexPath.row==0 && indexPath.section==0)
    {
        [self changeIconImg];
        
    }else{
        
        [self creatAlertController_alertWithTitle:arr[indexPath.row][@"text"]];
    }
}

#pragma mark - 弹框修改
-(void)creatAlertController_alertWithTitle:(NSString *)title{
    //跟上面的流程差不多，记得要把preferredStyle换成UIAlertControllerStyleAlert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:[NSString stringWithFormat:@"请输入%@",title] preferredStyle:UIAlertControllerStyleAlert];
    
    //可以给alertview中添加一个输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"";
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray *arr = self.dataArr[self.selectedIndexPath.section];
        
        NSMutableDictionary *dic = (NSMutableDictionary *)arr[self.selectedIndexPath.row];

       [self changeValue:alert.textFields.lastObject.text forKey:dic[@"key"] ];
      
      
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 更换头像
- (void)changeIconImg{
    
    __weak typeof(self) weakSelf = self;
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            
           weakSelf.iconImg.image = image;
            [weakSelf upDateHeadIcon:image];
        }
        
    }];
}
- (NSString *)generateTradeNO
{
    //AVPayViewController
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
#pragma  mark 上传图片
- (void)upDateHeadIcon:(UIImage *)photo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
         
         @"text/html",
         
         @"image/jpeg",
         
         @"image/png",
         
         @"application/octet-stream",
         
         @"text/json",
         
         nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    NSString *path = [NSString stringWithFormat:@"%@%@",[StorageUtil getTel],@"e433"];
    NSData * imageData = UIImageJPEGRepresentation(photo,0.5);
    NSString * fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:path];
    [imageData writeToFile:fullPath atomically:NO];
    
    NSMutableDictionary * dictT = [[NSMutableDictionary alloc]init];
    [dictT setObject:imageData forKey:@"photo"];
    [dictT setObject:[StorageUtil getId] forKey:@"token"];
    [manager POST:YPhoto parameters:dictT constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData  appendPartWithFileData:imageData name:@"image" fileName:[NSString stringWithFormat:@"%@.jpg",path] mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"%@",responseObject);
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[result2 stringChangeToDictionary];
        
         NSLog(@"%@",dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 性别选择
//推出性别选择器
-(void)presentGenderView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.genderView.originY = kWindowH-60-SafeAreaTopHeight;
    }];
}

//隐藏性别选择器
-(void)dismissGenderView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.genderView.originY = kWindowH;
    }];
}

-(UIView *)genderView{
    if (!_genderView) {
        _genderView = [[UIView alloc]initWithFrame:CGRectMake(0, kWindowH, kWindowW, 45)];
        _genderView.backgroundColor = KMainColor;
        [self.view addSubview:_genderView];
        int i=0;
        for (NSString *str in @[@"男",@"女"]) {
            UIButton *btn = [FactoryUI createButtonWithtitle:str titleColor:KWhiteColor imageName:nil backgroundImageName:nil target:self selector:@selector(genderClick:)];
            btn.tag = i;
            btn.frame = CGRectMake(i*kWindowW/2, 0, kWindowW/2, 45);
            [_genderView addSubview:btn];
            
            i++;
        }
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = KWhiteColor;
        [_genderView addSubview:bottomLine];
        [bottomLine makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kWindowW/2);
            make.top.offset(0);
            make.width.offset(1);
            make.bottom.offset(0);
        }];
    }
    return _genderView;
}

-(void)genderClick:(UIButton *)btn{
    
    [self changeValue:btn.titleLabel.text forKey:@"sex"];
    self.model.sex = btn.titleLabel.text;
    [self.tableView reloadData];
    [self dismissGenderView];
}

-(void)changeValue:(NSString *)value forKey:(NSString *)key{
    
    if (isEmptyString(value)) {
        return;
    }
    NSMutableDictionary *dic = @{}.mutableCopy;
    
    [dic setObject:value forKey:key];
    [dic setObject:[StorageUtil getId] forKey:@"token"];
   
    
    [[HttpRequest sharedClient]httpRequestPOST:YInfoSet parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
        [self getData];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - others
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)setModel:(GTBProfileModel *)model{
    _model = model;
    [self.tableView reloadData];
}

-(void)setTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH-KBottomHeight-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.contentInset = UIEdgeInsetsMake(-30,0,0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = grayF2F2F2;
    self.tableView.showsVerticalScrollIndicator=NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = cellHeight;
    [self.view addSubview:self.tableView];
}

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    [dic setObject:User_Normal forKey:@"type"];
    [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        
        self.model = [YSJUserModel mj_objectWithKeyValues:responseObject];
        
        [self setData];
        
        [self.tableView reloadData];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
@end
