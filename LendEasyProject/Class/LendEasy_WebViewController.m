//
//  LGWebViewController.m
//  LoanGuru
//
//  Created by Apple on 2023/3/1.
//

#import "LendEasy_WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "LendEasy_WebHandler.h"
#import "SVProgressHUD.h"
#import "LendEasyProject-Swift.h"
@interface LendEasy_WebViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    NSString *_url;
}
@property (nonatomic,strong) NSURLRequest *request;
@property (nonatomic, strong)LendEasy_WebHandler *handler;
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UIBarButtonItem *backItem;
@end

@implementation LendEasy_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = self.backItem;
    
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:[self baseConfig]];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    self.handler.webView = self.webView;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    self.progressView.progressTintColor = [UIColor jk_colorWithHexString:@"FF5A00"];
    self.progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:self.progressView];
    
    if([_url containsString:@"?"]){
        _url = [NSString stringWithFormat:@"%@&%@",_url,[LendEasy_publicMethod getPublicNetWord]];
    }else{
        _url = [NSString stringWithFormat:@"%@?%@",_url,[LendEasy_publicMethod getPublicNetWord]];
    }
    _url = [_url stringByReplacingOccurrencesOfString:@" " withString:@""];
    _url = [_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_url]];
    self.request = request;
    [self.webView loadRequest:self.request];
    
    [RACObserve(self.webView,estimatedProgress)subscribeNext:^(id  _Nullable x) {
        NSNumber *num = (NSNumber *)x;
        if(num.floatValue >= 1.0){
            [self.progressView setProgress:0];
        }else{
            [self.progressView setProgress:num.floatValue animated:YES];
        }
    }];
    
    [RACObserve(self.webView, title) subscribeNext:^(id  _Nullable x) {
        self.navigationItem.title = (NSString *)x;
    }];
}

-(void)backAction{
   if([_url containsString:@"rscdhjguxbqutt"]){
        [self.webView evaluateJavaScript:@"window.instanFinish()" completionHandler:^(id _Nullable script, NSError * _Nullable error) {
                
            }];
    }else{
        if(self.webView.canGoBack){
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (instancetype)initWithURL:(NSString *)URL{
    if (self = [super init]) {
        _url = URL;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
  }
}
-(void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
  };
}

- (WKWebViewConfiguration *)baseConfig{
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.userContentController = [WKUserContentController new];
    [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    config.processPool  = [LendEasy_WKProcessPool singleWkProcessPool];
    
    self.handler = [[LendEasy_WebHandler alloc] init];
    for (NSString *key in self.handler.handlers.allKeys) {
        [config.userContentController addScriptMessageHandler:self.handler name:key];
    }
    
     if (@available(iOS 10.0, *)) {
         config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeNone;
     } else {
         config.mediaTypesRequiringUserActionForPlayback = NO;
         config.allowsAirPlayForMediaPlayback = YES;
         config.mediaTypesRequiringUserActionForPlayback = NO;
     }
     config.allowsInlineMediaPlayback = YES;
     
     
    return config;
}

-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    NSLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    if ([URL.scheme isEqualToString:@"http"]||
        [URL.scheme isEqualToString:@"https"]||
        [URL.scheme isEqualToString:@"file"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        if ([[UIApplication sharedApplication]canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL options:[NSDictionary new] completionHandler:nil];
        }else{
            if([URL.scheme isEqualToString:@"whatsapp"]){
                [SVProgressHUD showErrorWithStatus:@"You have not installed WhatsApp yet."];
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
           if ([challenge previousFailureCount] == 0) {
               NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
               completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
           } else {
               completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
           }
       } else {
           completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
       }
}
@end

@implementation LendEasy_WKProcessPool

+ (LendEasy_WKProcessPool*)singleWkProcessPool{
     static LendEasy_WKProcessPool * sharedPool;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          sharedPool = [[LendEasy_WKProcessPool alloc]  init];
     });
     return sharedPool;
}
@end
