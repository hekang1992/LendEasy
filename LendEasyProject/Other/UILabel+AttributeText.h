//
//  UILabel+AttributeText.h
//  youonBikePlanA
//
//  Created by Alex on 2022/4/28.
//  Copyright © 2022 audi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (AttributeText)

- (void)setAttributedTextWithHtmlString:(NSString *)str;

- (void)setAttributedTextWithHtmlString:(NSString *)str textFont:(UIFont *)font;

- (void)setAttributedTextWithHtmlString:(NSString *)str textColor:(UIColor *)color textFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
