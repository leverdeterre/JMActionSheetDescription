//
//  JMActionSheetCollectionItem.m
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetCollectionItem.h"

@implementation JMActionSheetCollectionItem

- (void)setElements:(NSArray <JMActionSheetCollectionItem> *)elements
{
    //check data
    for (id <JMActionSheetCollectionItem> item in elements) {
        NSAssert([item conformsToProtocol:@protocol(JMActionSheetCollectionItem)],
                     @"ActionSheetCollectionItem must be conform to protocol");
    }
    
    _elements = elements;
}

@end
