//
//  LGEnumAlertView.h
//  LoanGuru
//
//  Created by Apple on 2023/3/2.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    CACommonAlertStyle,
    CALocationAlertStyle,
    CATimeAlertStyle,
    CACountryAlertStyle
} CABottomAlertStyle;

NS_ASSUME_NONNULL_BEGIN

@interface LendEasy_EnumAlertView : UIView
@property (nonatomic, strong) CAGradientLayer *topLayer; 
@property (nonatomic, strong)UIPickerView *pickerview;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)NSArray *itemArr;
@property (nonatomic, strong)UILabel *alertTitleLabel;
@property (nonatomic)CABottomAlertStyle alertStyle;

@property (nonatomic, strong)UIButton *closeBtn;
//commonstyle
@property (nonatomic)NSInteger selectedRow;
@property (nonatomic, strong)UIButton *confirmBtn;
//locationStyle
@property (nonatomic, strong)UILabel *locationLabel;
@property (nonatomic, strong)UIImageView *arrowIcon;
@property (nonatomic, strong)UILabel *selectTitleLabel;
@property (nonatomic, strong)NSMutableArray *locationArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic)BOOL hasSelectCity;

@property (nonatomic, copy)void(^selectCountryBlock)(NSInteger index);
@property (nonatomic, copy)void(^confirmBlock)(NSInteger index);

@property (nonatomic, copy)void(^selectLocationBlock)(NSInteger index);
-(instancetype)initWithFrame:(CGRect)frame style:(CABottomAlertStyle)style itemArr:(NSArray *)itemArr;
-(void)selectTitleLabelRemakeConstant;

+(void)insertTopShadow:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;
@end

NS_ASSUME_NONNULL_END
