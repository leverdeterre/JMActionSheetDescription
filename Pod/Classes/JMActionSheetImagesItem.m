//
//  JMActionSheetImagesItem.m
//  Pods
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheetImagesItem.h"

@implementation JMActionSheetImagesItem

- (void)setPickerElements:(NSArray<JMActionSheetImagesItemDisplayable> *)elements
{
    //check data
    for (id item in elements) {
        NSAssert([item conformsToProtocol:@protocol(JMActionSheetImagesItemDisplayable)], @"JMActionSheetImageItem must be conform to protocol JMActionSheetPickerItemDisplayable");
    }
    
    _images = elements;
}

@end

@implementation UIImage (JMActionSheetImagesItem)

- (UIImage *)displayableImage
{
    return self;
}

@end