//
//  ESCell.m
//  sdfyy
//
//  Created by yh on 15/2/10.
//  Copyright (c) 2015年 eeesys. All rights reserved.
//

#import "ESCell.h"
#import "ESCellFrame.h"
#import "ESItem.h"
#import "ESLabelItem.h"
#import "ESFieldItem.h"
#import "ESDateItem.h"
#import "ESPickerItem.h"
#import "ESAccessoryView.h"

@interface ESCell () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

/**
 *  标题
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  子标题（普通文本）
 */
@property (nonatomic, weak) UILabel *subtitleLabel;

/**
 *  子标题（输入框）
 */
@property (nonatomic, weak) UITextField *textField;

/**
 *  子标题（下拉选择）
 */
@property (nonatomic, weak) UITextField *selectField;

/**
 *  子标题（日期选择）
 */
@property (nonatomic, weak) UITextField *dateField;

/**
 *  箭头视图
 */
@property (nonatomic, strong) UIImageView *arrowView;

/**
 *  日期选择
 */
@property (nonatomic, strong) UIDatePicker *datePicker;

/**
 *  日期选择工具条
 */
@property (nonatomic, strong) ESAccessoryView *dateToolbar;

/**
 *  选择框
 */
@property (nonatomic, strong) UIPickerView *pickerView;

/**
 *  选择框工具条
 */
@property (nonatomic, strong) ESAccessoryView *pickerToolBar;

/**
 *  记录UIPickerView中component的选中索引
 *  0 第一个component索引
 *  1 第二个component索引
 *  n 第n个component索引
 */
@property (nonatomic, strong) NSMutableArray *pickerIndexs;

/**
 *  根据item中的code是否在数据源中找到相同的code
 */
@property (nonatomic, assign) BOOL find;

@end

@implementation ESCell

#pragma mark - getters
/**
 *  component的选中索引
 */
- (NSMutableArray *)pickerIndexs
{
    if (!_pickerIndexs)
    {
        _pickerIndexs = [NSMutableArray array];
        for (int i = 0; i < 10; i++)
        {
            _pickerIndexs[i] = @0;
        }
    }
    return _pickerIndexs;
}

/**
 *  日期选择工具条
 */
- (ESAccessoryView *)dateToolbar
{
    if (!_dateToolbar)
    {
        _dateToolbar = [ESAccessoryView accessoryViewWithTarget:self action:@selector(dateClick:)];
    }
    return _dateToolbar;
}

/**
 *  日期选择
 */
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, 0, 0)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.backgroundColor = [UIColor whiteColor];
    }
    return _datePicker;
}

/**
 *  选择框工具条
 */
- (ESAccessoryView *)pickerToolBar
{
    if (!_pickerToolBar)
    {
        _pickerToolBar = [ESAccessoryView accessoryViewWithTarget:self action:@selector(buttonClick:)];
    }
    return _pickerToolBar;
}

/**
 *  选择框
 */
- (UIPickerView *)pickerView
{
    if (!_pickerView)
    {
        _pickerView= [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

/**
 *  获取标题
 */
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        // 创建
        UILabel *titleLabel = [UILabel yhlabel];
        // 添加到cell中
        [self.contentView addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

/**
 *  获取子标题(普通文本)
 */
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel)
    {
        // 创建
        UILabel *subtitleLabel = [UILabel yhlabel];
        // 添加到cell中
        [self.contentView addSubview:subtitleLabel];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel = subtitleLabel;
    }
    return _subtitleLabel;
}

/**
 *  获取子标题（输入框）
 */
- (UITextField *)textField
{
    if (!_textField)
    {
        // 创建
        UITextField *textField = [[UITextField alloc] init];
        // 添加到cell中
        [self.contentView addSubview:textField];
        // 清除按钮
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        // 设置代理
        textField.delegate = self;
        // 返回按钮类型
        textField.returnKeyType = UIReturnKeyDone;
        // 监听文字改变
        [textField addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingChanged];
        _textField = textField;
    }
    return _textField;
}

/**
 *  获取子标题（下拉选择）
 */
- (UITextField *)selectField
{
    if (!_selectField)
    {
        // 创建
        UITextField *selectField = [[UITextField alloc] init];
        _selectField = selectField;
        // 添加到cell中
        [self.contentView addSubview:selectField];
        // 设置代理
        selectField.delegate = self;
        selectField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _selectField;
}

/**
 *  获取子标题（日期选择）
 */
- (UITextField *)dateField
{
    if (!_dateField)
    {
        // 创建
        UITextField *dateField = [[UITextField alloc] init];
        _dateField = dateField;
        // 添加到cell中
        [self.contentView addSubview:dateField];
        // 设置代理
        dateField.delegate = self;
        dateField.clearButtonMode = UITextFieldViewModeNever;
    }
    return _dateField;
}

/**
 *  获取arrowView
 */
- (UIImageView *)arrowView
{
    if (!_arrowView)
    {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        _arrowView = arrowView;
    }
    return _arrowView;
}

#pragma mark - init
/**
 *  创建cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

#pragma mark - public
/**
 *  cell中的输入框成为第一响应者
 */
- (void)becomeFirst
{
    ESItem *item = self.cellFrame.item;
    
    // 子标题
    if ([item isKindOfClass:[ESFieldItem class]]) // 输入框
    {
        [self.textField becomeFirstResponder];
    }
    else if([item isKindOfClass:[ESDateItem class]]) // 日期选择
    {
        [self.dateField becomeFirstResponder];
    }
    else if([item isKindOfClass:[ESPickerItem class]]) // 选择框
    {
        [self.selectField becomeFirstResponder];
    }
}

/**
 *  设置cellFrame
 */
- (void)setCellFrame:(ESCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    ESItem *item = cellFrame.item;
    
    // 标题
    self.titleLabel.text = item.title;
    self.titleLabel.frame = cellFrame.titleFrame;
    self.titleLabel.textColor = item.titleColor;
    self.titleLabel.font = item.titleFont;
    
    // 子标题
    if ([item isKindOfClass:[ESLabelItem class]]) // 普通文本
    {
        [self labelWithCellFrame:cellFrame];
    }
    else if ([item isKindOfClass:[ESFieldItem class]]) // 输入框
    {
        [self fieldWithCellFrame:cellFrame];
    }
    else if([item isKindOfClass:[ESDateItem class]]) // 日期选择
    {
        [self dateWithCellFrame:cellFrame];
    }
    else if([item isKindOfClass:[ESPickerItem class]]) // 选择框
    {
        [self selecetWithCellFrame:cellFrame];
    }
}

#pragma mark - 私有方法
/**
 *  文本框文字改变
 */
- (void)change:(UITextField *)textField
{
    // 设置模型中的subtitle值
    self.cellFrame.item.subtitle = textField.text;
    
    if ([self.cellFrame.item isKindOfClass:[ESFieldItem class]]) // 输入框
    {
        ESFieldItem *fieldItem = (ESFieldItem *)self.cellFrame.item;
        // 如果有回调
        if (fieldItem.operationValueChange)
        {
            fieldItem.operationValueChange(self.cellFrame.item.subtitle);
        }
    }
}

/**
 *  设置普通文本item
 */
- (void)labelWithCellFrame:(ESCellFrame *)cellFrame
{
    ESItem *item = cellFrame.item;
    self.subtitleLabel.text = item.subtitle;
    self.subtitleLabel.frame = cellFrame.subtitleFrame;
    self.subtitleLabel.textColor = item.subtitleColor;
    self.subtitleLabel.font = item.subtitleFont;
    // 控件是否可见
    self.subtitleLabel.hidden = NO;
    self.textField.hidden = YES;
    self.selectField.hidden = YES;
    self.dateField.hidden = YES;
    self.accessoryView = nil;
}

/**
 *  设置输入框item
 */
- (void)fieldWithCellFrame:(ESCellFrame *)cellFrame
{
    ESItem *item = cellFrame.item;
    ESFieldItem *fieldItem = (ESFieldItem *)item;
    self.textField.text = item.subtitle;
    self.textField.frame = cellFrame.subtitleFrame;
    self.textField.textColor = item.subtitleColor;
    self.textField.font = item.subtitleFont;
    self.textField.placeholder = fieldItem.placeholder;
    self.textField.keyboardType = fieldItem.keyboardType;
    // 是否密码框
    self.textField.secureTextEntry = fieldItem.secure;
    self.textField.clearsOnInsertion = fieldItem.secure;
    // 控件是否可见
    self.subtitleLabel.hidden = YES;
    self.textField.hidden = NO;
    self.selectField.hidden = YES;
    self.dateField.hidden = YES;
    self.accessoryView = nil;
    self.textField.enabled = (fieldItem.enabled != 0);
}

/**
 *  设置选择框item
 */
- (void)selecetWithCellFrame:(ESCellFrame *)cellFrame
{
    ESItem *item = cellFrame.item;
    self.selectField.text = item.subtitle;
    self.selectField.frame = cellFrame.subtitleFrame;
    self.selectField.textColor = item.subtitleColor;
    self.selectField.font = item.subtitleFont;
    // 控件是否可见
    self.subtitleLabel.hidden = YES;
    self.textField.hidden = YES;
    self.selectField.hidden = NO;
    self.dateField.hidden = YES;
    self.accessoryView = self.arrowView;
    [self setType:cellFrame];
}

/**
 *  设置日期选择item
 */
- (void)dateWithCellFrame:(ESCellFrame *)cellFrame
{
    ESItem *item = cellFrame.item;
    self.dateField.text = item.subtitle;
    self.dateField.frame = cellFrame.subtitleFrame;
    self.dateField.textColor = item.subtitleColor;
    self.dateField.font = item.subtitleFont;
    // 控件是否可见
    self.subtitleLabel.hidden = YES;
    self.textField.hidden = YES;
    self.selectField.hidden = YES;
    self.dateField.hidden = NO;
    self.accessoryView = self.arrowView;
    [self setType:cellFrame];
}

/**
 *  设置输入框inputView类型
 */
- (void)setType:(ESCellFrame *)cellFrame
{
    ESItem *item = cellFrame.item;
    if ([item isKindOfClass:[ESDateItem class]]) // 日期选择
    {
        [self.dateToolbar setTitle:item.title];
        self.dateField.inputView = self.datePicker;
        self.dateField.inputAccessoryView = self.dateToolbar;
        // 设置时间范围
        ESDateItem *dateItem = (ESDateItem *)item;
        self.datePicker.minimumDate = dateItem.minimumDate;
        self.datePicker.maximumDate = dateItem.maximumDate;
    }
    else if ([item isKindOfClass:[ESPickerItem class]]) // 下拉选择
    {
        [self.pickerToolBar setTitle:item.title];
        self.selectField.inputView = self.pickerView;
        self.selectField.inputAccessoryView = self.pickerToolBar;
    }
}

#pragma mark - 文本框代理
/**
 *  点击了return按钮(键盘最右下角的按钮)就会调用
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 结束编辑
    [self endEditing:YES];
    
    return YES;
}

/**
 *  开始编辑
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.cellFrame.item isKindOfClass:[ESDateItem class]]) // 日期选择
    {
        ESDateItem *dateItem = (ESDateItem *)self.cellFrame.item;
        if (![NSDate yhdateWithString:self.cellFrame.item.subtitle format:dateItem.format]) return;
        self.datePicker.date = [NSDate yhdateWithString:self.cellFrame.item.subtitle format:dateItem.format];
    }
    else if ([self.cellFrame.item isKindOfClass:[ESPickerItem class]]) // 下拉选择
    {
        [self.pickerView reloadAllComponents];
        self.find = NO; // 重置状态
        ESPickerItem *item = (ESPickerItem *)self.cellFrame.item;
        NSArray *sources = item.source;
        NSInteger component = 0;
        [self recursionWithArray:sources item:item component:component];
    }
    else if ([self.cellFrame.item isKindOfClass:[ESFieldItem class]]) // 输入框
    {
        ESFieldItem *fieldItem = (ESFieldItem *)self.cellFrame.item;
        // 如果有回调
        if (fieldItem.operationStart)
        {
            fieldItem.operationStart(self.cellFrame.item.subtitle);
        }
    }
}

/**
 *  结束编辑
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // 只有输入框才执行回调
    if (![self.cellFrame.item isKindOfClass:[ESFieldItem class]]) return;
    // 如果有回调
    if (self.cellFrame.item.operation)
    {
        self.cellFrame.item.operation(self.cellFrame.item.subtitle);
    }
}

#pragma mark - 私有方法
/**
 *  日期选择工具条按钮点击
 */
- (void)dateClick:(UIButton *)button
{
    // 结束编辑
    [self endEditing:YES];
    if([button.titleLabel.text isEqualToString:@"取消"]) return;
    
    ESDateItem *dateItem = (ESDateItem *)self.cellFrame.item;
    // 1. 当前日期控件文字
    NSString *text = [NSDate yhstringWithDate:self.datePicker.date format:dateItem.format];
    
    // 2. 改变模型数据
    self.cellFrame.item.subtitle = text;
    
    // 3. 通知代理
    [self performDelegate];
}

/**
 *  选择框工具条点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 结束编辑
    [self endEditing:YES];
    if([button.titleLabel.text isEqualToString:@"取消"]) return;
    
    // 1. 取出模型数据
    ESPickerItem *dateItem = (ESPickerItem *)self.cellFrame.item;
    NSArray *sources = dateItem.source;
    
    // 2. 根据选中索引计算文字和code
    NSInteger component = [self numberOfComponentsInPickerView:self.pickerView];
    ESPickerSource *source = nil;
    NSString *last = @""; // 上一次循环的文字
    NSString *subtitle = @""; // 这次确认按钮点击后的子标题文字
    for (int i = 0; i < component; i++)
    {
        NSInteger index = [self.pickerIndexs[i] integerValue];
        source = sources[index];
        sources = source.subs;
        if (i == (component - 1)) // 设置模型数据code值
        {
            dateItem.code = source.code;
        }
        
        if (![last isEqualToString:source.name]) // 和上一次相同则不追加文字
        {
            subtitle = [NSString stringWithFormat:@"%@ %@", subtitle, source.name];
        }
        last = source.name;
    }
    
    // 3. 设置新的子标题
    dateItem.subtitle = subtitle.trim;
    
    // 4. 通知代理
    [self performDelegate];
}

/**
 *  通知代理
 */
- (void)performDelegate
{
    // 执行回调operation
    if (self.cellFrame.item.operation)
    {
        self.cellFrame.item.operation(self.cellFrame.item.subtitle);
    }
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(cellWillReload:)])
    {
        [self.delegate cellWillReload:self];
    }
}

/**
 *  根据当前component获取上一个component中选中行的ESPickerSource
 */
- (ESPickerSource *)sourceWithComponent:(NSInteger)component
{
    ESPickerItem *item = (ESPickerItem *)self.cellFrame.item;
    NSArray *sources = item.source;
    
    // 当前component的上一个component中选中的ESPickerSource
    ESPickerSource *source = nil;
    for (int i = 0; i < component; i++)
    {
        // 选中的索引
        if (!self.pickerIndexs.count) return 0;
        NSInteger index = [self.pickerIndexs[i] integerValue];
        source = sources[index];
        sources = source.subs;
    }
    return source;
}

/**
 *  设置选择框初始选中
 */
- (void)recursionWithArray:(NSArray *)array item:(ESItem *)item component:(NSInteger)component
{
    component++;
    for (int j = 0; j < array.count; j++)
    {
        ESPickerSource *source = array[j];
        if (!self.find)
        {
            [self.pickerView reloadComponent:component-1];
            self.pickerIndexs[component-1] = @(j);
            [self.pickerView selectRow:j inComponent:component-1 animated:NO];
        }
        
        if ((!source.subs) & [source.code isEqualToString:item.code]) // 下一层没有了且已经找到了
        {
            self.find = YES;
        }
        else // 递归下一层
        {
            [self recursionWithArray:source.subs item:item component:component];
        }
    }
}

#pragma mark - UIPickerViewDataSource
/**
 *  多少组
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    ESPickerItem *item = (ESPickerItem *)self.cellFrame.item;
    ESPickerSource *first = item.source[0];
    NSInteger num = 0;
    for (; first; num++)
    {
        first = first.subs[0];
    }
    return num;
}

/**
 *  多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    ESPickerItem *item = (ESPickerItem *)self.cellFrame.item;
    NSArray *sources = item.source;
    
    if (!component) return sources.count;
    
    // 当前component的上一个component中选中的ESPickerSource
    ESPickerSource *source = [self sourceWithComponent:component];
    
    return source.subs.count;
}

/**
 *  每一行内容
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    ESPickerItem *item = (ESPickerItem *)self.cellFrame.item;
    NSArray *sources = item.source;
    if (!component) // 第1个component
    {
        ESPickerSource *source = sources[row];
        return source.name;
    }
    
    // 当前component的上一个component中选中的ESPickerSource
    ESPickerSource *source = [self sourceWithComponent:component];
    NSArray *subs = source.subs;
    if (!subs.count) return @"";
    ESPickerSource *subRow = subs[row];
    return subRow.name;
}

#pragma mark - UIPickerViewDelegate
/**
 *  点击某一行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 一共有多少component
    NSInteger number = [self numberOfComponentsInPickerView:pickerView];
    // 当前component选中的索引
    self.pickerIndexs[component] = @(row);
    // 当前component后面的component
    for (NSInteger i = component; i < (number-1); i++)
    {
        // 下一个component选中的索引
        self.pickerIndexs[i + 1] = @0;
        // 刷新
        [pickerView reloadComponent:i+1];
        // 选中下一个component第一个
        [pickerView selectRow:0 inComponent:i+1 animated:YES];
    }
}

@end