//
//  LGMainRouteRegister.m
//  LoanGuru
//
//  Created by Apple on 2023/3/1.
//

#import "LendEasy_HomeRouteRegister.h"
#import "LendEasy_ModuleManager.h"
#import "LendEasy_Routes.h"
@implementation LendEasy_HomeRouteRegister
+ (void)load{
    [LendEasy_ModuleManager registerAppdelegateModule:self.class];
}


+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

-(void)enroll{
    //login
    [LendEasy_Routes.globalRoutes addRoute:@"/decidedPhronsie" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        [LendEasy_User checkIsLoginWithTopViewController:[UIViewController topViewController]];
        return YES;
    }];
    
    //main
    [LendEasy_Routes.globalRoutes addRoute:@"/wailingStick" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate toHomePage];
        return YES;
    }];
    
    //productDetail
    [LendEasy_Routes.globalRoutes addRoute:@"/elegantMamsie" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        LendEasy_VertifyProcessViewController *vc = [[LendEasy_VertifyProcessViewController alloc] init];
        vc.loadId = [NSString stringWithFormat:@"%@",parameters[@"stories"]];
        [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    //setting
    [LendEasy_Routes.globalRoutes addRoute:@"/afterBrown" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        LendEasy_aboutViewController *setvc = [[LendEasy_aboutViewController alloc] init];
        [[UIViewController topViewController].navigationController pushViewController:setvc animated:YES];
        return YES;
    }];
    
    
    //product detail
    [LendEasy_Routes.globalRoutes addRoute:@"/elegantMamsie" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        LendEasy_VertifyProcessViewController *vc = [[LendEasy_VertifyProcessViewController alloc] init];
        [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    //order
    [LendEasy_Routes.globalRoutes addRoute:@"/slippingWasnt" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *tabStr = parameters[@"poplars"];
        LendEasy_ViewController *vc = [[LendEasy_ViewController alloc] init];
        vc.type = tabStr;
        [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
        return YES;
    }];
    
    //kf home
    [LendEasy_Routes.globalRoutes addRoute:@"/excitementDropped" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return YES;
    }];
}
@end
