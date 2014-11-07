#import <UIKit/UIKit.h>

@interface PortraitViewController : UIViewController

- (BOOL)pushViewController:(UIViewController *)vc animated:(BOOL)animated;
- (void)popViewController:(UIViewController *)vc animated:(BOOL)animated;

@end
