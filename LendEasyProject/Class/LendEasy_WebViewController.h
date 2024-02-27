//
//  LGWebViewController.h
//  LoanGuru
//
//  Created by Apple on 2023/3/1.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void(^webBlock)(WKScriptMessage * _Nullable message,NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface LendEasy_WebViewController : UIViewController

@property (nonatomic,strong) WKWebView *webView;

- (instancetype)initWithURL:(NSString *)URL;
@end


@interface LendEasy_WKProcessPool : WKProcessPool

+ (LendEasy_WKProcessPool*)singleWkProcessPool;

@end
NS_ASSUME_NONNULL_END
