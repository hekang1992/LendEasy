//
//  XLSlideMenu.h
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/8.
//  Copyright © 2017 MengXianLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+XLSlideMenu.h"

@interface XLSlideMenu : UIViewController

@property (nonatomic, strong) UIViewController *rootViewController;

@property (nonatomic, strong) UIViewController *leftViewController;

@property (nonatomic, strong) UIViewController *rightViewController;

@property (nonatomic, assign, readonly) CGFloat menuWidth;

@property (nonatomic, assign, readonly) CGFloat emptyWidth;

@property (nonatomic ,assign) BOOL slideEnabled;

-(instancetype)initWithRootViewController:(UIViewController*)rootViewController;

-(void)showRootViewControllerAnimated:(BOOL)animated;

-(void)showLeftViewControllerAnimated:(BOOL)animated;

-(void)showRightViewControllerAnimated:(BOOL)animated;

@end
