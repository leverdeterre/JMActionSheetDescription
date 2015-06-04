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
static const CGFloat JMActionSheetCollectionSelectSize = 25.0f;

@interface JMActionSheetCollectionImageCell ()

@property (strong, nonatomic) UIImageView *actionImageView;
@property (strong, nonatomic) UIImageView *selectionImageView;

@property (weak, nonatomic) id <UICollectionViewDelegate> collectionViewDelegate;
@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UITapGestureRecognizer *gesture;

@end


@implementation JMActionSheetCollectionImageCell


- (NSString *)reuseIdentifier
{
    return NSStringFromClass(self.class);
}

- (void)updateCollectionViewCellWithObject:(id)obj
                               atIndexPath:(NSIndexPath *)indexPath
                                  delegate:(id <UICollectionViewDelegate>)delegate
                            collectionView:(UICollectionView *)collectionView
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
    
    if (nil == self.selectionImageView) {
        UIImage *image;
        self.selectionImageView = [[UIImageView alloc] initWithImage:image];
        CGRect frame = self.frame;
        frame.size.height = JMActionSheetCollectionSelectSize;
        frame.size.width = JMActionSheetCollectionSelectSize;
        frame.origin.y = CGRectGetHeight(self.frame) - frame.size.height;
        frame.origin.x = CGRectGetWidth(self.frame) - frame.size.width;
        self.selectionImageView.frame = frame;
        [self.contentView addSubview:self.self.selectionImageView];
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
    self.collectionView = collectionView;
    self.backgroundColor = [UIColor clearColor];
    
    if (self.selected) {
        self.selectionImageView.image = [UIImage imageNamed:@"JMActionSheetDescription.bundle/JMPickerChecked.png"];
    } else {
        self.selectionImageView.image = nil;
    }
}

- (void)cellTaped:(id)sender
{
    if (self.selected) {
        [self.collectionView deselectItemAtIndexPath:self.indexPath animated:NO];

    } else {
        [self.collectionView selectItemAtIndexPath:self.indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.selectionImageView.image = [UIImage imageNamed:@"JMActionSheetDescription.bundle/JMPickerChecked.png"];
    
    } else {
        self.selectionImageView.image = nil;
    }
}

@end
