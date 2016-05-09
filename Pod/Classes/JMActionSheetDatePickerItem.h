//
//  JMActionSheetDatePickerItem.h
//  Pods
//
//  Created by jerome morissard on 09/05/2016.
//
//

#import "JMActionSheetItem.h"

@interface JMActionSheetDatePickerItem : JMActionSheetItem

@property (strong, nonatomic) NSDate *minDate;
@property (strong, nonatomic) NSDate *maxDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock pickerActionBlock;
@property (assign, nonatomic) UIDatePickerMode datePickerMode;

@end
