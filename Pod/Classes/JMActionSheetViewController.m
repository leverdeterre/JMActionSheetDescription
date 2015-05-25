//
//  JMActionSheetViewController.m
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheetViewController.h"
#import "JMActionSheetDescription.h"
#import "JMActionSheetItem.h"
#import "JMActionSheetItemControl.h"
#import "JMActionSheet.h"

static const CGFloat JMActionSheetPadding               = 10.0f;
static const CGFloat JMActionSheetInterlineSpacing      = 1.0f;
static const CGFloat JMActionSheetButtonHeight          = 40.0f;
static const CGFloat JMActionSheetRoundedCornerRadius   = 6.0f;
static const CGFloat JMActionSheetImageViewHeight       = 80.0f;

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
@property (weak, nonatomic) id <JMActionSheetViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *actions;

//Appearance
@property (strong, nonatomic) UIColor *actionSheetTintColor;
@property (strong, nonatomic) UIFont *actionSheetCancelButtonFont;
@property (strong, nonatomic) UIFont *actionSheetOtherButtonFont;
@end

@implementation JMActionSheetViewController

- (void)reloadWithActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription
                             andDelegate:(id <JMActionSheetViewControllerDelegate>)delegate
{
    self.delegate = delegate;
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
    UIButton *button = (UIButton *)[self addViewForItem:actionSheetDescription.cancelItem forTag:tag frame:frame corners:UIRectCornerAllCorners offset:&yOffset];
    if (self.actionSheetCancelButtonFont) {
        button.titleLabel.font = self.actionSheetCancelButtonFont;
    }
    
    //Other buttons
    yOffset = yOffset - JMActionSheetPadding;
    
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

        if ([item isKindOfClass:[JMActionSheetItem class]]) {
            JMActionSheetItem *asItem = item;
            CGFloat y = yOffset - JMActionSheetButtonHeight;
            frame = CGRectMake(JMActionSheetPadding, y, width, JMActionSheetButtonHeight);
            [self addViewForItem:asItem forTag:tag frame:frame corners:corners offset:&yOffset];
            yOffset = yOffset - JMActionSheetInterlineSpacing;

        } else if ([item isKindOfClass:[NSString class]]) {
            CGFloat y = yOffset - JMActionSheetButtonHeight;
            frame = CGRectMake(JMActionSheetPadding, y, width, JMActionSheetButtonHeight);
            [self addViewForItem:item forTag:tag frame:frame corners:corners offset:&yOffset];
            yOffset = yOffset - JMActionSheetInterlineSpacing;

        }  else if ([item isKindOfClass:[JMActionSheetImageItem class]]) {
            JMActionSheetImageItem *imageItem = (JMActionSheetImageItem *)item;
            CGFloat imageHeight = JMActionSheetImageViewHeight;
            if (imageItem.imageHeight > 0.0f) { imageHeight = imageItem.imageHeight; }
            
            CGFloat y = yOffset - imageHeight;
            CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
            CGRect frame = CGRectMake(JMActionSheetPadding, y, width, imageHeight);
            [self addViewForItem:item forTag:tag frame:frame corners:corners offset:&yOffset];
            yOffset = yOffset - JMActionSheetInterlineSpacing;
        }
    }
}

#pragma mark - Actions

- (void)dimmingViewPressed:(id)sender
{
    [self.delegate dismissActionSheetViewController:self];
}

- (void)disablePressed:(id)button
{
}

- (void)buttonPressed:(id)button
{
    NSInteger tag = [button tag];
    JMActionSheetItemAction action = self.actions[tag];
    action();
    [self.delegate dismissActionSheetViewController:self];
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

#pragma mark - Constructors

- (UIView *)addViewForItem:(JMActionSheetItem *)item forTag:(NSInteger)tag frame:(CGRect)frame corners:(UIRectCorner)corners offset:(CGFloat *)yOffset
{
    if ([item isKindOfClass:[JMActionSheetItem class]]) {
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
        *yOffset = CGRectGetMinY(button.frame);
        return button;
        
    } else if ([item isKindOfClass:[NSString class]]) {
        UILabel *label = [self labelWithText:(NSString *)item];
        label.frame = frame;
        [label applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
        [self.view addSubview:label];
        [self.actions addObject:[NSNull null]];
        *yOffset = CGRectGetMinY(label.frame);
        return label;

    } else if ([item isKindOfClass:[JMActionSheetImageItem class]]) {
        JMActionSheetImageItem *imageitem = (JMActionSheetImageItem *)item;
        UIImageView *imageView = [self imageViewWithImage:imageitem.image];
        imageView.frame = frame;
        [imageView applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
        [self.view addSubview:imageView];
        [self.actions addObject:[NSNull null]];
        *yOffset = CGRectGetMinY(imageView.frame);
        return imageView;
    }
    
    return nil;
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

- (UIImageView *)imageViewWithImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    return imageView;
}


@end
