//
//  SXSearchHeadView.m
//  TabViewCell
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 付耀辉. All rights reserved.

#import "SXSearchHeadView.h"
#import "common.h"
#import "SXShowConditionCell.h"
#define KHeight 60
#define Kwidth  90
#define KSpace  5

@interface SXSearchHeadView ()<UITableViewDelegate,UITableViewDataSource>

//全局对象
@property (nonatomic,strong) SXSearchHeadView *headView;

//存放种类的数组
//诗的类型
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,assign) BOOL isDataing;

//诗的朝代
@property (nonatomic,strong) NSArray *dynastyArr;
@property (nonatomic,assign) BOOL isDybasting;

//诗的形式
@property (nonatomic,strong) NSArray *formArr;
@property (nonatomic,assign) BOOL isForming;

//当前button的tag值
@property (nonatomic,assign) NSInteger currentTag;

@end

@implementation SXSearchHeadView

static NSString *identify=@"cell";


-(UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth,ScreenHeight-108-40) style:(UITableViewStylePlain)];
        
        _searchTableView.delegate=self;
        _searchTableView.dataSource=self;
        _searchTableView.backgroundColor=RGB(34, 22, 34);
        
        _searchTableView.rowHeight=44;
        
        UIImageView *image=[[UIImageView alloc]init];
        image.image=[UIImage imageNamed:@"zhiye.jpg"];
        //image.alpha=.5;
        
        CALayer *layerr=[[CALayer alloc] init];
        layerr.frame=_searchTableView.bounds;
        layerr.backgroundColor=[UIColor blackColor].CGColor;
        layerr.opacity=.5;
        
        [image.layer addSublayer:layerr];
        
        [_searchTableView setBackgroundView:image];
        
        //注册cell
        [_searchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXShowConditionCell class]) bundle:nil] forCellReuseIdentifier:identify];
    }
    return _searchTableView;
}


#warning - 适配的是414*736（6P、7P）的屏幕,有需要可以自己改。

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray *)DataSource{
    
    if (self=[super initWithFrame:frame]) {
        
        //        数据源
        _dataArr=DataSource[0];
        _dynastyArr=DataSource[1];
        _formArr=DataSource[2];
        
        //self的背景颜色
        self.backgroundColor=RGB(140, 150, 150);

        //让view上的子视图适应view不让其超过主视图的frame
        self.clipsToBounds=YES;
        
        //初始化button
        _dataButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _dynastyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _formButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        
        
        CGFloat width = (ScreenWidth-11-11)/3;
        //范围
        _dataButton.frame=CGRectMake(0, 0, width, 40);
        _dynastyButton.frame=CGRectMake(width+11, 0, width, 40);
        _formButton.frame=CGRectMake((width+11)*2, 0, width, 40);
        
        //设置tag值
        _dataButton.tag=100;
        _dynastyButton.tag=101;
        _formButton.tag=102;
        
//        中间的小竖线
        UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(width, 11, 2, 20)];
        view1.backgroundColor=[UIColor whiteColor];
        [self addSubview:view1];
        
        UIView *view2=[[UIView alloc] initWithFrame:CGRectMake((width+11)*2, 11, 2, 20)];
        view2.backgroundColor=[UIColor whiteColor];
        [self addSubview:view2];
        
        //选中时title的颜色
        [_dataButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [_formButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        [_dynastyButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
        
        //刚进入程序时 默认title为数组中的第一个对象
        [_dataButton setTitle:self.dataArr[0] forState:(UIControlStateNormal)];
        [_dynastyButton setTitle:self.dynastyArr[0] forState:(UIControlStateNormal)];
        [_formButton setTitle:self.formArr[0] forState:(UIControlStateNormal)];
        
        //设置button的image
        [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        [_dynastyButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        [_formButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        
//        根据屏幕大小改一下图片与文字的间距
        if (ScreenWidth<414) {
        //设置image的内间距    布局
        [_dataButton setImageEdgeInsets:UIEdgeInsetsMake(0, 92, 0, 0)];
        [_dynastyButton setImageEdgeInsets:UIEdgeInsetsMake(0, 92, 0, 0)];
        [_formButton setImageEdgeInsets:UIEdgeInsetsMake(0, 92, 0, 0)];
        
        //设置title的内间距    布局
        [_dataButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 17)];
        [_dynastyButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 17)];
        [_formButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 17)];
        
        }else{
            
            //设置image的内间距    布局
            [_dataButton setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
            [_dynastyButton setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
            [_formButton setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
            
            //设置title的内间距    布局
            [_dataButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [_dynastyButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [_formButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            
            _dataButton.titleLabel.font=[UIFont systemFontOfSize:21];
            _dynastyButton.titleLabel.font=[UIFont systemFontOfSize:21];
            _formButton.titleLabel.font=[UIFont systemFontOfSize:21];
            
        }
            
        //button的点击事件
        [_dataButton addTarget:self action:@selector(beginToSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_dynastyButton addTarget:self action:@selector(beginToSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_formButton addTarget:self action:@selector(beginToSearch:) forControlEvents:UIControlEventTouchUpInside];
                
        //添加到View上
        [self addSubview:_dataButton];
        [self addSubview:_dynastyButton];
        [self addSubview:_formButton];
        [self addSubview:self.searchTableView];


    }
    return self;
}

-(void)changeFrameOfButton:(UIButton *)sender{
    
    if (ScreenWidth<414) {
    
        if (sender.titleLabel.text.length==3) {
        
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 105, 0, 0)];
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        
        }else if (sender.titleLabel.text.length==2){
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 93, 0, 0)];
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 18)];
        
        }else{
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 84, 0, 0)];
            
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            
        }
    
    }else{
        
        if (sender.titleLabel.text.length==3) {
            
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 103, 0, 0)];
            
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 13)];
            
        }else if(sender.titleLabel.text.length==2){
            
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 85, 0, 0)];
            
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            
        }else{
            
            [sender setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
            
            //设置title的内间距    布局
            [sender setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
            
        }
    }
}

//开始选择
-(void)beginToSearch:(UIButton *)sender{
    
//    因为有的三个字有的两个字，要调整一下内间距，有一个根据字体大小获得文本长度的方法，有兴趣的可以找一下，我比较懒
    
    [self changeFrameOfButton:sender];
    _currentTag=sender.tag;
    
    //如果两次点击是同一次button
    if (_selectIndex==sender.tag) {
        _selectIndex=0;
        
        //并且这个tableView‘是打开状态的
        if (_isForming||_isDybasting||_isDataing) {
            //封装方法，让其关闭
            [self restorationForButtonImageView];
            
        }else{
            //如果不是开启状态，打开tableView并显示你所点击的button对应的内容
            [self change:sender.tag];
        }
        
    }else{
        //如果两次点击的不是同一个button，打开tableView并显示你所点击的button对应的内容
        [self change:sender.tag];
        
    }
    //最后，将你所点击的button的下标block传给控制器
    if (_titleBlock) {
        _titleBlock(self.selectIndex);
    }
    //点击之后刷新tableView 以刷新button对应的内容
    [self.searchTableView reloadData];
    
    
//    [self.searchTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
}

//如果两次点击的不是同一个Button或者点击的是同一个button‘ 但是两次点击的时候tableView都处于关闭状态的时候------调用此方法 。
//有点难讲，这个状态比较少触发，可以打个断点多玩玩
-(void)change:(NSInteger)num{
    
    //既然是要打开，点击的button的下标赋给_selectIndex 以便后面block传给控制器
    _selectIndex=num;
    
    //根据点击不同的button，将其设置为选中状态，打开状态开启，图片旋转，其他的都取消掉
    if (num==100) {
        
        [UIView animateWithDuration:.25 animations:^{
            
            _dataButton.selected=YES;
            _dynastyButton.selected=NO;
            _formButton.selected=NO;
            
//            点击到的按钮图片旋转，其他的都返回原样
            _dataButton.imageView.transform=CGAffineTransformMakeRotation(M_PI);
            _dynastyButton.imageView.transform=CGAffineTransformIdentity;
            _formButton.imageView.transform=CGAffineTransformIdentity;
            
            //设置button的image
            [_dataButton setImage:[UIImage imageNamed:@"upblack"] forState:(UIControlStateNormal)];
            [_dynastyButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            [_formButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            
        }];
        
        _isDataing=YES;
        _isForming=NO;
        _isDybasting=NO;
        
    }else if (_currentTag==101){
        
        [UIView animateWithDuration:.25 animations:^{
            _dynastyButton.selected=YES;
            _dataButton.selected=NO;
            _formButton.selected=NO;
            
            _dataButton.imageView.transform=CGAffineTransformIdentity;
            _dynastyButton.imageView.transform=CGAffineTransformMakeRotation(M_PI);
            _formButton.imageView.transform=CGAffineTransformIdentity;
            
            //设置button的image
            [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            [_dynastyButton setImage:[UIImage imageNamed:@"upblack"] forState:(UIControlStateNormal)];
            [_formButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            
        }];
        
        _isDataing=NO;
        _isForming=NO;
        _isDybasting=YES;
        
    }else if (_currentTag==102){
        
        [UIView animateWithDuration:.25 animations:^{
            
            _dynastyButton.imageView.transform=CGAffineTransformIdentity;
            _formButton.imageView.transform=CGAffineTransformMakeRotation(M_PI);
            
            _dataButton.imageView.transform=CGAffineTransformIdentity;
            
            _formButton.selected=YES;
            _dynastyButton.selected=NO;
            _dataButton.selected=NO;
        
            //设置button的image
            [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            [_dynastyButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
            [_formButton setImage:[UIImage imageNamed:@"upblack"] forState:(UIControlStateNormal)];
            
        }];
        
        _isDataing=NO;
        _isForming=YES;
        _isDybasting=NO;
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //1.根据分区获取该分区对应的数组
    
    if (_currentTag==100) {
        return self.dataArr.count;
    }else if (_currentTag==101){
        return self.dynastyArr.count;
    }
    return self.formArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SXShowConditionCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
//    看看是否需要显示后面的选中标记
    BOOL isSame = NO;
    
    //根据点击不同的button将不同的数据array中的string置为其标题
    NSString *name;
    
    
    if (_currentTag==100) {
        
//        在赋值的过程中，因为选择过的内容会显示在顶部的按钮上，如果数组里面的字符和按钮相同，就证明那个是上次选择的对象，加个标记
        if ([self.dataArr[indexPath.row] isEqualToString:_dataButton.titleLabel.text]) {
            isSame = YES;
        }
        
        name = self.dataArr[indexPath.row];
    }else if (_currentTag==101){
        if ([self.dynastyArr[indexPath.row] isEqualToString:_dynastyButton.titleLabel.text]) {
            isSame = YES;
        }
        name = self.dynastyArr[indexPath.row];
    }else if (_currentTag==102){
        
        if ([self.formArr[indexPath.row] isEqualToString:_formButton.titleLabel.text]) {
            isSame = YES;
        }
        name = self.formArr[indexPath.row];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
//    isSame取反的原因可以去cell类里面看一眼
    [cell setName:name andIsSelected:!isSame];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //与点击button原理一样
    if (_currentTag==100) {
        if ([_dataButton.titleLabel.text isEqualToString:self.dataArr[indexPath.row]]) {
            
        }else{
            
            [_dataButton setTitle:self.dataArr[indexPath.row] forState:UIControlStateNormal];
            
        }
    }else if (_currentTag==101){
        
        [_dynastyButton setTitle:self.dynastyArr[indexPath.row] forState:UIControlStateNormal];
    [self changeFrameOfButton:_dynastyButton];
        
    }else if (_currentTag==102){
        
        [_formButton setTitle:self.formArr[indexPath.row] forState:UIControlStateNormal];
        [self changeFrameOfButton:_formButton];
    }
    
//    选择完毕，恢复状态
    [self restorationForButtonImageView];
    
    //每当点击cell 说明类型变换了，告诉控制器，需要重新根据标题更新新数据了。
    if (_selectBlock) {
        _selectBlock(@"点击了");
    }
    
    [self.searchTableView reloadData];
}

//    当点击了任何一个cell，就说明选择过了，除了按钮的标题要变，其他的都恢复初始状态
-(void)restorationForButtonImageView{
    
    [UIView animateWithDuration:.25 animations:^{
        _dataButton.imageView.transform=CGAffineTransformIdentity;
        _dynastyButton.imageView.transform=CGAffineTransformIdentity;
        _formButton.imageView.transform=CGAffineTransformIdentity;
        
        _isDataing=NO;
        _isForming=NO;
        _isDybasting=NO;
        
        _dataButton.selected=NO;
        _dynastyButton.selected=NO;
        _formButton.selected=NO;
        
        [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        [_dynastyButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        [_formButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        
    }];
}

@end
