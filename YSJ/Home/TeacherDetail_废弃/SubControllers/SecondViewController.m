//
//  SecondViewController.m
//  HVScrollView
//
//  Created by Libo on 17/6/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "SecondViewController.h"
#import "MFCourseCell.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // ----------- 分页菜单SPPageMenu的框架github地址:https://github.com/SPStore/SPPageMenu ---------
    // ----------- 本demo地址:https://github.com/SPStore/HVScrollView ----------
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classroomArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MFCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:courseCellID];
    if (cell == nil) {
        cell = [[MFCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellID];
    }
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 58;
}
@end
