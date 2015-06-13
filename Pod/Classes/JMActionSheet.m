//
//  JMActionSheet.m
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheet.h"
#import "JMActionSheetViewController.h"
#import "JMActionSheetDescription.h"

#import "JMActionSheetViewController+PickerViewItem.h"

static JMActionSheet *actionSheet_;
static JMActionSheetViewController *actionSheetViewController_;
static UIPopoverController *actionSheetViewPopover_;
static UIPopoverPresentationController *presentationController_;
static UIView *dimmingView_;

static const CGFloat JMActionSheetDefaultWidth = 320.0f;
static const CGFloat JMActionSheetDefaultHeight = 50.0f;

@interface JMActionSheet () <JMActionSheetViewControllerDelegate, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate>
@end

@implementation JMActionSheet

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController
{
    [self showActionSheetDescription:actionSheetDescription inViewController:viewController fromView:nil];
}

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController fromView:(UIView *)view
{
    [self showActionSheetDescription:actionSheetDescription inViewController:viewController fromView:view permittedArrowDirections:UIPopoverArrowDirectionAny];
}

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController fromView:(UIView *)fromView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    actionSheet_ = [[JMActionSheet alloc] init];
    actionSheetViewController_ = [[JMActionSheetViewController alloc] init];
    
    //Configure dimmingView
    dimmingView_ = [[UIView alloc] initWithFrame:viewController.view.frame];
    dimmingView_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.20];
    [viewController.view addSubview:dimmingView_];
    
    //Configure actionSheetViewController
    [actionSheet_ configureFramePresentationFromViewController:viewController description:actionSheetDescription];
    
    //present actionSheet
    [actionSheet_ presentActionSheetFromViewController:viewController fromView:fromView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections];
}

#pragma mark - Presentation / dismiss  

- (void)configureFramePresentationFromViewController:(UIViewController *)viewController description:(JMActionSheetDescription *)actionSheetDescription
{
    CGRect actionSheetFrame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        actionSheetFrame = viewController.view.frame;
        actionSheetFrame.origin.y = CGRectGetMaxY(viewController.view.frame);

    } else if ([viewController respondsToSelector:@selector(traitCollection)]) {
            UITraitCollection *traitCollection = viewController.traitCollection;
            if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
                actionSheetFrame = viewController.view.frame;
                actionSheetFrame = CGRectMake(0.0f, 0.0f, JMActionSheetDefaultWidth, JMActionSheetDefaultHeight);
                actionSheetFrame.origin.y = CGRectGetMaxY(viewController.view.frame);
                actionSheetFrame.size = [actionSheetViewController_ estimatedContentSizeWithDescription:actionSheetDescription width:JMActionSheetDefaultWidth];
                
            } else {
                actionSheetFrame = viewController.view.frame;
                actionSheetFrame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(viewController.view.frame), JMActionSheetDefaultHeight);
                actionSheetFrame.origin.y = CGRectGetMaxY(viewController.view.frame);
                actionSheetFrame.size = [actionSheetViewController_ estimatedContentSizeWithDescription:actionSheetDescription width:CGRectGetWidth(viewController.view.frame)];
                CGSize size = actionSheetFrame.size;
                size.height = CGRectGetHeight(viewController.view.frame);
                actionSheetFrame.size = size;
            }
    }
    else {
        actionSheetFrame = CGRectMake(0.0f, 0.0f, JMActionSheetDefaultWidth, JMActionSheetDefaultHeight);
        actionSheetFrame.origin.y = CGRectGetMaxY(viewController.view.frame);
        actionSheetFrame.size = [actionSheetViewController_ estimatedContentSizeWithDescription:actionSheetDescription width:JMActionSheetDefaultWidth];
    }
    
    actionSheetViewController_.view.frame = actionSheetFrame;
    [actionSheetViewController_ reloadWithActionSheetDescription:actionSheetDescription andDelegate:actionSheet_];
}

- (void)presentActionSheetFromViewController:(UIViewController *)viewController fromView:(UIView *)fromView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    BOOL presentHasIPhone = NO;
    if ([viewController respondsToSelector:@selector(traitCollection)]) {
        UITraitCollection *traitCollection = viewController.traitCollection;
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            presentHasIPhone = YES;
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone || presentHasIPhone) {
        //Childs
        [viewController addChildViewController:actionSheetViewController_];
        [viewController.view addSubview:actionSheetViewController_.view];
        [actionSheetViewController_ didMoveToParentViewController:viewController];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect finalFrame = actionSheetViewController_.view.frame;
            finalFrame.origin.y = 0.0f;
            actionSheetViewController_.view.frame = finalFrame;
        } completion:NULL];
        
    } else if ([UIPopoverPresentationController class]) {
        actionSheetViewController_.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popoverCtr = actionSheetViewController_.popoverPresentationController;
        popoverCtr.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popoverCtr.sourceView = viewController.view;
        popoverCtr.sourceRect = fromView.frame;
        popoverCtr.delegate = actionSheet_;
        [viewController presentViewController:actionSheetViewController_
                                     animated:YES
                                   completion:NULL];
        
    } else {
        actionSheetViewPopover_ = [[UIPopoverController alloc] initWithContentViewController:actionSheetViewController_];
        actionSheetViewPopover_.delegate = actionSheet_;
        [actionSheetViewPopover_ presentPopoverFromRect:fromView.frame inView:viewController.view permittedArrowDirections:arrowDirections animated:YES];
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [dimmingView_ removeFromSuperview];
    actionSheetViewPopover_ = nil;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    [dimmingView_ removeFromSuperview];
    actionSheetViewPopover_ = nil;
}

#pragma mark - JMActionSheetViewControllerDelegate

- (void)dismissActionSheet
{
    if (actionSheetViewPopover_) {
        [actionSheetViewPopover_ dismissPopoverAnimated:YES];
        actionSheetViewPopover_ = nil;
        [dimmingView_ removeFromSuperview];
        
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            dimmingView_.alpha = 0.0f;
            actionSheetViewController_.view.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [dimmingView_ removeFromSuperview];
            [actionSheetViewController_ removeFromParentViewController];
            [actionSheetViewController_.view removeFromSuperview];
        }];
    }
}

- (void)actionSheetDidSelectPickerView:(UIPickerView *)pickerView element:(id)element block:(JMActionSheetSelectedItemBlock)block
{
    if (block) {
        block(element);
    }
    
    [self dismissActionSheet];
}

- (void)actionSheetDidSelectCollectionView:(UICollectionView *)collectionView element:(id)element block:(JMActionSheetSelectedItemBlock)block
{
    if (block) {
        block(element);
    }
    
    [self dismissActionSheet];
}

- (void)actionSheetDidSelectCollectionView:(UICollectionView *)collectionView element:(id)element block:(JMActionSheetSelectedItemBlock)block dismissEnable:(BOOL)dismissEnable
{
    if (block) {
        block(element);
    }
    
    if (dismissEnable) {
        [self dismissActionSheet];
    }
}

@end
