//
//  JMActionSheetCollectionImageCell.m
//  Pods
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheetCollectionImageCell.h"
#import "JMActionSheetCollectionItem.h"

static const CGFloat JMActionSheetCollectionPadding = 0.0f;

@interface JMActionSheetCollectionImageCell ()

@property (weak, nonatomic) UIImageView *actionImageView;
@property (weak, nonatomic) id <UICollectionViewDelegate> collectionViewDelegate;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UITapGestureRecognizer *gesture;

@end


@implementation JMActionSheetCollectionImageCell

- (NSString *)reuseIdentifier
{
    return NSStringFromClass(self.class);
}

- (void)updateWithObject:(id)obj forIndexPath:(NSIndexPath *)indexPath andDelegate:(id <UICollectionViewDelegate>) delegate
{
    if (nil == self.actionImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = self.frame;
        frame.origin.y = 1.0f;
        frame.origin.x = JMActionSheetCollectionPadding;
        frame.size.height = CGRectGetHeight(self.frame);
        frame.size.width = CGRectGetWidth(self.frame) - 2 * JMActionSheetCollectionPadding;
        imageView.frame = frame;
        imageView.backgroundColor = [UIColor clearColor];
        self.actionImageView = imageView;
        [self.contentView addSubview:self.actionImageView];
    }
    
    if (nil == self.gesture) {
        self.gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTaped:)];
        [self addGestureRecognizer:self.gesture];
    }
    
    if ([obj isKindOfClass:[UIImage class]]) {
        self.actionImageView.image = obj;
    }
    
    self.indexPath = indexPath;
    self.collectionViewDelegate = delegate;
    self.backgroundColor = [UIColor clearColor];
}

- (void)cellTaped:(id)sender
{
    [self.collectionViewDelegate collectionView:nil didSelectItemAtIndexPath:self.indexPath];
}

@end
