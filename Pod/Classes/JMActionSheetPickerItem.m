//
//  JMActionSheetPickerItem.m
//  Pods
//
//  Created by jerome morissard on 30/05/2015.
//
//

#import "JMActionSheetPickerItem.h"

@implementation JMActionSheetPickerItem

- (void)setElements:(NSArray *)elements
{
    //check data
    for (id <JMActionSheetPickerItem> item in elements) {
        if (![item isKindOfClass:[NSString class]]) {
            NSAssert([item conformsToProtocol:@protocol(JMActionSheetPickerItem)], @"ActionSheetPickerItem must be conform to protocol");
        }
    }
    
    _elements = elements;
}

@end
