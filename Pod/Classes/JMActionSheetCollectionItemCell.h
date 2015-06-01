//
//  JMActionSheetCollectionItemCell.h
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import <UIKit/UIKit.h>

@interface JMActionSheetCollectionItemCell : UICollectionViewCell

- (void)updateWithObject:(id)obj forIndexPath:(NSIndexPath *)indexPath andDelegate:(id <UICollectionViewDelegate>) delegate;

@end
