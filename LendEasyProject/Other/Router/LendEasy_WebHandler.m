//
//  WeakScriptMessageHandler.m
//  youonBikePlanA
//
//  Created by karry on 2020/8/3.
//  Copyright © 2020 audi. All rights reserved.
//

#import "LendEasy_WebHandler.h"
#import<StoreKit/StoreKit.h>
#import "LendEasy_Route.h"

@interface LendEasy_WebHandler()

@end

@implementation LendEasy_WebHandler

- (instancetype)init{
    if (self = [super init]) {
        _handlers = [NSMutableDictionary dictionary];
        [self setupJsHandle];
    }
    return self;
}

- (void)addName:(NSString *)name receiveMessage:(WebViewGetMessageBlock)block{
    if (!name || name.length == 0) {
        NSError *error = [NSError errorWithDomain:@"name can not be empty" code:111 userInfo:nil];
        block(nil,error);
        return;
    }
    _handlers[name] = block;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *key = message.name;
    if (!key) {
        NSLog(@"js error");
        return;
    }
    WebViewGetMessageBlock block = _handlers[key];
    !block?:block(message,nil);
}

- (void)setupJsHandle{
    [self addName:@"shrillyDeath" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSLog(@"%@",message.body);
        @try {
            NSArray *arr = message.body;
            NSString *productId = [NSString stringWithFormat:@"%@",arr[0]];
            NSString *startTime = [NSString stringWithFormat:@"%@",arr[1]];
            AppDelegate *appdelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
            [appdelegate addhtmlPointWithLoanId:productId firstTime:startTime];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }];
    
    [self addName:@"pollyDavid" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        NSLog(@"%@",message.body);
        @try {
            NSArray *arr = message.body;
            NSString *appstoreUrl = [NSString stringWithFormat:@"%@",arr[0]];
            
            NSRange range = [appstoreUrl rangeOfString:@"ld.easy/"];
            if(range.location == NSNotFound){
                [LendEasy_Routes routeURL:[NSURL URLWithString:appstoreUrl]];
            }else{
                [LendEasy_Routes routeURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",appstoreUrl]]];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
    }];
    
    [self addName:@"anotherStream" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        [[UIViewController topViewController].navigationController popViewControllerAnimated:YES];
    }];
    
    [self addName:@"beggsDavie" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        [[UIViewController topViewController].navigationController popToRootViewControllerAnimated:YES];
    }];
    
    [self addName:@"highchairBiting" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        
        @try {
            NSArray *arr = message.body;
            NSString *phoneNumber = [NSString stringWithFormat:@"%@",arr[0]];
            
            NSString* phoneString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
            NSURL* phoneUrl = [NSURL URLWithString:phoneString];
            [[UIApplication sharedApplication] openURL:phoneUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }];
 
    [self addName:@"breakWasnt" receiveMessage:^(WKScriptMessage *message, NSError *error) {
        if (@available(iOS 10.3, *)) {
           [SKStoreReviewController requestReview];
        }
    }];
}
@end
