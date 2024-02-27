//
//  LGEnumAlertView.m
//  LoanGuru
//
//  Created by Apple on 2023/3/2.
//

#import "LendEasy_EnumAlertView.h"
#import "LGLocationCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static NSString *identifier = @"LGLocationCell";

@interface LendEasy_EnumAlertView()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation LendEasy_EnumAlertView
-(instancetype)initWithFrame:(CGRect)frame style:(CABottomAlertStyle)style itemArr:(NSArray *)itemArr{
    self = [super initWithFrame:frame];
    if(self){
        self.hasSelectCity = NO;
        self.itemArr = itemArr;
        self.alertStyle = style;
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 16.f;
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(10);
        make.height.mas_equalTo(300);
    }];
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68)];
    topBgView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:topBgView];
    [topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(68);
    }];
    [self insertTopShadow:topBgView fromColor:[UIColor jk_colorWithHexString:@"FF5A00"]  toColor:[UIColor whiteColor]];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"alertViewClose_icon"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-19);
        make.top.mas_offset(20);
        make.width.height.mas_equalTo(24);
    }];
    
    if(self.alertStyle == CACommonAlertStyle || self.alertStyle == CACountryAlertStyle){
        [self setUpCommonStyle];
    }else if(self.alertStyle == CALocationAlertStyle){
        [self setUpLocationStyle];
    }else{
        [self setUpTimeStyle];
    }
}

-(UIPickerView *)pickerview{
    if(!_pickerview){
        _pickerview = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerview.backgroundColor = [UIColor clearColor];
        _pickerview.layer.masksToBounds = YES;
        _pickerview.delegate = self;
        _pickerview.dataSource = self;
    }
    return _pickerview;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.tableView.contentInsetAdjustmentBehavior = NO;
        }
        if (@available(iOS 15.0, *)) {
             _tableView.sectionHeaderTopPadding = 0;
        }
        [_tableView registerNib:[UINib nibWithNibName:@"LGLocationCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    return _tableView;
}

-(void)setItemArr:(NSArray *)itemArr{
    _itemArr = itemArr;
    [self.tableView reloadData];
}

-(void)closeAction:(UIButton *)btn{
    [self removeFromSuperview];
}

-(void)insertTopShadow:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    UIColor *colorOne = [fromColor colorWithAlphaComponent:0.1];
    UIColor *colorTwo = [toColor colorWithAlphaComponent:0.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    self.topLayer = [CAGradientLayer layer];
    self.topLayer.colors = colors;
    self.topLayer.locations = locations;
     self.topLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, view.frame.size.height*2);
    [view.layer insertSublayer:self.topLayer above:0];
}

+(void)insertTopShadow:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor{
    LendEasy_EnumAlertView *alertView = [[LendEasy_EnumAlertView alloc] init];
    [alertView insertTopShadow:view fromColor:fromColor toColor:toColor];
}

-(void)setUpCommonStyle{
    self.alertTitleLabel = [[UILabel alloc] init];
    self.alertTitleLabel.textColor = [UIColor jk_colorWithHexString:@"333333"];
    self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [self.contentView addSubview:self.alertTitleLabel];
    [self.alertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.closeBtn);
    }];
    
    [self.contentView addSubview:self.pickerview];
    [self.pickerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(self.alertTitleLabel.mas_bottom).mas_offset(0);
        make.bottom.mas_offset(-100);
    }];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.layer.cornerRadius = 25.f;
    [self.confirmBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"FF5A00"]];
    [self.confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.bottom.mas_offset(-30);
        make.height.mas_equalTo(50);
    }];
    [self.confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setUpLocationStyle{
    self.locationLabel = [[UILabel alloc] init];
    self.locationLabel.text = @"";
    self.locationLabel.textColor = [UIColor jk_colorWithHexString:@"333333"];
    self.locationLabel.font = [UIFont systemFontOfSize:16.f];
    [self.contentView addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.closeBtn);
    }];
    
    UIImageView *arrowIcon = [[UIImageView alloc] init];
    arrowIcon.image = [UIImage imageNamed:@"home_locationArrow_icon"];
    arrowIcon.hidden = YES;
    [self.contentView addSubview:arrowIcon];
    [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationLabel.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(self.locationLabel);
    }];
    self.arrowIcon = arrowIcon;
    
    self.selectTitleLabel = [[UILabel alloc] init];
    self.selectTitleLabel.textColor = [UIColor jk_colorWithHexString:@"FF5A00"];
    self.selectTitleLabel.text = @"Select";
    self.selectTitleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [self.contentView addSubview:self.selectTitleLabel];
    [self.selectTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.locationLabel);
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(self.selectTitleLabel.mas_bottom).mas_offset(24);
        make.bottom.mas_offset(-35);
    }];
}

-(void)setUpTimeStyle{
    
}

-(void)confirmAction:(UIButton *)btn{
    [self removeFromSuperview];
    if(self.alertStyle == CACountryAlertStyle){
//        LGNetworkUrlModel *model = self.itemArr[_selectedRow];
//        if(self.selectCountryBlock){
//            self.selectCountryBlock(model);
//        }
    }else{
        if(self.confirmBlock){
            self.confirmBlock(_selectedRow);
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.itemArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(self.alertStyle == CACountryAlertStyle){
        return self.itemArr[row];
    }else{
        return self.itemArr[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setFont:[UIFont systemFontOfSize:14.f]];
        pickerLabel.textColor = [UIColor jk_colorWithHexString:@"888888"];
    }
    if(row == _selectedRow){
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
        pickerLabel.textColor = [UIColor jk_colorWithHexString:@"FF5A00"];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedRow = row;
    [self.pickerview reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
     return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
      return SCREEN_WIDTH - 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LGLocationCell *cell = (LGLocationCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.locationLabel.text = self.itemArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectLocationBlock){
        self.selectLocationBlock(indexPath.row);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)selectTitleLabelRemakeConstant{
    [self.selectTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arrowIcon.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(self.locationLabel);
    }];
}
@end
