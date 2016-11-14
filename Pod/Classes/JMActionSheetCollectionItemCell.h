//
//  JMActionSheetCollectionItemCell.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface JMActionSheetCollectionItemCell : UICollectionViewCell

- (void)updateCollectionViewCellWithObject:(nonnull id)obj
                               atIndexPath:(nonnull NSIndexPath *)indexPath
                                  delegate:(nullable id <UICollectionViewDelegate>)delegate
                            collectionView:(nonnull UICollectionView *)collectionView;

@end
