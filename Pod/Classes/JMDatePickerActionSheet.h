//
//  JMDatePickerActionSheet.h
//  Pods
//
//  Created by jerome morissard on 09/05/2016.
//
//

#import "JMActionSheet.h"
#import "JMActionSheetItem.h"

@interface JMDatePickerActionSheet : JMActionSheet

+ (void)showDatePickerActionSheetMinDate:(nullable NSDate *)minDate
                                 maxDate:(nullable NSDate *)maxDate
                            selectedDate:(nullable NSDate *)date
                             updateBlock:(nullable JMActionSheetSelectedItemBlock)didUpdateBlock
                           validateBlock:(nullable JMActionSheetSelectedItemBlock)didValidateBlock
                                   title:(nullable NSString *)title
                        inViewController:(nonnull UIViewController *)viewController;
@end
