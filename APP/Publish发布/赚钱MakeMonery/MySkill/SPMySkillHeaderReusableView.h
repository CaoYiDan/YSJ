#import <UIKit/UIKit.h>

static NSString *SPMySkillHeaderReusableViewID = @"SPMySkillHeaderReusableViewID";

@interface SPMySkillHeaderReusableView: UICollectionReusableView
/**<##>*/
@property(nonatomic,copy)NSString*name;

-(void)setTextFont:(NSInteger)font;
@end

