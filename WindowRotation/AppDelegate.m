#import "AppDelegate.h"

#import "AppViewController.h"
#import "AppWindow.h"

@interface AppDelegate ()
@property (nonatomic) AppViewController *vc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s", __FUNCTION__);
//    self.window = [[AppWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.vc = [[AppViewController alloc] init];
    self.window.rootViewController = self.vc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    NSLog(@"%s %@", __FUNCTION__, window);
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
