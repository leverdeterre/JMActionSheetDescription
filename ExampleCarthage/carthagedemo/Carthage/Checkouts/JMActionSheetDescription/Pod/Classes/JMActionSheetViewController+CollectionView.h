//
//  JMActionSheetViewController+CollectionView.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetCollectionViewController.h"

@interface JMActionSheetViewController (CollectionView)

+ (JMActionSheetCollectionViewController *)actionSheetViewControllerWithElements:(NSArray *)elements collectionActionBlock:(JMActionSheetSelectedItemBlock)block actionDelegate:(id <JMActionSheetViewControllerDelegate>)actionDelegate cellClass:(Class)cellClass layout:(UICollectionViewLayout *)layout;

@end
