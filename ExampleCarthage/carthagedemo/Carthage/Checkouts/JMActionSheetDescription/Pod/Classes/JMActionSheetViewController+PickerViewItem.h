//
//  JMActionSheetViewController+PickerViewItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetPickerItem.h"

@interface JMActionSheetViewController (PickerViewItem) <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *jm_pickerElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock jm_pickerActionBlock;

//DatePicker delegation
- (void)datePickerValueDidChange:(UIDatePicker *)datePicker;

@end
