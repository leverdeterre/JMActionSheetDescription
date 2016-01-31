//
//  JMActionSheetCollectionItemCell.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface JMActionSheetCollectionItemCell : UICollectionViewCell

- (void)updateCollectionViewCellWithObject:(id)obj
                               atIndexPath:(NSIndexPath *)indexPath
                                  delegate:(id <UICollectionViewDelegate>)delegate
                            collectionView:(UICollectionView *)collectionView;

@end
