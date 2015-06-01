//
//  JMActionSheetViewController+CollectionItem.h
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetCollectionItem.h"

@interface JMActionSheetViewController (CollectionItem) <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *jm_CollectionViewElements;
@property (copy, nonatomic) JMActionSheetSelectedItemBlock jm_collectionActionBlock;

- (void)registerCellForcollectionView:(UICollectionView *)collectionView;

@end
