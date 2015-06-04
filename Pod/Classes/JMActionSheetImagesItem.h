//
//  JMActionSheetImagesItem.h
//  Pods
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheetItem.h"

@interface JMActionSheetImagesItem : JMActionSheetItem

@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) BOOL allowsMultipleSelection;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock imagesActionBlock;

@end
