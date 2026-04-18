#import "ToolBoxAppDelegate.h"
#import "ToolBoxRootViewController.h"

@implementation ToolBoxAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Khởi tạo RootViewController (file .mm mà mình đã gửi trước đó)
    ToolBoxRootViewController *rootVC = [[ToolBoxRootViewController alloc] init];
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
