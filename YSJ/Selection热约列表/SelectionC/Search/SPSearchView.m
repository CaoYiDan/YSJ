//
//  SPSearchView.m
//  SmallPig
//
//  Created by 融合互联-------lisen on 17/8/28.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "SPSearchView.h"
#import "SPMySearchBar.h"
@implementation SPSearchView
{
    SPMySearchBar *_searchBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sUI];
    }
    return self;
}

-(void)sUI{
    
    _searchBar = [[SPMySearchBar alloc]initWithFrame:CGRectMake(0, 0, self.frameWidth-80, 40)];
    [self addSubview:_searchBar];
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frameWidth-80, 0, 80, 40)];
    [searchBtn setTitle:@"搜索" forState:0];
    searchBtn.titleLabel.font = font(14);
    [searchBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchDown];
    [self addSubview:searchBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, self.frameHeight-1.2, SCREEN_W-10, 1.2)];
    line.backgroundColor = BASEGRAYCOLOR;
    [self addSubview:line];
}

-(void)searchClick{
    !self.searchViewBlock?:self.searchViewBlock(_searchBar.text);
}

-(void)textFieldBecomeFirstResponse{
    [_searchBar becomeFirstResponder];
}

-(void)setSearchText:(NSString *)searchText{
    _searchBar.text = searchText;
}
@end
