//
//  JMActionSheetDatePickerItem.h
//  Pods
//
//  Created by jerome morissard on 09/05/2016.
//
//

#import "JMActionSheetItem.h"

@interface JMActionSheetDatePickerItem : JMActionSheetItem

@property (nullable, strong, nonatomic) NSDate *minDate;
@property (nullable, strong, nonatomic) NSDate *maxDate;
@property (nullable, nonatomic) NSDate *selectedDate;
@property (nullable, copy, nonatomic) JMActionSheetSelectedItemBlock pickerUpdateActionBlock;
@property (nullable, copy, nonatomic) JMActionSheetSelectedItemBlock pickerValidateActionBlock;
@property (assign, nonatomic) UIDatePickerMode datePickerMode;

@end
