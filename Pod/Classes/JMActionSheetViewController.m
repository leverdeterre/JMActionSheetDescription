//
//  JMActionSheetViewController.m
//  Pods
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetDescription.h"

#import "JMActionSheetItemControl.h"
#import "JMActionSheet.h"

#import "JMActionSheetViewController+PickerViewItem.h"
#import "JMActionSheetViewController+CollectionView.h"
//#import "UICollectionView+AutoDelegation.h"
#import "JMActionSheetCollectionItemCell.h"
#import "JMActionSheetCollectionImageCell.h"

static const CGFloat JMActionSheetPadding               = 10.0f;
static const CGFloat JMActionSheetInterlineSpacing      = 1.0f;
static const CGFloat JMActionSheetRoundedCornerRadius   = 6.0f;

static const CGFloat JMActionSheetButtonHeight          = 40.0f;
static const CGFloat JMActionSheetImageViewHeight       = 150.0f;
static const CGFloat JMActionSheetPickerViewHeight      = 216.0f;

static const CGFloat JMActionSheetCollectionViewHeight  = 90.0f;
static const CGFloat JMActionSheetCollectionViewWidth   = 60.0f;

#pragma mark - UIView+RoundCorners

@interface UIView (RoundedCorners)

- (void)applyRoundedCorners:(UIRectCorner)corners withRadius:(CGFloat)radius;

@end

@implementation UIView (RoundedCorners)

- (void)applyRoundedCorners:(UIRectCorner)corners withRadius:(CGFloat)radius
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end

@interface JMActionSheetViewController ()
@property (strong, nonatomic) NSMutableArray *actions;
@property (assign, nonatomic) CGSize preferredContentSize;

//Appearance
@property (strong, nonatomic) UIColor *actionSheetTintColor;
@property (strong, nonatomic) UIFont *actionSheetCancelButtonFont;
@property (strong, nonatomic) UIFont *actionSheetOtherButtonFont;
@end

@implementation JMActionSheetViewController
@synthesize preferredContentSize = _preferredContentSize;

- (void)reloadWithActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription
                             andDelegate:(id <JMActionSheetViewControllerDelegate>)delegate
{
    _delegate = delegate;
    self.actions = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewPressed:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.actionSheetTintColor = actionSheetDescription.actionSheetTintColor;
    self.actionSheetCancelButtonFont = actionSheetDescription.actionSheetCancelButtonFont;
    self.actionSheetOtherButtonFont = actionSheetDescription.actionSheetOtherButtonFont;

    //Load buttons
    //Cancel button
    NSInteger tag = 0;
    CGFloat yOffset = CGRectGetMaxY(self.view.bounds) - JMActionSheetButtonHeight - JMActionSheetPadding;
    CGFloat width = CGRectGetWidth(self.view.bounds) - 2 * JMActionSheetPadding;
    CGRect frame = CGRectMake(JMActionSheetPadding, yOffset, width, JMActionSheetButtonHeight);
    JMActionSheetItem *cancelItem = actionSheetDescription.cancelItem;
    if (nil == cancelItem) {
        cancelItem = [[JMActionSheetItem alloc] init];
        cancelItem.title = @"Cancel";
    }
    UIButton *button = (UIButton *)[self addViewForItem:cancelItem forTag:tag corners:UIRectCornerAllCorners offset:&yOffset];
    button.frame = frame;
    if (self.actionSheetCancelButtonFont) {
        button.titleLabel.font = self.actionSheetCancelButtonFont;
    }
    
    //Other buttons
    yOffset = CGRectGetMinY(button.frame) - JMActionSheetPadding;
    //[self logRect:button.frame forElemenetName:@"Cancel button"];
    
    NSMutableArray *items = [NSMutableArray arrayWithArray:actionSheetDescription.items];
    if (actionSheetDescription.title) {
        [items addObject:actionSheetDescription.title];
    }
    
    for (id item in items) {
        tag = tag + 1;
        UIRectCorner corners = 0;
        if ([item isEqual:items.lastObject]) {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
        if ([item isEqual:items.firstObject]) {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }

        //UIView *view =
        [self addViewForItem:item forTag:tag corners:corners offset:&yOffset];
        //[self logRect:view.frame forElemenetName:NSStringFromClass([item class])];
    }
}

#pragma mark - Actions

- (void)dimmingViewPressed:(id)sender
{
    [self.delegate dismissActionSheet];
}

- (void)buttonPressed:(id)button
{
    NSInteger tag = [button tag];
    JMActionSheetItemAction action = self.actions[tag];
    action();
    [self.delegate dismissActionSheet];
}

#pragma mark - Private
#pragma mark -

- (UIImage *)oneByOneImageWithColor:(UIColor *)color
{
    UIImage *img = nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark -
#pragma mark - Constructors

- (UIView *)addViewForItem:(JMActionSheetItem *)item forTag:(NSInteger)tag corners:(UIRectCorner)corners offset:(CGFloat *)yOffset
{
    UIView *view;
    if ([item isKindOfClass:[JMActionSheetCollectionItem class]]) {
        view = [self addCollectionViewForItem:(JMActionSheetCollectionItem *)item forTag:tag corners:corners offset:yOffset];
        
    } else if ([item isKindOfClass:[JMActionSheetPickerItem class]]) {
        view = [self addPickerViewForItem:(JMActionSheetPickerItem *)item forTag:tag corners:corners offset:yOffset];
        
    } else if ([item isKindOfClass:[JMActionSheetImagesItem class]]) {
        view = [self addCollectionViewForItem:(JMActionSheetCollectionItem *)item forTag:tag corners:corners offset:yOffset];
        
    } else if ([item isKindOfClass:[JMActionSheetImageItem class]]) {
        view = [self addImageViewForItem:(JMActionSheetImageItem *)item forTag:tag corners:corners offset:yOffset];
        
    } else if ([item isKindOfClass:[JMActionSheetItem class]]) {
        view = [self addButtonViewForItem:item forTag:tag corners:corners offset:yOffset];
        
    } else if ([item isKindOfClass:[NSString class]]) {
        view = [self addLabelViewForItem:item forTag:tag corners:corners offset:yOffset];
    }
    
    return view;
}

#pragma mark - Collection constructor

- (UIView *)addCollectionViewForItem:(JMActionSheetCollectionItem *)collectionItem
                              forTag:(NSInteger)tag
                             corners:(UIRectCorner)corners
                              offset:(CGFloat *)yOffset
{
    
    CGFloat collectionHeight = JMActionSheetCollectionViewHeight;
    CGSize itemSize = CGSizeMake(JMActionSheetCollectionViewWidth, JMActionSheetCollectionViewHeight);
    Class kClass = [JMActionSheetCollectionItemCell class];
    NSArray *elements;
    JMActionSheetSelectedItemBlock collectionActionBlock = NULL;
    
    if ([collectionItem isKindOfClass:[JMActionSheetImagesItem class]]) {
        JMActionSheetImagesItem *imagesItem = (JMActionSheetImagesItem *)collectionItem;
        collectionHeight = JMActionSheetImageViewHeight;
        if (imagesItem.imageSize.height > 0.0f) {
            collectionHeight = imagesItem.imageSize.height;
        }
        
        itemSize = imagesItem.imageSize;
        kClass = [JMActionSheetCollectionImageCell class];
        elements = imagesItem.images;

    } else {
        elements = collectionItem.elements;
        collectionActionBlock = collectionItem.collectionActionBlock;
    }
    
    //Compute frame
    CGFloat y = *yOffset - collectionHeight;
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
    CGRect containerFrame = CGRectMake(JMActionSheetPadding, y, width, collectionHeight);
    CGRect collectionFrame = CGRectMake(0.0f, 0.0f, width, collectionHeight);
    
    //Configure collectionView
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = itemSize;
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    JMActionSheetCollectionViewController *vc = [[JMActionSheetCollectionViewController alloc] initWithElements:elements collectionActionBlock:collectionActionBlock actionDelegate:self.delegate cellClass:kClass layout:flow];

    UICollectionView *collectionView = vc.collectionView;
     collectionView.frame = collectionFrame;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.frame = collectionFrame;
    //collectionView.contentInset = UIEdgeInsetsMake(0.0f, JMActionSheetPadding, 0.0f, JMActionSheetPadding);
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.userInteractionEnabled = YES;
    collectionView.alwaysBounceHorizontal = YES;
    
    UIView *containerView;
    containerView = [[UIView alloc] initWithFrame:containerFrame];
    containerView.backgroundColor = [UIColor whiteColor];
    collectionView.frame = collectionView.bounds;
    [containerView addSubview:collectionView];
    [containerView applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
    [self.view addSubview:containerView];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    
    //Load collectionView
    [collectionView reloadData];
    
    *yOffset = CGRectGetMinY(containerView.frame) - JMActionSheetInterlineSpacing;
    return collectionView;
}

#pragma mark - PickerView constructor

- (UIView *)addPickerViewForItem:(JMActionSheetPickerItem *)pickerItem
                          forTag:(NSInteger)tag
                         corners:(UIRectCorner)corners
                          offset:(CGFloat *)yOffset
{
    //Compute frame
    CGFloat pickerHeight = JMActionSheetPickerViewHeight;
    CGFloat y = *yOffset - pickerHeight;
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
    CGRect frame = CGRectMake(JMActionSheetPadding, y, width, pickerHeight);
    
    //Configure PickerView
    UIPickerView *pickerView = [self pickerViewWithElements:pickerItem.elements];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.frame = frame;
    [pickerView applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
    [self.view addSubview:pickerView];
    
    //Load PickerView
    [self setJm_pickerActionBlock:pickerItem.pickerActionBlock];
    *yOffset = CGRectGetMinY(pickerView.frame) - JMActionSheetInterlineSpacing;
    
    return pickerView;
}

- (UIPickerView *)pickerViewWithElements:(NSArray *)elements
{
    [self setJm_pickerElements:elements];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f,
                                                                              0.0f,
                                                                              CGRectGetWidth(self.view.frame),
                                                                              JMActionSheetPickerViewHeight)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [pickerView reloadAllComponents];
    return pickerView;
}

#pragma mark - ImageView constructor

- (UIView *)addImageViewForItem:(JMActionSheetImageItem *)imageItem
                          forTag:(NSInteger)tag
                         corners:(UIRectCorner)corners
                          offset:(CGFloat *)yOffset
{
    
    //Compute frame
    CGFloat imageHeight = JMActionSheetImageViewHeight;
    if (imageItem.imageHeight > 0.0f) { imageHeight = imageItem.imageHeight; }
    CGFloat y = *yOffset - imageHeight;
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
    CGRect frame = CGRectMake(JMActionSheetPadding, y, width, imageHeight);
    
    //Configure imageView
    UIImageView *imageView = [self imageViewWithImage:imageItem.image];
    imageView.frame = frame;
    [imageView applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
    [self.view addSubview:imageView];
    [self.actions addObject:[NSNull null]];
    
    *yOffset = CGRectGetMinY(imageView.frame) - JMActionSheetInterlineSpacing;
    return imageView;
}

- (UIImageView *)imageViewWithImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}

#pragma mark - Button constructor

- (UIView *)addButtonViewForItem:(JMActionSheetItem *)item
                         forTag:(NSInteger)tag
                        corners:(UIRectCorner)corners
                         offset:(CGFloat *)yOffset
{
    //Compute frame
    CGFloat y = *yOffset - JMActionSheetButtonHeight;
    CGRect frame = CGRectMake(JMActionSheetPadding,
                              y,
                              CGRectGetWidth(self.view.bounds) - 2 * JMActionSheetPadding,
                              JMActionSheetButtonHeight);
    
    //Configure button
    JMActionSheetItemControl *button = [self buttonWithActionSheetItem:item];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.frame = frame;
    button.tag = tag;
    [button applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
    JMActionSheetItemAction action = ^(void){
        if (item.action) {
            item.action();
        }
    };
    [self.view addSubview:button];
    [self.actions addObject:action];
    
    *yOffset = CGRectGetMinY(button.frame) - JMActionSheetInterlineSpacing;
    return button;
}

- (JMActionSheetItemControl *)buttonWithActionSheetItem:(JMActionSheetItem *)item
{
    UIColor *bckColor = [UIColor whiteColor];
    UIColor *textColor = [UIColor blackColor];
    
    if (item.backgroundColor) {
        bckColor = item.backgroundColor;
    }
    
    if (self.actionSheetTintColor) {
        textColor = self.actionSheetTintColor;
    }
    if (item.textColor) {
        textColor = item.textColor;
    }
    
    UIFont *font = [UIFont systemFontOfSize:18.0f];
    if (self.actionSheetOtherButtonFont) {
        font = self.actionSheetOtherButtonFont;
    }
    if (item.textFont) {
        font = item.textFont;
    }
    
    UIImage *backgroundImageSelected = [self oneByOneImageWithColor:[UIColor colorWithRed:216.0f/254.0f green:216.0f/254.0f blue:216.0f/254.0f alpha:1.0f]];
    UIImage *backgroundImageNormal = [self oneByOneImageWithColor:bckColor];
    
    JMActionSheetItemControl *otherButton = [[JMActionSheetItemControl alloc] init];
    [otherButton setTitle:item.title forState:UIControlStateNormal];
    [otherButton setTitleColor:textColor forState:UIControlStateNormal];
    
    [otherButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [otherButton setBackgroundImage:backgroundImageSelected forState:UIControlStateHighlighted];
    [otherButton setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
    
    if (item.icon) {
        [otherButton setImage:item.icon forState:UIControlStateNormal];
    }
    
    //Custom titleLabel
    otherButton.titleLabel.font = font;
    
    return otherButton;
}

#pragma mark - Label constructor

- (UIView *)addLabelViewForItem:(JMActionSheetItem *)item
                          forTag:(NSInteger)tag
                         corners:(UIRectCorner)corners
                          offset:(CGFloat *)yOffset
{
    //Compute frame
    CGFloat y = *yOffset - JMActionSheetButtonHeight;
    CGRect frame = CGRectMake(JMActionSheetPadding,
                              y,
                              CGRectGetWidth(self.view.bounds) - 2 * JMActionSheetPadding,
                              JMActionSheetButtonHeight);
    
    //Configure button
    UILabel *label = [self labelWithText:(NSString *)item];
    label.frame = frame;
    [label applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
    [self.view addSubview:label];
    [self.actions addObject:[NSNull null]];
    
    *yOffset = CGRectGetMinY(label.frame) - JMActionSheetInterlineSpacing;
    return label;
}

- (UILabel *)labelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    if (self.actionSheetTintColor) {
        [label setTextColor:self.actionSheetTintColor];
        
    } else {
        [label setTextColor:[UIColor blackColor]];
    }
    [label setText:text];
    [label setBackgroundColor:[UIColor whiteColor]];
    return label;
}

#pragma mark - ContentSize computation

- (CGSize)contentSizeForViewInPopover
{
    return _preferredContentSize;
}

- (CGSize)preferredContentSize
{
    return _preferredContentSize;
}

- (CGSize)estimatedContentSizeWithDescription:(JMActionSheetDescription *)actionSheetDescription
{
    NSInteger estimatedHeight = 0.0f;
    if (actionSheetDescription.cancelItem) {
        estimatedHeight = estimatedHeight +  JMActionSheetButtonHeight + JMActionSheetPadding;
    }
    
    if (actionSheetDescription.items.count) {
        for (id item in actionSheetDescription.items) {
            
            if ([item isKindOfClass:[JMActionSheetCollectionItem class]]) {
                estimatedHeight = estimatedHeight + JMActionSheetCollectionViewHeight + JMActionSheetInterlineSpacing;
                
            } else if ([item isKindOfClass:[JMActionSheetPickerItem class]]) {
                estimatedHeight = estimatedHeight + JMActionSheetPickerViewHeight + JMActionSheetInterlineSpacing;
            
            } else if ([item isKindOfClass:[JMActionSheetImageItem class]]) {
                JMActionSheetImageItem *imageItem = (JMActionSheetImageItem *)item;
                if (imageItem.imageHeight > 0.0f) {
                    estimatedHeight = estimatedHeight + imageItem.imageHeight+ JMActionSheetInterlineSpacing;
                    
                } else {
                    estimatedHeight = estimatedHeight + JMActionSheetImageViewHeight + JMActionSheetInterlineSpacing;
                }
                
            } else if ([item isKindOfClass:[JMActionSheetItem class]]) {
                estimatedHeight = estimatedHeight + JMActionSheetButtonHeight + JMActionSheetInterlineSpacing;
                
            }  else if ([item isKindOfClass:[NSString class]]) {
                estimatedHeight = estimatedHeight + JMActionSheetButtonHeight + JMActionSheetInterlineSpacing;
            }
        }
    }
    
    if (actionSheetDescription.title) {
        estimatedHeight = estimatedHeight + JMActionSheetButtonHeight;
    }
    
    estimatedHeight = estimatedHeight + 2 * JMActionSheetPadding;
    
    //NSLog(@"estimatedContentSizeWithDescription %@", NSStringFromCGSize(CGSizeMake(320.0f, estimatedHeight)));
    self.preferredContentSize = CGSizeMake(320.0f, estimatedHeight);
    return CGSizeMake(320.0f, estimatedHeight);
}

- (void)logRect:(CGRect)frame forElemenetName:(NSString *)name
{
    NSLog(@"%@ %@", name, NSStringFromCGRect(frame));
}

@end
