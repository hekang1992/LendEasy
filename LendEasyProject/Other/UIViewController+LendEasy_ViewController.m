//
//  UIViewController+YBViewController.m
//  AFNetworking
//
//  Created by LQ on 2018/7/17.
//

#import "UIViewController+LendEasy_ViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (LendEasy_ViewController)
- (NSDictionary *)routeArguments{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRouteArguments:(NSDictionary *)routeArguments{
    objc_setAssociatedObject(self, @selector(routeArguments), routeArguments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIViewController *)topViewController{
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *rootVC = window.rootViewController;
    UIViewController *activityVC = nil;
    
    while (true) {
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            activityVC = [(UINavigationController *)rootVC visibleViewController];
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
            activityVC = [(UITabBarController *)rootVC selectedViewController];
        } else if (rootVC.presentedViewController) {
            activityVC = rootVC.presentedViewController;
        }else {
            break;
        }

        rootVC = activityVC;
    }
    
    return activityVC;
    
}
@end
