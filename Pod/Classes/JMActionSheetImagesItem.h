//
//  JMActionSheetImagesItem.h
//  Pods
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheetItem.h"

typedef void (^JMActionSheetSelectedImageBlock)(UIImage *selectedImage);

@interface JMActionSheetImagesItem : JMActionSheetItem

@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) BOOL allowsMultipleSelection;
@property (copy, nonatomic) JMActionSheetSelectedImageBlock imagesActionBlock;

@end
