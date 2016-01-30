//
//  JMActionSheetPickerItem.m
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetPickerItem.h"

@implementation JMActionSheetPickerItem

- (void)setPickerElements :(NSArray<JMActionSheetPickerItemDisplayable> *)pickerElements
{
    //check data
    for (JMActionSheetPickerItem *item in pickerElements) {
        NSAssert([item conformsToProtocol:@protocol(JMActionSheetPickerItemDisplayable)], @"PickerItem must be conform to protocol JMActionSheetPickerItemDisplayable");
    }

    _pickerElements = pickerElements;
}

@end


@implementation NSString (JMActionSheetPickerItem)

- (NSString *)displayableValueForActionSheetPicker
{
    return self;
}

@end