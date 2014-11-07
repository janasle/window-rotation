#import "ColoredViewController.h"

@interface ColoredViewController () <UITextFieldDelegate>
@property (nonatomic) UITextField *input;
@property (nonatomic) UIButton *button;
@property (nonatomic) NSUInteger supportedInterfaceOrientationsMask;
@end

@implementation ColoredViewController

- (instancetype)initWithColor:(UIColor *)color supportedInterfaceOrientations:(UIInterfaceOrientationMask)mask {
    self = [super init];
    if (self) {
        self.view.backgroundColor = color;
        _supportedInterfaceOrientationsMask = mask;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"deallocating %@", self);
}

- (NSUInteger)supportedInterfaceOrientations {
    NSLog(@"%s %@", __FUNCTION__, self);
    return self.supportedInterfaceOrientationsMask;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.input = [self createTextField];
    [self.view addSubview:self.input];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.input attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.input attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[i(==200)]" options:0 metrics:nil views:@{@"i": self.input}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[i(==50)]" options:0 metrics:nil views:@{@"i": self.input}]];
    
    self.button = [self createButton];
    [self.view addSubview:self.button];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[i]-50-[b]" options:0 metrics:nil views:@{@"i": self.input, @"b":self.button}]];
    
}

- (void)onButton {
    [self.delegate coloredViewControllerDidDismiss:self];
}

- (UIButton *)createButton {
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    dismissButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [dismissButton addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return dismissButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [self.input resignFirstResponder];
}

- (UITextField *)createTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.delegate = self;
    textField.textColor = [UIColor blackColor];
    textField.backgroundColor = [UIColor whiteColor];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.returnKeyType = UIReturnKeyDone;
    textField.textAlignment = NSTextAlignmentCenter;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}

@end
