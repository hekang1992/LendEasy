//
//  XLSlideMenu.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017 MengXianLiang. All rights reserved.
//  GitHub:https://github.com/mengxianliang/XLSlideMenu

#import "XLSlideMenu.h"

static CGFloat MenuWidthScale = 0.8f;
static CGFloat MaxCoverAlpha = 0.3;
static CGFloat MinActionSpeed = 500;

@interface XLSlideMenu ()<UIGestureRecognizerDelegate>{
    CGPoint _originalPoint;
}

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation XLSlideMenu
-(instancetype)initWithRootViewController:(UIViewController*)rootViewController{
    if (self = [super init]) {
        _rootViewController = rootViewController;
        [self addChildViewController:_rootViewController];
        [self.view addSubview:_rootViewController.view];
        [_rootViewController didMoveToParentViewController:self];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan.delegate = self;
    [self.view addGestureRecognizer:_pan];
    
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    _coverView.hidden = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    [_rootViewController.view addSubview:_coverView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateLeftMenuFrame];
    [self updateRightMenuFrame];
}

-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    _leftViewController.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self menuWidth], self.view.bounds.size.height)];
    [_leftViewController viewDidLoad];
    [self addChildViewController:_leftViewController];
    [self.view insertSubview:_leftViewController.view atIndex:0];
    [_leftViewController didMoveToParentViewController:self];
}

-(void)setRightViewController:(UIViewController *)rightViewController{
    _rightViewController = rightViewController;
    _rightViewController.view = [[UIView alloc] initWithFrame:CGRectMake([self emptyWidth], 0, [self menuWidth], self.view.bounds.size.height)];
    [_rightViewController viewDidLoad];
    [self addChildViewController:_rightViewController];
    [self.view insertSubview:_rightViewController.view atIndex:0];
    [_rightViewController didMoveToParentViewController:self];
}

-(void)setSlideEnabled:(BOOL)slideEnabled{
    _pan.enabled = slideEnabled;
}

-(BOOL)slideEnabled{
    return _pan.isEnabled;
}

-(void)pan:(UIPanGestureRecognizer*)pan{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _originalPoint = _rootViewController.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChanged:pan];
            break;
        case UIGestureRecognizerStateEnded:
            [self panEnd:pan];
            break;
            
        default:
            break;
    }
}


-(void)panChanged:(UIPanGestureRecognizer*)pan{
    CGPoint translation = [pan translationInView:self.view];
    _rootViewController.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
    if (!_rightViewController && CGRectGetMinX(_rootViewController.view.frame) <= 0 ) {
        _rootViewController.view.frame = self.view.bounds;
    }
    if (!_leftViewController && CGRectGetMinX(_rootViewController.view.frame) >= 0) {
        _rootViewController.view.frame = self.view.bounds;
    }
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 + self.menuWidth, _rootViewController.view.center.y);
    }
    if (CGRectGetMaxX(_rootViewController.view.frame) < self.emptyWidth) {
        _rootViewController.view.center = CGPointMake(_rootViewController.view.bounds.size.width/2 - self.menuWidth, _rootViewController.view.center.y);
    }
    if (CGRectGetMinX(_rootViewController.view.frame) > 0) {
        [self.view sendSubviewToBack:_rightViewController.view];
        [self updateLeftMenuFrame];
        _coverView.hidden = false;
        [_rootViewController.view bringSubviewToFront:_coverView];
        _coverView.alpha = CGRectGetMinX(_rootViewController.view.frame)/self.menuWidth * MaxCoverAlpha;
    }else if (CGRectGetMinX(_rootViewController.view.frame) < 0){
        [self.view sendSubviewToBack:_leftViewController.view];
        [self updateRightMenuFrame];
        _coverView.hidden = false;
        [_rootViewController.view bringSubviewToFront:_coverView];
        _coverView.alpha = (CGRectGetMaxX(self.view.frame) - CGRectGetMaxX(_rootViewController.view.frame))/self.menuWidth * MaxCoverAlpha;
    }
}

- (void)panEnd:(UIPanGestureRecognizer*)pan {
    CGFloat speedX = [pan velocityInView:pan.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self dealWithFastSliding:speedX];
        return;
    }
    if (CGRectGetMinX(_rootViewController.view.frame) > self.menuWidth/2) {
        [self showLeftViewControllerAnimated:true];
    }else if (CGRectGetMaxX(_rootViewController.view.frame) < self.menuWidth/2 + self.emptyWidth){
        [self showRightViewControllerAnimated:true];
    }else{
        [self showRootViewControllerAnimated:true];
    }
}

- (void)dealWithFastSliding:(CGFloat)speedX {
    BOOL swipeRight = speedX > 0;
    BOOL swipeLeft = speedX < 0;
    CGFloat roootX = CGRectGetMinX(_rootViewController.view.frame);
    if (swipeRight) {
        if (roootX > 0) {
            [self showLeftViewControllerAnimated:true];
        }else if (roootX < 0){
            [self showRootViewControllerAnimated:true];
        }
    }
    if (swipeLeft) {
        if (roootX < 0) {
            [self showRightViewControllerAnimated:true];
        }else if (roootX > 0){
            [self showRootViewControllerAnimated:true];
        }
    }
    return;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([_rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)_rootViewController;
        if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    if ([_rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarController = (UITabBarController*)_rootViewController;
        UINavigationController *navigationController = tabbarController.selectedViewController;
        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            if (navigationController.viewControllers.count > 1 && navigationController.interactivePopGestureRecognizer.enabled) {
                return NO;
            }
        }
    }
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGFloat actionWidth = [self emptyWidth];
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth) {
            return NO;
        } else {
            return NO;
        }
    }
    return NO;
}

- (void)tap {
    [self showRootViewControllerAnimated:true];
}

-(void)showRootViewControllerAnimated:(BOOL)animated{
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        CGRect frame = self->_rootViewController.view.frame;
        frame.origin.x = 0;
        self->_rootViewController.view.frame = frame;
        [self updateLeftMenuFrame];
        [self updateRightMenuFrame];
        self->_coverView.alpha = 0;
    }completion:^(BOOL finished) {
        self.coverView.hidden = true;
    }];
}

- (void)showLeftViewControllerAnimated:(BOOL)animated {
    if (!_leftViewController) {return;}
    [self.view sendSubviewToBack:_rightViewController.view];
    _coverView.hidden = false;
    [_rootViewController.view bringSubviewToFront:_coverView];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        self.rootViewController.view.center = CGPointMake(self->_rootViewController.view.bounds.size.width/2 + self.menuWidth, self->_rootViewController.view.center.y);
        self.leftViewController.view.frame = CGRectMake(0, 0, [self menuWidth], self.view.bounds.size.height);
        self.coverView.alpha = MaxCoverAlpha;
    }];
}

- (void)showRightViewControllerAnimated:(BOOL)animated {
    if (!_rightViewController) {return;}
    _coverView.hidden = false;
    [_rootViewController.view bringSubviewToFront:_coverView];
    [self.view sendSubviewToBack:_leftViewController.view];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        self.rootViewController.view.center = CGPointMake(self->_rootViewController.view.bounds.size.width/2 - self.menuWidth, self->_rootViewController.view.center.y);
        self.rightViewController.view.frame = CGRectMake([self emptyWidth], 0, [self menuWidth], self.view.bounds.size.height);
        self->_coverView.alpha = MaxCoverAlpha;
    }];
}

- (void)updateLeftMenuFrame {
    _leftViewController.view.center = CGPointMake(CGRectGetMinX(_rootViewController.view.frame)/2, _leftViewController.view.center.y);
}

- (void)updateRightMenuFrame {
    _rightViewController.view.center = CGPointMake((self.view.bounds.size.width + CGRectGetMaxX(_rootViewController.view.frame))/2, _rightViewController.view.center.y);
}

- (CGFloat)menuWidth {
    return MenuWidthScale * self.view.bounds.size.width;
}

- (CGFloat)emptyWidth {
    return self.view.bounds.size.width - self.menuWidth;
}

- (CGFloat)animationDurationAnimated:(BOOL)animated {
    return animated ? 0.25 : 0;
}

- (BOOL)shouldAutorotate {
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
