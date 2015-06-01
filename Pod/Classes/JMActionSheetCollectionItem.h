//
//  JMActionSheetCollectionItem.h
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetCollectionItem <NSObject>
@property (readonly) NSString *actionNameForActionSheetCollectionItem;

@optional
@property (readonly) UIImage *imageForActionSheetCollectionItem;
@property (readonly) NSString *imageNamedForActionSheetCollectionItem;

@end

@interface JMActionSheetCollectionItem : JMActionSheetItem

@property (strong, nonatomic) NSArray *elements; //Array of id <JMActionSheetCollectionItem>
@property (copy, nonatomic) JMActionSheetSelectedItemBlock collectionActionBlock;

@end
