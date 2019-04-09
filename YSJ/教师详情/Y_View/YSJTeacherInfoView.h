//
//  YSJTeacherInfoView.h

#import "SPBasePopView.h"
@class YSJTeacherModel;
@interface YSJTeacherInfoView : SPBasePopView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) YSJTeacherModel *model;

@end
