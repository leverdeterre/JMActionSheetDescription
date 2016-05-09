//
//  JMDatePickerActionSheet.m
//  Pods
//
//  Created by jerome morissard on 09/05/2016.
//
//

#import "JMDatePickerActionSheet.h"
#import "JMActionSheetDatePickerItem.h"

@implementation JMDatePickerActionSheet

+ (void)showDatePickerActionSheetMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectedDate:(NSDate *)date didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController
{
    JMActionSheetDescription *desc = [self datePickerDescriptionMinDate:minDate
                                                                maxDate:maxDate
                                                           selectedDate:date
                                                         didSelectBlock:didSelectBlock
                                                                  title:title];
    [JMDatePickerActionSheet showActionSheetDescription:desc inViewController:viewController];
}

+ (JMActionSheetDescription *)datePickerDescriptionMinDate:(NSDate *)minDate
                                                   maxDate:(NSDate *)maxDate
                                              selectedDate:(NSDate *)date
                                            didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock
                                                     title:(NSString *)title
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.title = title;
    
    JMActionSheetDatePickerItem *pickerItem = [[JMActionSheetDatePickerItem alloc] init];
    pickerItem.minDate = minDate;
    pickerItem.maxDate = maxDate;
    pickerItem.selectedDate = date;
    pickerItem.pickerActionBlock = didSelectBlock;
    desc.items = @[pickerItem];
    return desc;
}

@end
