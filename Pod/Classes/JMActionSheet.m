//
//  JMActionSheet.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheet.h"
#import "JMActionSheetViewController.h"
#import "JMActionSheetCollectionViewController.h"
#import "JMActionSheetDescription.h"
#import "UIView+JMActionSheet.h"

#import "JMActionSheetViewController+PickerViewItem.h"

static JMActionSheet *actionSheet_;
static JMActionSheetViewController *actionSheetViewController_;
static UIPopoverController *actionSheetViewPopover_;
static UIPopoverPresentationController *presentationController_;
static UIView *dimmingView_;

static const CGFloat JMActionSheetDefaultWidth = 320.0f;
static const CGFloat JMActionSheetDefaultHeight = 50.0f;

typedef NS_ENUM(NSUInteger, JMActionSheetOSStragey) {
    JMActionSheetManualPresentation,
    JMActionSheetModalPopover,
    JMActionSheetPopoverController
};

static JMActionSheetOSStragey actionSheetStrategy_;

@interface JMActionSheet () <JMActionSheetViewControllerDelegate, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) JMActionSheetDescription *presentedDescription;
@end

@implementation JMActionSheet

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController
{
    [self showActionSheetDescription:actionSheetDescription inViewController:viewController fromView:viewController.view];
}

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController fromView:(UIView *)view
{
    [self showActionSheetDescription:actionSheetDescription inViewController:viewController fromView:view permittedArrowDirections:UIPopoverArrowDirectionAny];
}

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController fromView:(UIView *)fromView permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    actionSheet_ = [[JMActionSheet alloc] init];
    actionSheetViewController_ = [[JMActionSheetViewController alloc] init];
    actionSheet_.presentedDescription = actionSheetDescription;
    
    //Configure dimmingView
    dimmingView_ = [[UIView alloc] initWithFrame:viewController.view.bounds];
    dimmingView_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.20];
    [dimmingView_ setTranslatesAutoresizingMaskIntoConstraints:NO];
    [viewController.view jm_addSubview:dimmingView_ withEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    //compute stragey
    [self computeStrategyFromViewController:viewController];
    
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
    if (actionSheetStrategy_ == JMActionSheetManualPresentation) {
        //Childs
        [viewController addChildViewController:actionSheetViewController_];
        [viewController.view addSubview:actionSheetViewController_.view];
        [actionSheetViewController_ didMoveToParentViewController:viewController];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect finalFrame = actionSheetViewController_.view.frame;
            finalFrame.origin.y = 0.0f;
            actionSheetViewController_.view.frame = finalFrame;
        } completion:NULL];
        
    } else if (actionSheetStrategy_ == JMActionSheetModalPopover) {
        actionSheetViewController_.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popoverCtr = actionSheetViewController_.popoverPresentationController;
        popoverCtr.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popoverCtr.sourceView = viewController.view;
        popoverCtr.sourceRect = fromView.frame;
        popoverCtr.delegate = actionSheet_;
        [viewController presentViewController:actionSheetViewController_
                                     animated:YES
                                    completion:^{
                                        NSLog(@"");
                                    }];
        
    } else {
        actionSheetViewPopover_ = [[UIPopoverController alloc] initWithContentViewController:actionSheetViewController_];
        actionSheetViewPopover_.delegate = actionSheet_;
        [actionSheetViewPopover_ presentPopoverFromRect:fromView.frame inView:viewController.view permittedArrowDirections:arrowDirections animated:YES];
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self dismissActionSheet];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    [self dismissActionSheet];
}

#pragma mark - JMActionSheetViewControllerDelegate

- (void)actionSheetWillRotate
{
    NSLog(@"");
    [UIView animateWithDuration:0.25
                     animations:^{
                         [dimmingView_.superview layoutIfNeeded];
                     }];
}

- (void)dismissActionSheet
{
    if (actionSheetStrategy_ == JMActionSheetPopoverController) {
        [actionSheetViewPopover_ dismissPopoverAnimated:NO];
        [self removingHierarchies];
        
    } else if (actionSheetStrategy_ == JMActionSheetModalPopover) {
        [actionSheetViewController_ dismissViewControllerAnimated:NO completion:NULL];
        [self removingHierarchies];

    } else {
        [UIView animateWithDuration:0.3 animations:^{
            dimmingView_.alpha = 0.0f;
            actionSheetViewController_.view.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [self removingHierarchies];
        }];
    }
}

- (void)actionSheetDidSelectPickerView:(UIPickerView *)pickerView element:(id)element block:(JMActionSheetSelectedItemBlock)block
{
    [self actionSheetDidSelectPickerView:pickerView element:element block:block cancelAutoDismiss:NO];
}

- (void)actionSheetDidSelectPickerView:(UIPickerView *)pickerView element:(id)element block:(JMActionSheetSelectedItemBlock)block cancelAutoDismiss:(BOOL)cancelAutoDismiss
{
    if (block) {
        block(element);
    }
    
    if (NO == cancelAutoDismiss) {
        [self dismissActionSheet];
    }
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


#pragma mark - Private

- (void)removingHierarchies
{
    [dimmingView_ removeFromSuperview];
    
    //Fix collectionView bad call of delegate by system
    [actionSheetViewController_.childViewControllers enumerateObjectsUsingBlock:
     ^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
         [vc removeFromParentViewController];
     }];
    [actionSheetViewController_ removeFromParentViewController];
    [actionSheetViewController_.view removeFromSuperview];
}

+ (void)computeStrategyFromViewController:(UIViewController *)viewController
{
    BOOL presentHasIPhone = NO;
    if ([viewController respondsToSelector:@selector(traitCollection)]) {
        UITraitCollection *traitCollection = viewController.traitCollection;
        if (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
            presentHasIPhone = YES;
        }
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone || presentHasIPhone) {
        actionSheetStrategy_ = JMActionSheetManualPresentation;
        
    } else if ([UIPopoverPresentationController class]) {
        actionSheetStrategy_ = JMActionSheetModalPopover;

    } else {
        actionSheetStrategy_ = JMActionSheetPopoverController;
    }
}

@end
