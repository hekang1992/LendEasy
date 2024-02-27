//
//  LGChooseDateAlertView.m
//  LoanGuru
//
//  Created by Apple on 2023/3/16.
//

#import "LendEasy_ChooseDateAlertView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LendEasy_ChooseDateAlertView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)NSString *dateStr;
@property (nonatomic, strong)NSString *currentYear;
@property (nonatomic, strong)NSString *currentMonth;
@property (nonatomic, strong)NSString *currentDay;
@property (nonatomic, strong)NSMutableArray *yearArr;
@property (nonatomic, strong)NSArray *monthArr;
@property (nonatomic, strong)NSMutableArray *dayArr;
@property (nonatomic, assign)NSCalendarUnit unitFlags;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic)NSInteger selectedMonthRow;
@property (nonatomic)NSInteger selectedYearRow;
@property (nonatomic)NSInteger selectedDayRow;
@property (nonatomic)BOOL ifFirst;
@end
@implementation LendEasy_ChooseDateAlertView
-(instancetype)initWithFrame:(CGRect)frame dateStr:(NSString *)dateStr{
    self = [super initWithFrame:frame];
    if(self){
        _dateStr = dateStr;
        self.yearArr = [NSMutableArray array];
        self.monthArr = [NSMutableArray array];
        self.dayArr = [NSMutableArray array];
        _ifFirst = NO;
        [self setUpView];
        [self getDateArr];
    }
    return self;
}

-(void)setUpView{
    self.backgroundColor = [UIColor clearColor];

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
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeBtn setImage:[UIImage imageNamed:@"home_alertView_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-19);
        make.top.mas_offset(20);
    }];
    
    self.alertTitleLabel = [[UILabel alloc] init];
    self.alertTitleLabel.text = @"Change birthday date";
    self.alertTitleLabel.textColor = [UIColor jk_colorWithHexString:@"111A34"];
    self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    [self.contentView addSubview:self.alertTitleLabel];
    [self.alertTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.closeBtn);
    }];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.layer.cornerRadius = 25.f;
    [self.confirmBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"FF5A00"]];
    [self.confirmBtn setTitle:@"Cnnfirm" forState:UIControlStateNormal];
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
    
    [self.contentView addSubview:self.pickerview];
    [self.pickerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(self.alertTitleLabel.mas_bottom).mas_offset(0);
        make.bottom.mas_offset(-100);
    }];
    
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

-(void)getDateArr{
    NSArray *timeArr = [_dateStr componentsSeparatedByString:@"/"];
    self.currentYear = timeArr[0];
    self.currentMonth = timeArr[1];
    self.currentDay = timeArr[2];
    NSInteger currentYear = self.currentYear.intValue;
    for(int i=0;i<81;i++){
        [self.yearArr insertObject:[NSString stringWithFormat:@"%ld",(long)currentYear - i] atIndex:0];
    }
    for(int i=1;i<81;i++){
        [self.yearArr addObject:[NSString stringWithFormat:@"%ld",(long)currentYear + i]];
    }
    
    self.monthArr = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
   
    NSString *currentYeadAndMonth = [NSString stringWithFormat:@"%@-%@",self.currentYear,self.currentMonth];
    NSDate *selectedDate = [NSDate jk_dateWithString:currentYeadAndMonth format:@"yyyy-MM"];
    NSInteger daylength = [NSDate jk_daysInMonth:selectedDate];
    for(int i=1;i<=daylength;i++){
        NSString *dayStr;
        if(i<10){
            dayStr = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",(long)i];
        }
        [self.dayArr addObject:dayStr];
    }
    
    [self.pickerview reloadAllComponents];
    
    for(int i=0;i<self.dayArr.count;i++){
        NSString *day = self.dayArr[i];
        if(self.currentDay.intValue == day.intValue){
            self.selectedDayRow = i;
            [self.pickerview selectRow:i inComponent:0 animated:YES];
        }
    }
    
    for(int i=0;i<self.monthArr.count;i++){
        NSString *month = self.monthArr[i];
        if(self.currentMonth.intValue == month.intValue){
            self.selectedMonthRow = i;
            [self.pickerview selectRow:i inComponent:1 animated:YES];
        }
    }
    
    for(int i=0;i<self.yearArr.count;i++){
        NSString *year = self.yearArr[i];
        if(self.currentYear.integerValue == year.intValue){
            self.selectedYearRow = i;
            [self.pickerview selectRow:i inComponent:2 animated:YES];
        }
    }
}



-(void)closeAction:(UIButton *)btn{
    [self removeFromSuperview];
}

-(void)confirmAction:(UIButton *)sender{
    [self removeFromSuperview];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@/%@",self.dayArr[_selectedDayRow],self.monthArr[_selectedMonthRow],self.yearArr[_selectedYearRow]];
    if(self.confirmBlock){
        self.confirmBlock(dateStr);
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.dayArr.count;
    }else if(component == 1){
        return self.monthArr.count;
    }else{
        return self.yearArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return self.dayArr[row];
    }else if(component == 1){
        return self.monthArr[row];
    }else{
        return self.yearArr[row];
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
    if((component == 2 && row == _selectedYearRow) || (component == 1 && row == _selectedMonthRow) || (component == 0 && row == _selectedDayRow)){
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
        pickerLabel.textColor = [UIColor jk_colorWithHexString:@"FF5A00"];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UILabel *piketLabel =  (UILabel *)[pickerView viewForRow:row forComponent:component];
    piketLabel.textColor = [UIColor jk_colorWithHexString:@"0C7472"];
    if(component == 0){
        self.selectedDayRow = row;
    }else if(component == 1){
        self.selectedMonthRow = row;
        self.currentMonth = self.monthArr[row];
    }else if(component == 2){
        self.selectedYearRow = row;
        self.currentYear = self.yearArr[row];
    }
    
    [self.dayArr removeAllObjects];
    NSString *currentYeadAndMonth = [NSString stringWithFormat:@"%@-%@",self.currentYear,self.currentMonth];
    NSDate *selectedDate = [NSDate jk_dateWithString:currentYeadAndMonth format:@"yyyy-MM"];
    NSInteger daylength = [NSDate jk_daysInMonth:selectedDate];
    for(int i=1;i<=daylength;i++){
        NSString *dayStr;
        if(i<10){
            dayStr = [NSString stringWithFormat:@"0%ld",(long)i];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",(long)i];
        }
        [self.dayArr addObject:dayStr];
    }
    if(self.dayArr.count - 1 < self.selectedDayRow){
        self.selectedDayRow = self.dayArr.count - 1;
    }
    
    [self.pickerview reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
     return 40;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return (SCREEN_WIDTH - 30)/3;
}
@end
