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

+ (void)showDatePickerActionSheetMinDate:(NSDate *)minDate
                                 maxDate:(NSDate *)maxDate
                            selectedDate:(NSDate *)date
                             updateBlock:(JMActionSheetSelectedItemBlock)didUpdateBlock
                           validateBlock:(JMActionSheetSelectedItemBlock)didValidateBlock
                                   title:(NSString *)title
                        inViewController:(UIViewController *)viewController
{
    JMActionSheetDescription *desc = [self datePickerDescriptionMinDate:minDate
                                                                maxDate:maxDate
                                                           selectedDate:date
                                                      updateBlock:didUpdateBlock
                                                          validateBlock:didValidateBlock
                                                                  title:title];
    [JMDatePickerActionSheet showActionSheetDescription:desc inViewController:viewController];
}

+ (JMActionSheetDescription *)datePickerDescriptionMinDate:(NSDate *)minDate
                                                   maxDate:(NSDate *)maxDate
                                              selectedDate:(NSDate *)date
                                            updateBlock:(JMActionSheetSelectedItemBlock)didUpdateBlock
                                            validateBlock:(JMActionSheetSelectedItemBlock)didValidateBlock
                                                     title:(NSString *)title
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.title = title;
    
    JMActionSheetDatePickerItem *pickerItem = [[JMActionSheetDatePickerItem alloc] init];
    pickerItem.minDate = minDate;
    pickerItem.maxDate = maxDate;
    pickerItem.selectedDate = date;
    pickerItem.pickerUpdateActionBlock = ^(id selectedDate) {
        if (didUpdateBlock) {
            didUpdateBlock(selectedDate);
            pickerItem.selectedDate = selectedDate;
        }
    };
    pickerItem.pickerValidateActionBlock = didValidateBlock;
    
    JMActionSheetItem *validateItem = [JMActionSheetItem new];
    validateItem.title = @"Validate";
    validateItem.action = ^(){
        //NSLog(@"Validate pressed");
        if (didValidateBlock) {
            didValidateBlock(pickerItem.selectedDate);
        }
    };
    
    desc.items = @[pickerItem];
    desc.cancelItem = validateItem;
    return desc;
}

@end
