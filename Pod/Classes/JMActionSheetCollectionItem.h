//
//  JMActionSheetCollectionItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetItem.h"

@protocol JMActionSheetCollectionItem <NSObject>

@property (nonnull, strong, nonatomic) UIImage *actionImage;
@property (nonnull,strong, nonatomic) NSString *actionName;

@optional
@property (assign, nonatomic) UIViewContentMode actionImageContentMode;
@end

typedef void (^JMActionSheetSelectedCollectionItemBlock)(id selectedItem);

@interface JMActionSheetCollectionItem : JMActionSheetItem

@property (nonnull,strong, nonatomic) NSArray <JMActionSheetCollectionItem> *elements;
@property (nonnull,copy, nonatomic) JMActionSheetSelectedCollectionItemBlock collectionActionBlock;

@end
