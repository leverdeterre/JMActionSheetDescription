//
//  JMActionSheetViewController+CollectionView.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import "JMActionSheetViewController+CollectionView.h"

@implementation JMActionSheetViewController (CollectionView)

+ (JMActionSheetCollectionViewController *)actionSheetViewControllerWithElements:(NSArray *)elements collectionActionBlock:(JMActionSheetSelectedItemBlock)block actionDelegate:(id <JMActionSheetViewControllerDelegate>)actionDelegate cellClass:(Class)cellClass layout:(UICollectionViewLayout *)layout
{
    JMActionSheetCollectionViewController *vc = [[JMActionSheetCollectionViewController alloc] initWithElements:elements collectionActionBlock:block actionDelegate:actionDelegate cellClass:cellClass layout:layout];
    return vc;
}

@end
