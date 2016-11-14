//
//  JMActionSheetCollectionItemCell.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 01/06/2015.
//
//

#import "JMActionSheetCollectionItemCell.h"
#import "JMActionSheetCollectionItem.h"

static const CGFloat JMActionSheetCollectionPadding = 0.0f;
static const CGFloat JMActionSheetCollectionTopSpacing = 10.0f;
static const CGFloat JMActionSheetCollectionImageHeight = 60.0f;
static const CGFloat JMActionSheetCollectionLabelHeight = 21.0f;

@interface JMActionSheetCollectionItemCell ()

@property (weak, nonatomic) UIImageView *actionImageView;
@property (weak, nonatomic) UILabel *actionLabel;
@property (weak, nonatomic) id <UICollectionViewDelegate> collectionViewDelegate;
@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UITapGestureRecognizer *gesture;

@end

@implementation JMActionSheetCollectionItemCell

- (NSString *)reuseIdentifier
{
    return NSStringFromClass(self.class);
}

- (void)updateCollectionViewCellWithObject:(id)obj
                               atIndexPath:(NSIndexPath *)indexPath
                                  delegate:(id <UICollectionViewDelegate>)delegate
                            collectionView:(UICollectionView *)collectionView
{
    id <JMActionSheetCollectionItem> conformedObject;
    if ([obj conformsToProtocol:@protocol(JMActionSheetCollectionItem)]){
        conformedObject = (id <JMActionSheetCollectionItem>)obj;
    }
    
    if (nil == self.actionImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
        CGRect frame = self.frame;
        frame.origin.y = JMActionSheetCollectionTopSpacing;
        frame.origin.x = JMActionSheetCollectionPadding;
        frame.size.height = JMActionSheetCollectionImageHeight;
        frame.size.width = CGRectGetWidth(self.frame) - 2 * JMActionSheetCollectionPadding;
        imageView.frame = frame;
        imageView.backgroundColor = [UIColor clearColor];
        self.actionImageView = imageView;
        [self.contentView addSubview:self.actionImageView];
        imageView.layer.cornerRadius = 10.0f;
        imageView.clipsToBounds = YES;
    }
    
    if (nil == self.actionLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10.0f];
        CGRect frame = self.frame;
        frame.origin.y = CGRectGetMaxY(self.actionImageView.frame);
        frame.origin.x = JMActionSheetCollectionPadding;
        frame.size.height = JMActionSheetCollectionLabelHeight;
        frame.size.width = CGRectGetWidth(self.frame) - 2 * JMActionSheetCollectionPadding;
        label.frame = frame;
        label.backgroundColor = [UIColor clearColor];
        self.actionLabel = label;
        [self.contentView addSubview:self.actionLabel];
    }
    
    if (nil == self.gesture) {
        self.gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTaped:)];
        [self addGestureRecognizer:self.gesture];
    }
    
    if (conformedObject) {
        self.actionImageView.image = [conformedObject actionImage];
        self.actionLabel.text = [conformedObject actionName];
    }
    
    if ([conformedObject respondsToSelector:@selector(actionImageContentMode)]) {
        self.actionImageView.contentMode = [conformedObject actionImageContentMode];
    }
    
    self.indexPath = indexPath;
    self.collectionViewDelegate = delegate;
    self.backgroundColor = [UIColor clearColor];
}

- (void)cellTaped:(id)sender
{
    [self.collectionView selectItemAtIndexPath:self.indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self.collectionViewDelegate collectionView:self.collectionView didSelectItemAtIndexPath:self.indexPath];
}

@end
