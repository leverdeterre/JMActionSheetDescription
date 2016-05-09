//
//  JMDatePickerActionSheet.h
//  Pods
//
//  Created by jerome morissard on 09/05/2016.
//
//

#import "JMActionSheet.h"

@interface JMDatePickerActionSheet : JMActionSheet

+ (void)showDatePickerActionSheetMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate selectedDate:(NSDate *)date didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController;

@end
