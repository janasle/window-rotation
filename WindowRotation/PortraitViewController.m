#import "PortraitViewController.h"

#import "AppWindow.h"

@interface PortraitViewController ()
@property (nonatomic) AppWindow *window;
@property (nonatomic) UIViewController *controller;
@end

@implementation PortraitViewController

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        self.window = [[AppWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor clearColor];
        self.window.windowLevel = UIWindowLevelStatusBar;
        self.window.rootViewController = self;
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSUInteger)supportedInterfaceOrientations {
    NSLog(@"%s %@", __FUNCTION__, self);
    if (self.controller) {
        return [self.controller supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)pushViewController:(UIViewController *)vc animated:(BOOL)animated {
    self.window.hidden = NO;
    self.controller = vc;
    
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    [vc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:nil views:@{@"v": vc.view}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:@{@"v": vc.view}]];
    
    if (animated) {
        self.view.alpha = 0;
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.view.alpha = 1;
                         } completion:nil];
    } else {
        self.view.alpha = 1;
    }
    
    return YES;
}

- (void)popViewController:(UIViewController *)vc animated:(BOOL)animated {
    if (self.controller != vc) {
        return;
    }
    
    void (^completionBlock)(BOOL) = ^(BOOL finished) {
        self.window.hidden = YES;
        self.view.alpha = 1;
        
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
        self.controller = nil;
    };
    
    if (animated) {
        self.window.hidden = NO;
        self.view.alpha = 1;
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.view.alpha = 0;
                         } completion:completionBlock];
    } else {
        completionBlock(YES);
    }
    
}

@end
