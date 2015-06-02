//
//  UICollectionView+AutoDelegation.h
//  Pods
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import <UIKit/UIKit.h>

#import "JMActionSheetItem.h"
#import "JMActionSheetViewController.h"

@interface UICollectionView (AutoDelegation) <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *jm_CollectionViewElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock jm_collectionActionBlock;
@property (weak, nonatomic) id <JMActionSheetViewControllerDelegate> jm_actionSheetDelegate;

- (void)jm_registerCollectionViewCellClass:(Class)kclass;

@end
