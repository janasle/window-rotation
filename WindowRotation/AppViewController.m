#import "AppViewController.h"

#import "ColoredViewController.h"
#import "OrientationViewController.h"
#import "PortraitViewController.h"

@interface AppViewController () <ColoredViewControllerDelegate>
@property (nonatomic) OrientationViewController *orientation;
@property (nonatomic) PortraitViewController *portrait;

@property (nonatomic) UIButton *landscapeButton;
@property (nonatomic) UIButton *portraitButton;
@end

@implementation AppViewController

- (instancetype)init {
    NSLog(@"%s %@", __FUNCTION__, self);
    self = [super init];
    if (self) {
        self.orientation = [[OrientationViewController alloc] init];
        self.portrait = [[PortraitViewController alloc] init];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"deallocating %@\n%@", self, [NSThread callStackSymbols]);
}

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.landscapeButton = [self createLandscapeButton];
    [self.view addSubview:self.landscapeButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.landscapeButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.landscapeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    self.portraitButton = [self createPortraitButton];
    [self.view addSubview:self.portraitButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[l]-50-[p]" options:0 metrics:nil views:@{@"p": self.portraitButton, @"l":self.landscapeButton}]];

}

- (void)presentPortraitViewController {
    ColoredViewController *controller = [[ColoredViewController alloc] initWithColor:[UIColor yellowColor] supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
    controller.delegate = self;
    [self.portrait pushViewController:controller animated:YES];
}

- (void)presentLandscapeViewController {
    ColoredViewController *controller = [[ColoredViewController alloc] initWithColor:[UIColor blueColor] supportedInterfaceOrientations:UIInterfaceOrientationMaskAllButUpsideDown];
    controller.delegate = self;
    [self.orientation pushViewController:controller animated:YES];
}

- (void)coloredViewControllerDidDismiss:(ColoredViewController *)coloredViewController {
    if ([coloredViewController supportedInterfaceOrientations] == UIInterfaceOrientationMaskPortrait) {
        [self.portrait popViewController:coloredViewController animated:YES];
    }
    [self.orientation popViewController:coloredViewController animated:YES];
}

- (UIButton *)createLandscapeButton {
    return [self createButtonWithAction:@selector(presentLandscapeViewController) title:@"Show landscape"];
}

- (UIButton *)createPortraitButton {
    return [self createButtonWithAction:@selector(presentPortraitViewController) title:@"Show portrait"];
}

- (UIButton *)createButtonWithAction:(SEL)selector title:(NSString *)title {
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    dismissButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [dismissButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [dismissButton setTitle:title forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return dismissButton;
}

@end
