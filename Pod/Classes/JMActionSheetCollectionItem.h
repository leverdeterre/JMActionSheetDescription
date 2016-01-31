//
//  JMActionSheetCollectionItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetCollectionItem <NSObject>

@property (strong, nonatomic) UIImage *actionImage;
@property (strong, nonatomic) NSString *actionName;

@optional
@property (assign, nonatomic) UIViewContentMode actionImageContentMode;
@end

typedef void (^JMActionSheetSelectedCollectionItemBlock)(id selectedItem);

@interface JMActionSheetCollectionItem : JMActionSheetItem

@property (strong, nonatomic) NSArray <JMActionSheetCollectionItem> *elements;
@property (copy, nonatomic) JMActionSheetSelectedCollectionItemBlock collectionActionBlock;

@end
