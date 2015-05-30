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

static UIView *dimmingView_;

@interface JMActionSheet () <JMActionSheetViewControllerDelegate, UIPopoverControllerDelegate>
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

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    actionSheet_ = [[JMActionSheet alloc] init];
    actionSheetViewController_ = [[JMActionSheetViewController alloc] init];
    
    //Configure dimmingView
    dimmingView_ = [[UIView alloc] initWithFrame:viewController.view.frame];
    dimmingView_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.20];
    [viewController.view addSubview:dimmingView_];
    
    //Configure actionSheetViewController
    
    CGRect originalFrame = viewController.view.frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        originalFrame = CGRectMake(0.0f, 0.0f, 320.0f, 50.0f);
        originalFrame.size = [actionSheetViewController_ estimatedContentSizeWithDescription:actionSheetDescription];
        
    } else {
        CGFloat original = CGRectGetMaxY(viewController.view.frame);
        originalFrame.origin.y = original;
    }
    
    actionSheetViewController_.view.frame = originalFrame;
    [actionSheetViewController_ reloadWithActionSheetDescription:actionSheetDescription andDelegate:actionSheet_];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        actionSheetViewPopover_ = [[UIPopoverController alloc] initWithContentViewController:actionSheetViewController_];
        actionSheetViewPopover_.delegate = actionSheet_;
        [actionSheetViewPopover_ presentPopoverFromRect:view.frame inView:viewController.view permittedArrowDirections:arrowDirections animated:YES];
        
    } else {
        //Childs
        [viewController addChildViewController:actionSheetViewController_];
        [viewController.view addSubview:actionSheetViewController_.view];
        [actionSheetViewController_ didMoveToParentViewController:viewController];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect finalFrame = originalFrame;
            finalFrame.origin.y = 0.0f;
            actionSheetViewController_.view.frame = finalFrame;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [dimmingView_ removeFromSuperview];
    actionSheetViewPopover_ = nil;
}

#pragma mark - JMActionSheetViewControllerDelegate

- (void)dismissActionSheetViewController:(JMActionSheetViewController *)vc
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

- (void)actionSheetViewController:(JMActionSheetViewController *)vc didSelectPickerViewValue:(NSString *)selectedValue
{
    JMActionSheetPickerItemAction itemActionBlock = [vc jm_getPickerActionBlock];
    if (itemActionBlock) {
        itemActionBlock(selectedValue);
    }
    
    [self dismissActionSheetViewController:vc];
}

@end
