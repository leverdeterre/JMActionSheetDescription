//
//  JMActionSheetCollectionItem.m
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetCollectionItem.h"

@implementation JMActionSheetCollectionItem

- (void)setElements:(NSArray *)elements
{
    //check data
    for (id <JMActionSheetCollectionItem> item in elements) {
        if (![item isKindOfClass:[NSString class]]) {
            NSAssert([item conformsToProtocol:@protocol(JMActionSheetCollectionItem)],
                     @"ActionSheetCollectionItem must be conform to protocol");
        }
    }
    
    _elements = elements;
}

@end
