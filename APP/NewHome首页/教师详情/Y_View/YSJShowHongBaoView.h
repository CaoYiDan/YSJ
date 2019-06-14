//
//  YSJTeacherInfoView.h

#import "SPBasePopView.h"

typedef void(^HBUseBlock2)(NSInteger indexRow);

@class YSJTeacherModel,YSJCourseModel;

@interface YSJShowHongBaoView : SPBasePopView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) UIView *header;

@property (nonatomic,strong) YSJTeacherModel *model;

@property (nonatomic,copy) HBUseBlock2 block;

@property (nonatomic,strong) NSMutableArray *hbArr;
@end
