//
//  JMActionSheetImagesItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetImagesItemDisplayable <NSObject>

- (UIImage *)displayableImage;

@end

@interface JMActionSheetImagesItem : JMActionSheetItem

@property (nonnull, strong, nonatomic) NSArray <JMActionSheetImagesItemDisplayable> *images;
@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) BOOL allowsMultipleSelection;
@property (nonnull, copy, nonatomic) JMActionSheetSelectedItemBlock imagesActionBlock;

@end

@interface UIImage (JMActionSheetImagesItem) <JMActionSheetImagesItemDisplayable>
@end
