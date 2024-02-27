//
//  LGConfirmCardInfoAlertView.m
//  LoanGuru
//
//  Created by Apple on 2023/2/28.
//

#import "LendEasy_ConfirmCardInfoAlertView.h"
#import <TPKeyboardAvoidingTableView.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LendEasy_ConfirmCardInfoAlertView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong)TPKeyboardAvoidingTableView *tableview;
@property (nonatomic, strong)UIView *tableHeaderView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UILabel *topTitleLabel;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)NSArray *frontInfoFillTitleArr;
@property (nonatomic, strong)NSArray *frontInfoResultArr;
@property (nonatomic, strong)LendEasy_CardFillInfoItem *nameItem;
@property (nonatomic, strong)LendEasy_CardFillInfoItem *cardNoItem;
@property (nonatomic, strong)LendEasy_CardFillInfoItem *birthItem;
@property (nonatomic, strong)NSString *nameStr;
@property (nonatomic, strong)NSString *certNoStr;
@property (nonatomic, strong)NSString *birthNoStr;
@property (nonatomic, strong) CAGradientLayer *topLayer;
@property (nonatomic, strong)UIButton *closeBtn;
@end
@implementation LendEasy_ConfirmCardInfoAlertView

-(instancetype)initWithFrame:(CGRect)frame nameResult:(NSString *)name numberResult:(NSString *)certNo birthNo:(NSString *)birthNO{
    self = [super initWithFrame:frame];
    if(self){
        self.frontInfoFillTitleArr = @[@"Name",@"Document number",@"Date of Birth"];
        self.nameStr = name;
        self.certNoStr = certNo;
        self.birthNoStr = birthNO;
        [self setUpView];
    }
    return self;
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            _tableview.contentInsetAdjustmentBehavior = NO;
        }
        _tableview.tableHeaderView = self.tableHeaderView;
    }
    return _tableview;
}


-(void)setUpView{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
}

-(UIView *)tableHeaderView{
    if(!_tableHeaderView){
        _tableHeaderView = [[UIView alloc] init];
        _tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableHeaderView.tag = 101;
        _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
//        tap.delegate = self;
//        [_tableHeaderView addGestureRecognizer:tap];
        
        self.contentView = [[UIView alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 12.f;
        self.contentView.clipsToBounds = YES;
        [_tableHeaderView addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(8);
            make.right.mas_offset(-8);
            make.bottom.mas_offset(-8);
            make.height.mas_equalTo(310);
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
        [topBgView addSubview:self.closeBtn];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-19);
            make.top.mas_offset(20);
            make.width.height.mas_equalTo(24);
        }];
        
        self.topTitleLabel = [[UILabel alloc] init];
        self.topTitleLabel.text = @"Information confirmation";
        self.topTitleLabel.textColor = [UIColor blackColor];
        self.topTitleLabel.font = [UIFont boldSystemFontOfSize:18.f];
        [self.contentView addSubview:self.topTitleLabel];
        [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(24);
            make.left.mas_offset(16);
        }];
        
        UIView *lastView;
        for(int i=0;i<self.frontInfoFillTitleArr.count;i++){
            LendEasy_CardFillInfoItem *item = [[LendEasy_CardFillInfoItem alloc] initWithFrame:CGRectZero titleStr:self.frontInfoFillTitleArr[i] resultStr:@""];
            [self.contentView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(0);
                make.right.mas_offset(0);
                make.height.mas_equalTo(38);
                make.top.mas_equalTo(self.topTitleLabel.mas_bottom).mas_offset(48*i + 16);
            }];
            if(i == 0){
                self.nameItem = item;
                self.nameItem.fillInfoTextField.text = self.nameStr;
            }
            if(i == 1){
                self.cardNoItem = item;
                self.cardNoItem.fillInfoTextField.text = self.certNoStr;
            }
            if(i == 2){
                self.birthItem = item;
                self.birthItem.fillInfoTextField.text = self.birthNoStr;
                item.arrowIcon.hidden = NO;
                item.chooseTimeBtn.userInteractionEnabled = YES;
                item.chooseTimeBtn.hidden = NO;
                [item.chooseTimeBtn addTarget:self action:@selector(chooseTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            if(i == self.frontInfoFillTitleArr.count - 1){
                lastView = item;
            }
        }

        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
        [self.confirmBtn setBackgroundColor:[UIColor jk_colorWithHexString:@"FF5A00"]];
        self.confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.confirmBtn.layer.cornerRadius = 23.f;
        [self.contentView addSubview:self.confirmBtn];
        [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(24);
            make.right.mas_offset(-24);
            make.height.mas_equalTo(46);
            make.bottom.mas_offset(-34);
        }];
    }
    return _tableHeaderView;
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

-(void)chooseTimeAction:(UIButton *)sender{
    LendEasy_CardFillInfoItem *itemView = (LendEasy_CardFillInfoItem *)sender.superview.superview;
    if(self.chooseTimeBlock){
        self.chooseTimeBlock(itemView.fillInfoTextField);
    }
}

-(void)closeAction:(UIButton *)sender{
    [self removeFromSuperview];
    if(self.cancelBlock){
        self.cancelBlock();
    }
}

-(void)confirmAction:(UIButton *)sender{
    [self removeFromSuperview];
    if(self.confirmBlock){
        self.confirmBlock(self.nameItem.fillInfoTextField.text, self.cardNoItem.fillInfoTextField.text, self.birthItem.fillInfoTextField.text);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIView *touchView = touch.view;
    if (touchView.tag != 101) {
      return NO;
    }
    return  YES;
}
@end

@implementation LendEasy_CardFillInfoItem
-(instancetype)initWithFrame:(CGRect)frame titleStr:(NSString *)titleStr resultStr:(NSString *)resultStr{
    self = [super initWithFrame:frame];
    if(self){
        _titleStr = titleStr;
        _resultStr = resultStr;
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    self.fillBgView = [[UIView alloc] init];
    self.fillBgView.backgroundColor = [UIColor clearColor];
    self.fillBgView.layer.cornerRadius = 8.0f;
    self.fillBgView.clipsToBounds = YES;
    [self addSubview:self.fillBgView];
    [self.fillBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_offset(0);
        make.height.mas_equalTo(38);
    }];
    
    self.fillTitleLabel = [[UILabel alloc] init];
    self.fillTitleLabel.textColor = [UIColor blackColor];
    self.fillTitleLabel.font = [UIFont systemFontOfSize:12.f];
    self.fillTitleLabel.text = self.titleStr;
    [self.fillBgView addSubview:self.fillTitleLabel];
    [self.fillTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(14);
        make.centerY.mas_equalTo(self.fillBgView);
        make.width.mas_equalTo(105);
    }];
    
    self.arrowIcon = [[UIImageView alloc] init];
    self.arrowIcon.image = [UIImage imageNamed:@"mine_enter"];
    self.arrowIcon.hidden = YES;
    [self.fillBgView addSubview:self.arrowIcon];
    [self.arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_equalTo(self.fillBgView);
        make.width.height.mas_equalTo(15);
    }];
     
    self.fillInfoTextField = [[UITextField alloc] init];
    self.fillInfoTextField.textColor = [UIColor blackColor];
    self.fillInfoTextField.font = [UIFont boldSystemFontOfSize:12.f];
    self.fillInfoTextField.text = _resultStr;
    [self.fillBgView addSubview:self.fillInfoTextField];
    [self.fillInfoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fillTitleLabel.mas_right).mas_offset(24);
        make.centerY.mas_equalTo(self.fillTitleLabel);
        make.right.mas_offset(-40);
        make.height.mas_equalTo(38);
    }];
    
    self.chooseTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseTimeBtn.hidden = YES;
    self.chooseTimeBtn.userInteractionEnabled = NO;
    self.chooseTimeBtn.backgroundColor = [UIColor clearColor];
    [self.chooseTimeBtn setTitle:@"" forState:UIControlStateNormal];
    [self.fillBgView addSubview:self.chooseTimeBtn];
    [self.chooseTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.fillInfoTextField);
    }];
    
}
@end
