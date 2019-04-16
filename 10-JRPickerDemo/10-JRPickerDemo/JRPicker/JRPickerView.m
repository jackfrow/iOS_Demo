//
//  JRPickerView.m
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "JRPickerView.h"
#import "JRPickerModel.h"
#import "UIView+JRAdd.h"
#import "NSArray+JRAdd.h"
#import "UIColor+JRAdd.h"

#define PickerWidth  [UIScreen mainScreen].bounds.size.width
#define PickerHeight [UIScreen mainScreen].bounds.size.height
#define AccessoryViewHeight 45
#define AccessoryViewBtnWidth 60
#define PickerContentHeight 175

@interface JRPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

//数据源(所有的数据)
@property (nonatomic,strong) NSMutableArray<JRPickerModel*>* dataSource;
@property (nonatomic,strong) NSMutableArray<NSMutableArray<JRPickerModel*> *>* rows ;

//view
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *titleLabel;

//ComponetsCount
@property (nonatomic, assign) NSInteger numberOfComponents;

@end

@implementation JRPickerView

+(void)showWithSelectHandler:(JRPickerHandle)handler dateSource:(NSArray<JRPickerModel *> *)dataSource numberOfComponents:(NSInteger)numberOfComponents{
    
    [self showWithSelectHandler:handler title:@"" dateSource:dataSource numberOfComponents:numberOfComponents];
    
}

+(void)showWithSelectHandler:(JRPickerHandle)handler title:(NSString *)title dateSource:(NSArray<JRPickerModel*>*)dataSource numberOfComponents:(NSInteger)numberOfComponents{
    
    JRPickerView* picker = [[JRPickerView alloc] init];
    picker.handler = handler;
    picker.numberOfComponents = numberOfComponents;
    picker.title = title;
    picker.dataSource = dataSource.mutableCopy;
    [picker config];
    [[UIApplication sharedApplication].keyWindow addSubview:picker];
    [picker show];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, PickerWidth, PickerHeight)]) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.accessoryView];
        [self addSubview:self.pickerView];
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pickerView.bottom = self.height;
        self.accessoryView.bottom = self.pickerView.top;
        self.backgroundView.alpha = 0.6;
    } completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.accessoryView.top = self.height;
        self.pickerView.top = self.accessoryView.bottom;
        self.backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)confirmSelection{
    
    if (self.handler) {
           NSMutableArray<JRPickerModel *> *resultModels = [NSMutableArray arrayWithCapacity:self.numberOfComponents];
        if ([self configResultModels:resultModels]) {
            self.handler([resultModels copy]);
        }
    }
    
    [self dismiss];
}

-(void)config{
    
    JRPickerModel* object = self.dataSource.firstObject;
    [self.rows setObject:self.dataSource atIndexedSubscript:0];
    for (self.numberOfComponents = 1;; self.numberOfComponents++) {
        [self.rows setObject:object.subModels atIndexedSubscript:self.numberOfComponents];
        object = [self objectAtIndex:0 inObject:object];
        if (!object) {
            break;
        }
    }
//     [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
}

#pragma mark UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.numberOfComponents;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.rows[component].count;

}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *lable = (UILabel *)view;
    if (!lable) {
        lable = [[UILabel alloc] init];
        [lable setTextColor:[UIColor textGrayColor]];
        [lable setFont:[UIFont systemFontOfSize:19.0]];
        [lable setAdjustsFontSizeToFitWidth:YES];
        [lable setTextAlignment:NSTextAlignmentCenter];
        [lable setWidth:floorf(PickerWidth/3.0) - 5];
    }
    [lable setText:[self pickerView:pickerView titleForRow:row forComponent:component]];
    return lable;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    NSArray<JRPickerModel*>* model = [self.rows objectOrNilAtIndex:component];
    if (model.count) {
        return model[row].title;
    }
    
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return floorf(PickerWidth/3.0) - 5;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44.0;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component < (self.numberOfComponents - 1)) {
        NSMutableArray<JRPickerModel *> *tmp = self.rows[component];
        if (tmp.count > 0) {
            tmp = tmp[row].subModels;
        }
        [self.rows setObject:((tmp.count > 0) ? tmp : [NSMutableArray array])  atIndexedSubscript:component + 1];
        
        [self pickerView:pickerView didSelectRow:0 inComponent:component + 1];
        [pickerView selectRow:0 inComponent:component + 1 animated:NO];
    }
    [pickerView reloadComponent:component];
    
}

#pragma mark - Helper
- (JRPickerModel *)objectAtIndex:(NSInteger)index inObject:(JRPickerModel *)object{
    if (object.subModels.count > index) {
        return object.subModels[index];
    }
    return nil;
}

- (BOOL)configResultModels:(NSMutableArray <JRPickerModel *> *)models{
    if (!models) {
        return NO;
    }
    
    [models removeAllObjects];

        for (NSInteger index = 0; index < self.numberOfComponents; index++) {
            NSInteger indexRow = [self.pickerView selectedRowInComponent:index];
            NSMutableArray<JRPickerModel *> *tmp = self.rows[index];
            if (tmp.count > 0) {
                [models addObject:tmp[indexRow]];
            }
        }
    return YES;
}


#pragma mark - lazy

-(UIPickerView *)pickerView{
    
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.accessoryView.bottom, PickerWidth, PickerContentHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
    }
    return _pickerView;
    
}

- (void)setTitle:(NSString *)title {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, AccessoryViewHeight)];
        [_titleLabel setCenterY:AccessoryViewHeight/2.0];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel setCenterX:PickerWidth/2.0];
        [_accessoryView addSubview:_titleLabel];
    }
    _titleLabel.text = title;
}

-(UIView *)accessoryView{
    if (_accessoryView == nil) {
        _accessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, AccessoryViewHeight)];
        _accessoryView.backgroundColor = [UIColor whiteColor];
        
        UIButton *confirm = [self buttonWithTitle:@"确定" textColor:UIColor.CommonYellowColor font:[UIFont systemFontOfSize:17.0]];
        [confirm addTarget:self action:@selector(confirmSelection) forControlEvents:UIControlEventTouchUpInside];
        [confirm setCenterY:AccessoryViewHeight/2.0];
        [confirm setRight:_accessoryView.width];
        [_accessoryView addSubview:confirm];
        
        UIButton *cancel = [self buttonWithTitle:@"取消" textColor:[UIColor textGrayColor] font:[UIFont systemFontOfSize:17.0]];
        [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [cancel setCenterY:AccessoryViewHeight/2.0];
        [_accessoryView addSubview:cancel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _accessoryView.width, 0.5)];
        line.backgroundColor = [UIColor lineColor];
        line.bottom = _accessoryView.height;
        [_accessoryView addSubview:line];
    }
    return _accessoryView;
}

-(UIView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [_backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _backgroundView.alpha = 0.0;
    }
    return _backgroundView;
}



-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

-(NSMutableArray<NSMutableArray<JRPickerModel *> *> *)rows{
    
    if (_rows == nil) {
        _rows = [[NSMutableArray alloc] init];
    }
    return _rows;
    
}

#pragma mark - HelperMethod
- (UIButton *)buttonWithTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setSize:CGSizeMake(AccessoryViewBtnWidth, AccessoryViewHeight)];
    return button;
}

@end
