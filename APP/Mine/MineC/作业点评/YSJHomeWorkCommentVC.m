#import "YSJHomeWorkVC.h"
#import "YSJHomeWorkCell.h"
#import "YSJHomeWorkTypeListCell.h"
#import "YSJHomeWorkCommentVC.h"
#import "YSJOrderCourseView.h"
#import "StarView.h"
#import "YSJOrderModel.h"
#import "YSJCommentFrameModel.h"
#import "YSJCommentCell.h"
#import "YSJHomeWorkFrameModel.h"
#import "YSJPostVideoView.h"
#import "YSJPostVideoOrImgView.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#import "ZLPhotoActionSheet.h"



@interface YSJHomeWorkCommentVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property (nonatomic,strong) LGTextView *textView;
@property (nonatomic,strong) StarView *star1;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray * titleArr;
@property (nonatomic,strong) YSJPostVideoView *photoVideoView;
@property (nonatomic,strong) YSJPostVideoOrImgView *photoView;
@property (nonatomic,strong) NSArray * sectionArr;
@property (nonatomic,strong) NSArray * subTitleArr;
@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) UIView  *footerView2;
@property (nonatomic,assign) NSInteger sectionNum;
@property (nonatomic,strong) YSJHomeWorkFrameModel *homeWorkF_teacher;
@property (nonatomic,strong) YSJHomeWorkFrameModel *homeWorkF_student;
@property (nonatomic,strong) YSJCommentFrameModel *commentModel;

@end

@implementation YSJHomeWorkCommentVC

#pragma mark life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.sectionArr  = @[];
   
    self.titleArr = @[@{@"img":@"ic_buzhi",@"name":@"布置作业"},@{@"img":@"ic_dianpin",@"name":@"点评作业"},@{@"img":@"tijiao ",@"name":@"提交作业"}];
    
    self.subTitleArr = @[@"guize",@"geren",@"kefu",@"fankui"];
    
    [self.view addSubview:self.tableView];
    
    self.homeWorkF_teacher = [[YSJHomeWorkFrameModel alloc]init];
    self.homeWorkF_teacher.status = self.orderModel;
    
    
    self.homeWorkF_student = [[YSJHomeWorkFrameModel alloc]init];
    self.homeWorkF_student.studentWorkModel = self.orderModel;
    
    self.commentModel = [[YSJCommentFrameModel alloc]init];
    self.commentModel.orderModel = self.orderModel;
    
    [self.tableView reloadData];
    
    if (self.homeWorkDetailType == HomeWorkDetailCheckMyPublish) {
        self.title = @"查看作业";
    }else if (self.homeWorkDetailType == HomeWorkDetailCheckComment) {
        self.title = @"查看点评";
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitCommit) {
        self.title = @"提交作业";
        [self setSaveButtonWithTitle:@"提交"];
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitComment) {
        self.title = @"点评作业";
        [self setSaveButtonWithTitle:@"发布"];
    }else if (self.homeWorkDetailType == HomeWorkDetailCheckCommit) {
        self.title = @"查看作业";
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self getData];
    
    [self getNum];
    
}

-(void)dealloc{
    
}

#pragma mark RequestNetWork

-(void)getData{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YInformation parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        
        NSLog(@"%@",responseObject);
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)getNum{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    [dic setObject:[StorageUtil getId] forKey:@"token"];
    
    [[HttpRequest sharedClient]httpRequestPOST:YNumber parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSDictionary * re = responseObject;
        NSMutableDictionary *numdic = re.mutableCopy;
        [numdic setObject:@(0) forKey:@"haveLook"];
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger num = 0;
    
    if (self.homeWorkDetailType == HomeWorkDetailCheckMyPublish) {
        num = 1;
    }else if (self.homeWorkDetailType == HomeWorkDetailCheckComment){
        num = 3;
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitCommit) {
        num = 1;
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitComment){
        num = 2;
    }else if (self.homeWorkDetailType == HomeWorkDetailCheckCommit) {
        num= 2;
    }
    
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section!=2) {
        
        YSJHomeWorkCell *cell = [YSJHomeWorkCell loadCode:tableView];
        cell.type = indexPath.section;
        cell.statusFrame = self.homeWorkF_teacher;
        cell.clipsToBounds =YES;
        return cell;
        
    }else{
        
         YSJCommentCell*cell = [YSJCommentCell loadCode:tableView];
        cell.type = 1;
        cell.clipsToBounds =YES;
        cell.statusFrame = self.commentModel;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 102+56;
    }else {
        return 56;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 102+56)];
        header.backgroundColor =KWhiteColor;
        
        //课程评价
        YSJOrderCourseView *view = [[YSJOrderCourseView alloc]initWithFrame:CGRectMake(0, 00, kWindowW, 102)];
        view.model = self.orderModel;
        
        UIView *bottomLine22 = [[UIView alloc]init];
        bottomLine22.backgroundColor = grayF2F2F2;
        [view addSubview:bottomLine22];
        [bottomLine22 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.width.offset(kWindowW);
            make.height.offset(1);
            make.bottom.equalTo(view).offset(0);
        }];
        [header addSubview:view];
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 102, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业题目";
        sectionTitle.textColor = KBlack333333;
        [header addSubview:sectionTitle];
        
        return header;
        
    }else if(section==1){
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业内容";
        sectionTitle.textColor = KBlack333333;
        return sectionTitle;

    }else if(section==2){
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业点评";
        sectionTitle.textColor = KBlack333333;
        return sectionTitle;
        
    }
    
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return self.homeWorkF_teacher.cellHeight;
    }else if (indexPath.section==1){
        return self.homeWorkF_student.studentCellHeight;
    } else if(indexPath.section==2){
        return self.commentModel.orderCellHeight;
    }
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    NSLog(@"%d",self.homeWorkDetailType);
    
    if ((section==1 && self.homeWorkDetailType == HomeWorkDetailWaitComment) ||(self.homeWorkDetailType == HomeWorkDetailWaitCommit && section==0)) {
        
         return 600;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ((section==1 && self.homeWorkDetailType == HomeWorkDetailWaitComment) ) {
        self.footerView.clipsToBounds = YES;
       return  self.footerView;
    }else if((self.homeWorkDetailType == HomeWorkDetailWaitCommit && section==0)){
        self.footerView2.clipsToBounds = YES;
        return  self.footerView2;
    }
    
     return [[UIView alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - LazyLoad

- (UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = grayF2F2F2;
        _tableView.backgroundColor = KWhiteColor;
        _tableView.showsVerticalScrollIndicator = NO                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
        _tableView.frame = CGRectMake(0, 0, kWindowW, kWindowH-49);
        
        _tableView.rowHeight = 81+17;
        
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark - 上传
-(void)post{
    [self photoBtnSelecoed];
}

-(void)photoBtnSelecoed{
    NSLog(@"图片");
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;picker.allowsEditing = YES;[self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
     [picker dismissViewControllerAnimated:YES completion:nil];
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
    NSLog(@"%@",videoURL);
    NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSString *url = @"";
    
  
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        
        [dic setObject:self.orderModel.orderId forKey:@"course_id"];
        [dic setObject:self.textView.text forKey:@"describe"];
        NSLog(@"%@",dic);
        
        url = Yhomeworksubmit;
    
    NSArray *_imgArr = @[];
    _imgArr = [self.photoView getPhotoImgs];
    AFHTTPSessionManager *manager = [[[YSJAFNPostImgManager alloc]init] getManager];
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@.mp4", dateString];
        
                [formData appendPartWithFileData:videoData name:@"video" fileName:fileName mimeType:@"video/mp4"];
                
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        //将二进制转为字符串
        NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        //字符串转字典
        NSDictionary*dict=[result2 stringChangeToDictionary];
        
        NSLog(@"%@",dict);
        
        if ([dict[@"status"] integerValue]==200) {
            Toast(@"发布成功");
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"publishFinish" object:nil];
            
        }else{
            Toast(@"错误格式");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
                                                                                                                                                                                                                                                                                                                                                                                 
-(void)save{
    
    NSMutableDictionary *dic = @{}.mutableCopy;
    NSString *url = @"";
    
    if (self.homeWorkDetailType == HomeWorkDetailWaitCommit) {
        
        [dic setObject:[StorageUtil getId] forKey:@"token"];
       
         [dic setObject:self.orderModel.orderId forKey:@"course_id"];
        [dic setObject:self.textView.text forKey:@"describe"];
        NSLog(@"%@",dic);
     
        url = Yhomeworksubmit;
        
        NSArray *_imgArr = @[];
        
        _imgArr = [self.photoVideoView getPhotoImgs];
        AFHTTPSessionManager *manager = [[[YSJAFNPostImgManager alloc]init] getManager];
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
            // 这里的_photoArr是你存放图片的数组
            for (int i = 0; i < _imgArr.count; i++) {
                
                NSDictionary *dic = _imgArr[i];
                
                if ([dic[@"type"] isEqualToString:@"video"]) {
                    
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString  stringWithFormat:@"%@_%d.mp4", dateString,i];
                    NSData *videoData = [NSData dataWithContentsOfURL:dic[@"url"]];
                    
                    [formData appendPartWithFileData:videoData name:@"video" fileName:fileName mimeType:@"video/mp4"];
                    
                }else{
                    //
                    UIImage *image = dic[@"obj"];
                    
                    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
                  
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                    [formatter setDateFormat:@"yyyy_MM_dd_HHmmss"];
                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString  stringWithFormat:@"%@_%d.jpg", dateString,i];
                    [formData appendPartWithFileData:imageData name:@"image" fileName:fileName mimeType:@"image/jpeg"];
                }
                
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            //将二进制转为字符串
            NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            //字符串转字典
            NSDictionary*dict=[result2 stringChangeToDictionary];
            
            NSLog(@"%@",dict);
            
            if ([dict[@"status"] integerValue]==200) {
                Toast(@"发布成功");
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
                
            }else{
                Toast(@"错误格式");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    }else if (self.homeWorkDetailType == HomeWorkDetailWaitComment){
        
        [dic setObject:[StorageUtil getId] forKey:@"token"];
        [dic setObject:@(_star1.show_star/20) forKey:@"mark_point"];
        [dic setObject:self.orderModel.orderId forKey:@"course_id"];
        [dic setObject:self.textView.text forKey:@"mark"];
        NSLog(@"%@",dic);
       
        url = Yhomeworkcommenthomework;
        
        NSArray *_imgArr = @[];
        
        _imgArr = [self.photoView getPhotoImgs];
        NSLog(@"%@",_imgArr);
        
        AFHTTPSessionManager *manager = [[[YSJAFNPostImgManager alloc]init] getManager];
        NSLog(@"%@",url);
        
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
            // 这里的_photoArr是你存放图片的数组
            for (int i = 0; i < _imgArr.count; i++) {
                
                UIImage *image = _imgArr[i];
                NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
         
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                [formatter setDateFormat:@"yyyyMMddHHmmss"];
                NSString *dateString = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString  stringWithFormat:@"%@_%d.jpg",dateString,i];
                NSLog(@"%@",fileName);
                [formData appendPartWithFileData:imageData name:fileName fileName:fileName mimeType:@"image/jpeg"]; //
              
            }
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            //将二进制转为字符串
            NSString *result2 = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
            //字符串转字典
            NSDictionary*dict=[result2 stringChangeToDictionary];
            
            NSLog(@"%@",dict);
            
            if ([dict[@"status"] integerValue]==200) {
                Toast(@"发布成功");
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:NotificationMoreBtnFinishOption object:nil];
                
            }else{
                Toast(@"错误格式");
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        return;
    }

}

-(void)postimg:(NSArray *)_imgArr dic:(NSMutableDictionary *)dic url:(NSString *)url{
    
   
}
-(void)setSaveButtonWithTitle:(NSString *)text{
    
    UIButton *connectBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, kWindowH-SafeAreaTopHeight-25-50-KBottomHeight, kWindowW-40, 50)];
    connectBtn.backgroundColor = KMainColor;
    [connectBtn setTitle:text forState:0];
    connectBtn.layer.cornerRadius = 5;
    connectBtn.clipsToBounds = YES;
    [connectBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:connectBtn];
    
}


- (UIView *)footerView{
    if (!_footerView) {
        
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 600)];
        footer.backgroundColor =KWhiteColor;
        _footerView = footer;
        
        //作业题目
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle.font = font(16);
        sectionTitle.text = @"  作业评价";
        sectionTitle.textColor = KBlack333333;
        [footer addSubview:sectionTitle];
        
        //评分
        _star1 = [[StarView alloc]initWithFrame:CGRectMake(SCREEN_W/2-80, 13, 140, 30)];
        _star1.font_size=23;
        _star1.canSelected = YES;
        [footer addSubview:_star1];
        WeakSelf;
        _star1.StarBlock = ^(NSInteger showShar) {
            NSLog(@"%ld",(long)showShar);
            if (showShar>100) {
                showShar =100;
            }
            weakSelf.index = showShar/20-1;
            
        };
        
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = grayF2F2F2;
        [footer addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.width.offset(kWindowW);
            make.height.offset(1);
            make.top.offset(55);
        }];
        
        //作业题目
        UILabel * sectionTitle2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 56, kWindowW, 56)];
        sectionTitle2.font = font(16);
        sectionTitle2.text = @"  上传点评";
        sectionTitle2.textColor = KBlack333333;
        [footer addSubview:sectionTitle2];
        
        LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56*2, SCREEN_W-2*kMargin, 100)];
        self.textView = textView;
        [footer addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.height.offset(100);
            make.width.offset(SCREEN_W-2*kMargin); make.top.equalTo(sectionTitle2.mas_bottom).offset(0);
        }];
        
        textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
        textView.textColor = black666666;
        textView.delegate = self;
        textView.font  = font(14);
        textView.placeholder = @"详细描述作业完成情况";
        [footer addSubview:textView];
        
        YSJPostVideoOrImgView *view = [[YSJPostVideoOrImgView alloc]initWithFrame:CGRectMake(0, 210, kWindowW, 300)];
        self.photoView = view;
        view.canNotSelectedVideo = YES;
        [footer addSubview:view];
        
        return footer;
    }
    return _footerView;
}


- (UIView *)footerView2{
    
    if (!_footerView2) {
        
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 600)];
        footer.backgroundColor =KWhiteColor;
        _footerView2 = footer;
        
        
        //作业题目
        UILabel * sectionTitle2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 56)];
        sectionTitle2.font = font(16);
        sectionTitle2.text = @"  上传作业";
        sectionTitle2.textColor = KBlack333333;
        [footer addSubview:sectionTitle2];
        
        LGTextView *textView=[[LGTextView alloc]initWithFrame:CGRectMake(kMargin, 56*2, SCREEN_W-2*kMargin, 100)];
        self.textView = textView;
        [footer addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kMargin);
            make.height.offset(100);
            make.width.offset(SCREEN_W-2*kMargin); make.top.equalTo(sectionTitle2.mas_bottom).offset(0);
        }];
        
        textView.placeholderColor = [UIColor hexColor:@"BBBBBB"];
        textView.textColor = black666666;
        textView.delegate = self;
        textView.font  = font(14);
        textView.placeholder = @"详细描述作业内容";
        [footer addSubview:textView];
        
        YSJPostVideoView *view = [[YSJPostVideoView alloc]initWithFrame:CGRectMake(0, 210-56, kWindowW, 300)];
        self.photoVideoView = view;
        view.canNotSelectedVideo = YES;
        [footer addSubview:view];
        
        return footer;
    }
    return _footerView2;
}

@end
