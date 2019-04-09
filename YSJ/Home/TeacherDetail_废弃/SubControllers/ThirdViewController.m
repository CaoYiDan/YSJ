//
//  ThirdViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//  第三个子控制器

#import "ThirdViewController.h"
#import "MFTeacherCell.h"
@interface ThirdViewController () 
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // ----------- 分页菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
    // ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classroomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MFTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:teacherCellID];
    if (cell == nil) {
        cell = [[MFTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:teacherCellID];
    }
    [cell setModel:self.classroomArr[indexPath.row]];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
@end
