#import "ArcLineView.h"



#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角都转弧度

#define ANGLE 20 //没份20度 共220度

@implementation ArcLineView


- (void)drawRect:(CGRect)rect {
    
    
    
   
        //设置圆弧的半径
    
        CGFloat radius =  rect.size.width/2;
    
        //设置圆弧的圆心
    
        CGPoint center = CGPointMake(radius, radius);
    
        //背景线条
    
        CGFloat startAngleBag = DEGREES_TO_RADIANS(165);
    
        CGFloat endAngleBag = DEGREES_TO_RADIANS(165) + DEGREES_TO_RADIANS(210);
    
        UIBezierPath *pathBag = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 5 startAngle:startAngleBag endAngle:endAngleBag clockwise:YES];
    
        pathBag.lineWidth = 4;
    
        pathBag.lineCapStyle = kCGLineJoinRound;
    
        [grayF2F2F2 set];
    
        [pathBag stroke];
    
        
        //显示的进度条
    
        CGFloat startAngle = DEGREES_TO_RADIANS(165);
    
        CGFloat endAngle = DEGREES_TO_RADIANS(165) + DEGREES_TO_RADIANS(210)*_starScore;
    
        if (_starScore >= 0.6) {
        
                endAngle = DEGREES_TO_RADIANS(165) + DEGREES_TO_RADIANS(210)*(_starScore)                                                                                        ;
        
            } else {
            
                    endAngle = DEGREES_TO_RADIANS(165) + DEGREES_TO_RADIANS(210)*(_starScore);
            
                }
    
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius - 5 startAngle:startAngle endAngle:endAngle clockwise:YES];
    
        path.lineWidth = 4;
    
        path.lineCapStyle = kCGLineJoinRound;
    
        [KMainColor set];
    
        [path stroke];
    
        
    
        //创建文字说明
    
        if (YES) {
        
                
        
                self.scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,10, 76,25)];
        self.scoreLabel.adjustsFontSizeToFitWidth = YES;
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        self.scoreLabel.numberOfLines = 2;
                self.scoreLabel.font = [UIFont systemFontOfSize:10];
        
           self.scoreLabel.text = [NSString stringWithFormat:@"%.0f%%\n已领", _starScore*100];
        
                self.scoreLabel.textColor = [UIColor hexColor:@"AEAEAE"];
        
                [self addSubview:self.scoreLabel];
        
               
        
            }
    
}



//起始分值

- (void)setStarScore:(CGFloat)starScore {
    
        _starScore = starScore;
    
        self.scoreLabel.text = [NSString stringWithFormat:@"%.0f", starScore*100];
    
        //当下载进度改变时，手动调用重绘方法
    
        [self setNeedsDisplay];
    
}




//创建文字说明 label

- (void)creatLabel:(NSString *)title withScore:(CGFloat)index{
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 23, 15)];
    
        label.font = [UIFont systemFontOfSize:10];
    
        label.textAlignment = NSTextAlignmentCenter;
    
        label.text = title;
    
        label.textColor = [UIColor clearColor];
    
        [self addSubview:label];
    
        CGFloat endAngle = index*ANGLE-200+10;
    
        label.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(endAngle)+M_PI_2);//label 旋转
    
    
    
        CGSize size = self.frame.size;
    
        CGFloat  centerY = size.width/2 - (size.width/2-20)*sin(DEGREES_TO_RADIANS(index*ANGLE-10));
    
        CGFloat centerX = size.width/2 - (size.width/2-20)*cos(DEGREES_TO_RADIANS(index*ANGLE-10));
    
        label.center = CGPointMake(centerX, centerY);
    
        
    
    
}
@end
