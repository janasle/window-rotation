#import <UIKit/UIKit.h>

@protocol ColoredViewControllerDelegate;

@interface ColoredViewController : UIViewController

@property (nonatomic, weak) id<ColoredViewControllerDelegate> delegate;

- (instancetype)initWithColor:(UIColor *)color supportedInterfaceOrientations:(UIInterfaceOrientationMask)mask;

@end

@protocol ColoredViewControllerDelegate <NSObject>
- (void)coloredViewControllerDidDismiss:(ColoredViewController *)coloredViewController;
@end
