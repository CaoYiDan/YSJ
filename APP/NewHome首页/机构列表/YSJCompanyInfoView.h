//
//  YSJTeacherInfoView.h

#import "SPBasePopView.h"
@class YSJCompanysModel;
@interface YSJCompanyInfoView : SPBasePopView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) YSJCompanysModel *model;

@end
