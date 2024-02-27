//
//  YBRouteRegister.m
//  AFNetworking
//
//  Created by LQ on 2018/7/17.
//

#import "LendEasy_RouteRegister.h"
#import "LendEasy_Routes.h"
#import "LendEasy_RouterConfig.h"
#import "LendEasy_WebViewController.h"
#import "LendEasy_ModuleManager.h"
#import "UIViewController+LendEasy_ViewController.h"
@implementation LendEasy_RouteRegister

+ (void)load{
    [LendEasy_ModuleManager registerAppdelegateModule:self.class];
}

+ (void)enroll:(NSArray<__kindof NSString*>*)modules{
    NSMutableArray *allModules = [NSMutableArray array];
    [allModules addObject:@"LendEasy_RouteRegister"];
    [allModules addObjectsFromArray:modules];
    for (int i = 0; i < allModules.count; i++) {
        Class cls = NSClassFromString(allModules[i]);
        id r = [cls new];
        if ([r conformsToProtocol:@protocol(KIRouteRegisterProtocol)]) {
            [r enroll];
        }
    }
}

- (void)enroll {
    [LendEasy_Routes.globalRoutes addRoute:@"/push/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return [self push:parameters];
    }];
    
    [LendEasy_Routes.globalRoutes addRoute:@"/present/:controller" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return [self present:parameters];
    }];

    [LendEasy_Routes.globalRoutes addRoute:@"/html/:fileName" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        NSString *fileName = parameters[@"fileName"];
        if(!fileName || fileName.length == 0){
            return NO;
        }
        NSString *filePath = [NSBundle.mainBundle pathForResource:fileName ofType:@"html"];
        NSURL *URL = [NSURL fileURLWithPath:filePath];
        NSString *url = URL.absoluteString;
        [self pushToWebViewWithUrlStr:url];
        return YES;
    }];
    
    LendEasy_Routes.globalRoutes.unmatchedURLHandler = ^(JLRoutes * _Nonnull routes, NSURL * _Nullable URL, NSDictionary<NSString *,id> * _Nullable parameters) {
        NSString *urlStr;
        if([URL.scheme isEqualToString:httpRouteSchema]){
           urlStr = [@"http:"stringByAppendingString:URL.resourceSpecifier];
            [self pushToWebViewWithUrlStr:urlStr];
        }
        else if([URL.scheme isEqualToString:httpsRouteSchema]){
           urlStr = [@"https:"stringByAppendingString:URL.resourceSpecifier];
            [self pushToWebViewWithUrlStr:urlStr];
        }else if ([URL.scheme isEqualToString:@"https"] || [URL.scheme isEqualToString:@"http"]){
            [self pushToWebViewWithUrlStr:URL.absoluteString];
        }
    };
    
}

- (BOOL)push:(NSDictionary <NSString *,id> *)parameters{
    Class cls = NSClassFromString(parameters[@"controller"]);
    if (!cls) {
        return NO;
    }
    UIViewController *vc = [cls new];
    vc.routeArguments = parameters;
    [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
    return YES;
}

- (BOOL)present:(NSDictionary <NSString *,id> *)parameters{
    Class cls = NSClassFromString(parameters[@"controller"]);
    if (!cls) {
        return NO;
    }
    UIViewController *vc = [cls new];
    vc.routeArguments = parameters;
    [[UIViewController topViewController] presentViewController:vc animated:YES completion:nil];
    return YES;
}

- (void)pushToWebViewWithUrlStr:(NSString *)urlStr{
    LendEasy_WebViewController *vc = [[LendEasy_WebViewController alloc]initWithURL:urlStr];
    UIViewController *top = [UIViewController topViewController];
    if (top && top.navigationController) {
        [top.navigationController pushViewController:vc animated:YES];
    }
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:defaultRouteSchema]
        || [url.scheme isEqualToString:httpRouteSchema]
        || [url.scheme isEqualToString:httpsRouteSchema]) {
        [LendEasy_Routes.globalRoutes routeURL:url];
    }
    return YES;
}

@end
