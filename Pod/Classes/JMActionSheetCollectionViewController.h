//
//  JMActionSheetCollectionViewController.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import <UIKit/UIKit.h>
#import "JMActionSheetItem.h"
#import "JMActionSheetViewController.h"

@interface JMActionSheetCollectionViewController : UICollectionViewController

@property (strong, nonatomic) NSArray *collectionViewElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock collectionActionBlock;
@property (weak, nonatomic) id <JMActionSheetViewControllerDelegate> actionSheetDelegate;

- (instancetype)initWithElements:(NSArray *)elements
           collectionActionBlock:(JMActionSheetSelectedItemBlock)block
                  actionDelegate:(id <JMActionSheetViewControllerDelegate>)actionDelegate
                       cellClass:(Class)cellClass
                          layout:(UICollectionViewLayout *)layout;

@end
