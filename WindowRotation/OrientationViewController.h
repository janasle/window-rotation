#import <UIKit/UIKit.h>

@interface OrientationViewController : UIViewController

- (BOOL)pushViewController:(UIViewController *)vc animated:(BOOL)animated;
- (void)popViewController:(UIViewController *)vc animated:(BOOL)animated;

@end
