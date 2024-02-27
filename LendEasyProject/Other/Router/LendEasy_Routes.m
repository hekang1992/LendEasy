//
//  YBRoutes.m
//  AFNetworking
//
//  Created by LQ on 2018/7/17.
//

#import "LendEasy_Routes.h"
#import "LendEasy_RouterConfig.h"
@implementation LendEasy_Routes
+ (void)openURL:(NSString *)URL{
    NSURL *myUrl = [NSURL URLWithString:URL];
    if ([myUrl.scheme isEqualToString:@"https"]) {
        URL = [@"LendEasyHttps:" stringByAppendingString:myUrl.resourceSpecifier];
    }else if ([myUrl.scheme isEqualToString:@"http"]){
        URL = [@"LendEasyHttp:" stringByAppendingString:myUrl.resourceSpecifier];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL] options:[NSDictionary new] completionHandler:nil];
}
@end
