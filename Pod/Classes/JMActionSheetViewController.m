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
@property (strong, nonatomic) NSArray *actions;
@end

@implementation JMActionSheetViewController

- (void)reloadWithActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription
                             andDelegate:(id <JMActionSheetViewControllerDelegate>)delegate
{
    self.delegate = delegate;
    self.view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewPressed:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //Load subViews
    NSMutableArray *actions = [[NSMutableArray alloc] init];

    //Cancel button
    NSInteger tag = 0;
    JMActionSheetItemControl *cancelButton = [self buttonWithActionSheetItem:actionSheetDescription.cancelItem withDescription:(JMActionSheetDescription *)actionSheetDescription];
    if (actionSheetDescription.actionSheetCancelButtonFont) {
        cancelButton.titleLabel.font = actionSheetDescription.actionSheetCancelButtonFont;
    }

    CGFloat yOffset = CGRectGetMaxY(self.view.bounds) - JMActionSheetButtonHeight - JMActionSheetPadding;
    CGFloat width = CGRectGetWidth(self.view.bounds) - 2 * JMActionSheetPadding;
    cancelButton.frame = CGRectMake(JMActionSheetPadding, yOffset, width, JMActionSheetButtonHeight);
    [cancelButton applyRoundedCorners:UIRectCornerAllCorners withRadius:JMActionSheetRoundedCornerRadius];
    JMActionSheetItemAction action = ^(void){
        if (actionSheetDescription.cancelItem.action) {
            actionSheetDescription.cancelItem.action();
        }
    };
    [self.view addSubview:cancelButton];
    [actions addObject:action];
    
    //Other buttons
    yOffset = CGRectGetMinY(cancelButton.frame);
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
            UIButton *otherButton = [self buttonWithActionSheetItem:item withDescription:actionSheetDescription];
            if (actionSheetDescription.actionSheetOtherButtonFont) {
                otherButton.titleLabel.font = actionSheetDescription.actionSheetOtherButtonFont;
            }
            CGFloat y = yOffset - JMActionSheetButtonHeight;
            CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
            otherButton.frame = CGRectMake(JMActionSheetPadding, y, width, JMActionSheetButtonHeight);
            [otherButton applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
            [otherButton setTag:tag];
            [self.view addSubview:otherButton];
            
            JMActionSheetItemAction action = ^(void){
                if (asItem.action) {
                    asItem.action();
                }
            };
            [actions addObject:action];
            yOffset = CGRectGetMinY(otherButton.frame) - JMActionSheetInterlineSpacing;
            
        } else if ([item isKindOfClass:[NSString class]]) {
            UILabel *label = [self labelWithText:item withDescription:actionSheetDescription];
            CGFloat y = yOffset - JMActionSheetButtonHeight;
            label.frame = CGRectMake(JMActionSheetPadding, y, width, JMActionSheetButtonHeight);
            [label applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
            [self.view addSubview:label];
            yOffset = CGRectGetMinY(label.frame) - JMActionSheetInterlineSpacing;
            
        }  else if ([item isKindOfClass:[JMActionSheetImageItem class]]) {
            JMActionSheetImageItem *imageItem = (JMActionSheetImageItem *)item;
            CGFloat imageHeight = JMActionSheetImageViewHeight;
            if (imageItem.imageHeight > 0.0f) {
                imageHeight = imageItem.imageHeight;
            }
            
            CGFloat y = yOffset - imageHeight;
            CGFloat width = CGRectGetWidth(self.view.frame) - 2 * JMActionSheetPadding;
            UIImageView *imageView = [self imageViewWithImage:imageItem.image];
            CGRect frame = CGRectMake(JMActionSheetPadding, y, width, imageHeight);
            imageView.frame = frame;
            [imageView applyRoundedCorners:corners withRadius:JMActionSheetRoundedCornerRadius];
            [self.view addSubview:imageView];
            yOffset = CGRectGetMinY(imageView.frame) - JMActionSheetInterlineSpacing;
        }
    }
    
    self.actions = actions;
}

#pragma mark - Actions

- (void)dimmingViewPressed:(id)sender
{
    [self.delegate dismissActionSheetViewController:self];
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

#pragma mark - SubViews generators

- (JMActionSheetItemControl *)buttonWithActionSheetItem:(JMActionSheetItem *)item withDescription:(JMActionSheetDescription *)actionSheetDescription
{
    UIImage *backgroundImageSelected = [self oneByOneImageWithColor:[UIColor colorWithRed:216.0f/254.0f green:216.0f/254.0f blue:216.0f/254.0f alpha:1.0f]];
    UIImage *backgroundImageNormal = [self oneByOneImageWithColor:[UIColor whiteColor]];

    JMActionSheetItemControl *otherButton = [JMActionSheetItemControl buttonWithType:UIButtonTypeCustom];
    [otherButton setTitle:item.title forState:UIControlStateNormal];
    if (actionSheetDescription.actionSheetTintColor) {
        [otherButton setTitleColor:actionSheetDescription.actionSheetTintColor forState:UIControlStateNormal];
        
    } else {
        [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [otherButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [otherButton setBackgroundImage:backgroundImageSelected forState:UIControlStateHighlighted];
    [otherButton setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
    if (item.icon) {
        [otherButton setImage:item.icon forState:UIControlStateNormal];
    }
    
    return otherButton;
}

- (UILabel *)labelWithText:(NSString *)text withDescription:(JMActionSheetDescription *)actionSheetDescription
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    if (actionSheetDescription.actionSheetTintColor) {
        [label setTextColor:actionSheetDescription.actionSheetTintColor];
        
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
