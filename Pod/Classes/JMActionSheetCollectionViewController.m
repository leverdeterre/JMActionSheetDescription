//
//  JMActionSheetCollectionViewController.m
//  Pods
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import "JMActionSheetCollectionViewController.h"
#import "JMActionSheetCollectionItemCell.h"

@interface JMActionSheetCollectionViewController ()
@property (strong, nonatomic) NSString *reuseIdentifier;
@property (strong, nonatomic) UICollectionViewLayout *jmCollectionLayout;
@end

@implementation JMActionSheetCollectionViewController

- (instancetype)initWithElements:(NSArray *)elements collectionActionBlock:(JMActionSheetSelectedItemBlock)block actionDelegate:(id <JMActionSheetViewControllerDelegate>)actionDelegate cellClass:(Class)cellClass layout:(UICollectionViewLayout *)layout
{
    JMActionSheetCollectionViewController *vc = [[JMActionSheetCollectionViewController alloc] initWithCollectionViewLayout:layout];
    vc.reuseIdentifier = NSStringFromClass(cellClass);
    vc.collectionViewElements = elements;
    vc.collectionActionBlock = block;
    vc.actionSheetDelegate = actionDelegate;
    vc.jmCollectionLayout = layout;
    return vc;
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.collectionViewLayout = self.jmCollectionLayout;
    
    // Register cell classes
    [self.collectionView registerClass:NSClassFromString(self.reuseIdentifier) forCellWithReuseIdentifier:self.reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionViewElements.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMActionSheetCollectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    
    id obj = [self.collectionViewElements objectAtIndex:indexPath.row];
    [cell updateWithObject:obj forIndexPath:indexPath andDelegate:self];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id obj = [self.collectionViewElements objectAtIndex:indexPath.row];
    [self.actionSheetDelegate actionSheetDidSelectCollectionView:collectionView element:obj block:self.collectionActionBlock];
}

@end
