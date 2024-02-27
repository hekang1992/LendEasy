//
//  LGConfirmCardInfoAlertView.h
//  LoanGuru
//
//  Created by Apple on 2023/2/28.
//

#import <UIKit/UIKit.h>
#import <TPKeyboardAvoidingScrollView.h>
NS_ASSUME_NONNULL_BEGIN

@interface LendEasy_CardFillInfoItem : UIView
@property (nonatomic, strong)UILabel *fillTitleLabel;
@property (nonatomic, strong)UIView *fillBgView;
@property (nonatomic, strong)UITextField *fillInfoTextField;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *resultStr;
@property (nonatomic, strong)UIImageView *arrowIcon;
@property (nonatomic, strong)UIButton *chooseTimeBtn;
-(instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr resultStr:(NSString *)resultStr;
@end

@interface LendEasy_ConfirmCardInfoAlertView : UIView
-(instancetype)initWithFrame:(CGRect)frame nameResult:(NSString *)name numberResult:(NSString *)certNo birthNo:(NSString *)birthNO;

@property(nonatomic, copy)void(^confirmBlock)(NSString *name,NSString *cardNo,NSString *birth);
@property(nonatomic, copy)void(^chooseTimeBlock)(UITextField *textField);
@property(nonatomic, copy)void(^cancelBlock)(void);
@end

NS_ASSUME_NONNULL_END
