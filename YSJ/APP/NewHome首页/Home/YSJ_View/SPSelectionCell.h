//
//  SPSelectionCell.h

#import <UIKit/UIKit.h>

@interface SPSelectionCell : UITableViewCell 
/**<##>数据数组*/
@property (nonatomic, strong)NSArray *listArr;
//cellType
@property (nonatomic,assign) YSJHomeCellType cellType;
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath andCellType:(YSJHomeCellType)ceType;
@end
