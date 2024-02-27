//
//  UILabel+AttributeText.m
//  youonBikePlanA
//
//  Created by Alex on 2022/4/28.
//  Copyright © 2022 audi. All rights reserved.
//

#import "UILabel+AttributeText.h"

@implementation UILabel (AttributeText)

- (void)setAttributedTextWithHtmlString:(NSString *)str {
     if ([str containsString:@"<"] || [str containsString:@">"]) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                              initWithData:[str dataUsingEncoding:
                                                              NSUnicodeStringEncoding]
                                                              options:@{
                                                                NSDocumentTypeDocumentAttribute:
                                                                NSHTMLTextDocumentType
                                                              }
                                                              documentAttributes:nil error:nil];
               dispatch_async(dispatch_get_main_queue(), ^{
                    self.attributedText = attributedString;
               });
          });
     } else {
          self.text = str;
     }
}

- (void)setAttributedTextWithHtmlString:(NSString *)str textColor:(UIColor *)color textFont:(UIFont *)font {
     if ([str containsString:@"<"] || [str containsString:@">"]) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                              initWithData:[str dataUsingEncoding:
                                                              NSUnicodeStringEncoding]
                                                              options:@{
                                                                NSDocumentTypeDocumentAttribute:
                                                                NSHTMLTextDocumentType
                                                              }
                                                              documentAttributes:nil error:nil];
               [attributedString addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:NSMakeRange(0, attributedString.length)];
               dispatch_async(dispatch_get_main_queue(), ^{
                    self.attributedText = attributedString;
               });
          });
     } else {
          self.text = str;
     }
}

- (void)setAttributedTextWithHtmlString:(NSString *)str textFont:(UIFont *)font{
     if ([str containsString:@"<"] || [str containsString:@">"]) {
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]
                                                              initWithData:[str dataUsingEncoding:
                                                              NSUnicodeStringEncoding]
                                                              options:@{
                                                                NSDocumentTypeDocumentAttribute:
                                                                NSHTMLTextDocumentType
                                                              }
                                                              documentAttributes:nil error:nil];
               [attributedString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, attributedString.length)];
               dispatch_async(dispatch_get_main_queue(), ^{
                    self.attributedText = attributedString;
               });
          });
     } else {
          self.text = str;
     }
}
@end
