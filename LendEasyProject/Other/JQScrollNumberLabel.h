//
//  JQScrollNumberLabel.h
//  JQScrollNumberLabelDemo
//
//  Created by HanJunqiang on 17/4/5.
//  Copyright © 2017 HaRi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQScrollNumberLabel : UIView

@property (nonatomic, strong)NSNumber *displayedNumber;

- (instancetype)initWithNumber:(NSNumber *)originNumber fontSize:(CGFloat)size;

- (instancetype)initWithNumber:(NSNumber *)originNumber fontSize:(CGFloat)size textColor:(UIColor *)color;

- (instancetype)initWithNumber:(NSNumber *)originNumber font:(UIFont *)font;

- (instancetype)initWithNumber:(NSNumber *)originNumber font:(UIFont *)font textColor:(UIColor *)color;

- (instancetype)initWithNumber:(NSNumber *)originNumber fontSize:(CGFloat)size rowNumber:(NSUInteger)rowNumber;

- (instancetype)initWithNumber:(NSNumber *)originNumber fontSize:(CGFloat)size textColor:(UIColor *)color rowNumber:(NSUInteger)rowNumber;

- (instancetype)initWithNumber:(NSNumber *)originNumber font:(UIFont *)font textColor:(UIColor *)color rowNumber:(NSUInteger)rowNumber;

- (void)changeToNumber:(NSNumber *)number animated:(BOOL)animated;

- (void)changeToNumber:(NSNumber *)number interval:(CGFloat)interval animated:(BOOL)animated;

@end
