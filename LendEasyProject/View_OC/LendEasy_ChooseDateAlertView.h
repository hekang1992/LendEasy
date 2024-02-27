//
//  LGChooseDateAlertView.h
//  LoanGuru
//
//  Created by Apple on 2023/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LendEasy_ChooseDateAlertView : UIView
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UILabel *alertTitleLabel;
@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UIPickerView *pickerview;
@property (nonatomic, strong)UIButton *confirmBtn;
-(instancetype)initWithFrame:(CGRect)frame dateStr:(NSString *)dateStr;
@property (nonatomic, copy)void(^confirmBlock)(NSString *dateStr);
@end

NS_ASSUME_NONNULL_END
