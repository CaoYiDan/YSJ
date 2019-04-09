//
//  LGEvaluateCell.m
//  LetsGo
//
//  Created by 融合互联-------lisen on 17/4/21.
//  Copyright © 2017年 XJS_oxpc. All rights reserved.
//

#import "SPProfileCommentCell.h"
#import "LGIconView.h"
#import "StarView.h"
#import "SPCommentModel.h"
#import "SPProfileCommentFrame.h"

@interface SPProfileCommentCell ()

/** 上部分View */
@property (nonatomic, weak) UIView *topView;
/** 中间View */
@property (nonatomic, weak) UIView *middleView;
/** 头像 */
@property (nonatomic, weak) LGIconView *iconView;

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间*/
@property (nonatomic, weak) UILabel *timeLabel;
/** 评分 */

/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 评分view */
@property (nonatomic, strong) UIView *starView;
/** 回复按钮 */
@property (nonatomic, strong) UIButton *answerBtn;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *praisedBtn;
/** 工具条 */
@property (nonatomic, strong) UIView *toolbar;
@end

@implementation SPProfileCommentCell
{
    StarView *_attitudeStart;
    StarView *_skillStart;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    SPProfileCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SPProfileCommentCellID];
    if (!cell) {
        cell = [[SPProfileCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SPProfileCommentCellID];
    }
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创UI
        [self setupOriginal];
        
    }
    return self;
}

/**
 * 初始化
 */
- (void)setupOriginal
{
    /** topView */
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    /** 头像 */
    LGIconView *iconView = [[LGIconView alloc] init];
    iconView.layer.cornerRadius = 20;
    iconView.clipsToBounds = YES;
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.backgroundColor = HomeBaseColor;
    [topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor whiteColor];
    nameLabel.font = HWStatusCellNameFont;
    [topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = Font(12);
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    
    /** 中间View*/
    UIView *middleView = [[UIView alloc]init];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:middleView];
    self.middleView = middleView;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = HWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor whiteColor];
    [middleView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    /** 技能评分 和态度评分*/
    [self.contentView addSubview:self.starView];
   
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = BASEGRAYCOLOR;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(SCREEN_W, 1));
        make.left.offset(0);
    }];
}

-(UIView*)toolbar{
    if (!_toolbar) {
        _toolbar = [[UIView alloc]init];
        _toolbar.backgroundColor = [UIColor whiteColor];
        
        UIButton *answerbtn = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-50, 4, 40, 25)];
        [answerbtn setImage:[UIImage imageNamed:@"d_message"] forState:0];
        [answerbtn addTarget:self action:@selector(answerClick) forControlEvents:UIControlEventTouchDown];
        [answerbtn setTitleColor:[UIColor blackColor] forState:0];
        answerbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        self.answerBtn = answerbtn;
        answerbtn.userInteractionEnabled = NO;
        [_toolbar addSubview:answerbtn];
        
        UIButton *praisedbtn = [[UIButton alloc] initWithFrame:CGRectMake(kWindowW-100, 4, 40, 25)];
        [praisedbtn setImage:[UIImage imageNamed:@"xxwdz"] forState:0];
        [praisedbtn setImage:[UIImage imageNamed:@"xxdz"] forState:UIControlStateSelected];
        [praisedbtn setTitleColor:[UIColor blackColor] forState:0];
        [praisedbtn addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchDown];
        praisedbtn.titleLabel.font = [UIFont systemFontOfSize:13];
        self.praisedBtn = praisedbtn;
        [_toolbar addSubview:praisedbtn];
    }
    return _toolbar;
}

-(UIView*)starView{
    if (!_starView) {
        _starView = [[UIView alloc]init];
        _starView.backgroundColor = [UIColor whiteColor];
        //技能
        UILabel *skillStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 40, 34)];
        skillStartLabel.font = kFontNormal_14;
        skillStartLabel.text = @"技能";
        [_starView addSubview:skillStartLabel];
        
        StarView *skillStart = [[StarView alloc]initWithFrame:CGRectMake(kMargin +40, 5, 100, 24)];
        _skillStart = skillStart;
        skillStart.show_star = 20;
        skillStart.font_size = 20;
        skillStart.clipsToBounds = YES;
        [_starView addSubview:skillStart];
        
        //态度
        UILabel *attitudeStartLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargin+SCREEN_W/2, 0, 40, 34)];
        attitudeStartLabel.text = @"态度";
        attitudeStartLabel.font = kFontNormal_14;
        [_starView addSubview:attitudeStartLabel];
        
        StarView *attitudeStart = [[StarView alloc]initWithFrame:CGRectMake(kMargin +40+SCREEN_W/2, 5, 100, 24)];
        attitudeStart.clipsToBounds = YES;
        attitudeStart.show_star = 20;
        attitudeStart.font_size = 20;
        _attitudeStart = attitudeStart;
        [_starView addSubview:attitudeStart];
    }
    return _starView;
}

- (void)setStatusFrame:(SPProfileCommentFrame*)statusFrame
{
    _statusFrame = statusFrame;
    
    SPCommentModel *status = statusFrame.status;
    
    /** topView */
    self.topView.frame = statusFrame.topViewF;
    
    /** 头像 */
    NSLog(@"%@",status.commentorAvatar);
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.imgUrl = status.commentorAvatar;
    
    /** 昵称*/
    self.nameLabel.text = status.commentorName;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.time;
    
    /** 中间View*/
    self.middleView.frame = statusFrame.middleViewF;
    
    /** 正文 */
    NSString*contentText = [status.content stringByRemovingPercentEncoding];
    NSLog(@"%@",contentText);
    self.contentLabel.text =contentText;
   
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /** 评分 */
    self.starView.frame = statusFrame.toolbarF;
    //技能评分
    _skillStart.show_star = status.commentScore*20;
    //重新绘制
    [_skillStart setNeedsDisplay];
    //态度评分
    _attitudeStart.show_star = status.attitudeScore*20;
    //重新绘制
    [_attitudeStart setNeedsDisplay];

}

-(void)praiseClick:(UIButton *)btn{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:self.statusFrame.status.code forKey:@"bePraisedCode"];
    [dict setObject:[StorageUtil getCode] forKey:@"praiser"];
    [dict setObject:@"COMMENT" forKey:@"type"];
    NSString *url  = @"";
    
    if (btn.isSelected) {
        url = kUrlDeletePraise;
    }else{
        url = kUrlAddPraise;
    }
    
    [[HttpRequest sharedClient]httpRequestPOST:url parameters:dict progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        btn.selected = !btn.isSelected;
        if (btn.isSelected) {
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]+1] forState:0];
//            self.statusFrame.status.praised = YES;
//            self.statusFrame.status.praiseNum += 1;
        }else{
            [btn setTitle:[NSString stringWithFormat:@"%lu",[btn.titleLabel.text integerValue]-1] forState:0];
//            self.statusFrame.status.praised = NO;
//            self.statusFrame.status.praiseNum -= 1;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        Toast(@"O，出错啦！");
    }];
}
@end

