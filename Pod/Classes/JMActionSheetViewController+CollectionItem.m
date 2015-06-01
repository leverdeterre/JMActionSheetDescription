//
//  JMActionSheetViewController+CollectionItem.m
//  Pods
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetViewController+CollectionItem.h"
#import "JMActionSheetCollectionItemCell.h"
#import <objc/runtime.h>

const char * const JMActionSheetCollectionDatasourceKey = "JMActionSheetCollectionDatasourceKey";
const char * const JMActionSheetCollectionViewBlockActionKey = "JMActionSheetCollectionViewBlockActionKey";

@implementation JMActionSheetViewController (CollectionItem)

- (void)setJm_CollectionViewElements:(NSArray *)jm_elements
{
    objc_setAssociatedObject(self, JMActionSheetCollectionDatasourceKey, jm_elements, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)jm_CollectionViewElements
{
    NSArray *elements = (NSArray *) objc_getAssociatedObject(self, JMActionSheetCollectionDatasourceKey);
    return elements;
}

- (void)setJm_collectionActionBlock:(JMActionSheetSelectedItemBlock)jm_collectionActionBlock
{
    objc_setAssociatedObject(self, JMActionSheetCollectionViewBlockActionKey, jm_collectionActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (JMActionSheetSelectedItemBlock)jm_getPickerActionBlock
{
    JMActionSheetSelectedItemBlock actionBlock = objc_getAssociatedObject(self, JMActionSheetCollectionViewBlockActionKey);
    return actionBlock;
}

#pragma mark - UICollectionViewDataSource

- (void)registerCellForcollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[JMActionSheetCollectionItemCell class] forCellWithReuseIdentifier:@"JMActionSheetCollectionItemCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self jm_CollectionViewElements].count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMActionSheetCollectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JMActionSheetCollectionItemCell" forIndexPath:indexPath];
    id obj = [[self jm_CollectionViewElements] objectAtIndex:indexPath.row];
    [cell updateWithObject:obj];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
