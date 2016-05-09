//
//  JMActionSheetViewController+PickerViewItem.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetViewController+PickerViewItem.h"
#import <objc/runtime.h>

const char * const JMActionSheetPickerDatasourceKey = "JMActionSheetPickerDatasourceKey";
const char * const JMActionSheetPickerBlockActionKey = "JMActionSheetPickerBlockActionKey";

@implementation JMActionSheetViewController (PickerViewItem)

- (void)setJm_pickerElements:(NSArray *)jm_elements
{
    objc_setAssociatedObject(self, JMActionSheetPickerDatasourceKey, jm_elements, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)jm_pickerElements
{
    NSArray *elements = (NSArray *) objc_getAssociatedObject(self, JMActionSheetPickerDatasourceKey);
    return elements;
}

- (void)setJm_pickerActionBlock:(JMActionSheetSelectedItemBlock)jm_pickerActionBlock
{
    objc_setAssociatedObject(self, JMActionSheetPickerBlockActionKey, jm_pickerActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JMActionSheetSelectedItemBlock)jm_pickerActionBlock
{
    JMActionSheetSelectedItemBlock actionBlock = objc_getAssociatedObject(self, JMActionSheetPickerBlockActionKey);
    return actionBlock;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self jm_pickerElements].count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id obj = [[self jm_pickerElements] objectAtIndex:row];
    return obj;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    id obj = [[self jm_pickerElements] objectAtIndex:row];
    [self.delegate actionSheetDidSelectPickerView:pickerView element:obj block:[self jm_pickerActionBlock]];
}

#pragma mark - DatePicker Delegate

- (void)datePickerValueDidChange:(UIDatePicker *)datePicker
{
    id obj = datePicker.date;
    [self.delegate actionSheetDidSelectPickerView:(UIPickerView *)datePicker element:obj block:[self jm_pickerActionBlock]];
}

@end
