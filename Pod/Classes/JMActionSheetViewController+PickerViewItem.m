//
//  JMActionSheetViewController+PickerViewItem.m
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetViewController+PickerViewItem.h"
#import <objc/runtime.h>

const char * const JMActionSheetPickerDatasourceKey = "JMActionSheetPickerDatasourceKey";
const char * const JMActionSheetPickerBlockActionKey = "JMActionSheetPickerBlockActionKey";

@implementation JMActionSheetViewController (PickerViewItem)

- (void)jm_setPickerViewElements:(NSArray *)elements
{
    objc_setAssociatedObject(self, JMActionSheetPickerDatasourceKey, elements, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)jm_getPickerViewElements
{
    NSArray *elements = (NSArray *) objc_getAssociatedObject(self, JMActionSheetPickerDatasourceKey);
    return elements;
}

- (void)jm_setPickerActionBlock:(JMActionSheetPickerItemAction)actionBlock
{
    objc_setAssociatedObject(self, JMActionSheetPickerBlockActionKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JMActionSheetPickerItemAction)jm_getPickerActionBlock
{
    JMActionSheetPickerItemAction actionBlock = (JMActionSheetPickerItemAction) objc_getAssociatedObject(self, JMActionSheetPickerBlockActionKey);
    return actionBlock;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self jm_getPickerViewElements].count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id obj = [[self jm_getPickerViewElements] objectAtIndex:row];
    return obj;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    id obj = [[self jm_getPickerViewElements] objectAtIndex:row];
    [self.delegate actionSheetViewController:self didSelectPickerViewValue:obj];
}

@end
