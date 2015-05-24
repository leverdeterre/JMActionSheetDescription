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

static JMActionSheet *actionSheet_;
static JMActionSheetViewController *actionSheetViewController_;
static UIView *dimmingView_;

@interface JMActionSheet () <JMActionSheetViewControllerDelegate>
@end

@implementation JMActionSheet

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController
{
    actionSheet_ = [[JMActionSheet alloc] init];
    actionSheetViewController_ = [[JMActionSheetViewController alloc] init];

    //Configure dimmingView
    dimmingView_ = [[UIView alloc] initWithFrame:viewController.view.frame];
    dimmingView_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.20];
    [viewController.view addSubview:dimmingView_];

    //Configure actionSheetViewController
    CGFloat original = CGRectGetMaxY(viewController.view.frame);
    CGRect originalFrame = viewController.view.frame;
    originalFrame.origin.y = original;
    actionSheetViewController_.view.frame = originalFrame;
    [actionSheetViewController_ reloadWithActionSheetDescription:actionSheetDescription andDelegate:actionSheet_];
    
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

- (void)dismissActionSheetViewController:(JMActionSheetViewController *)vc
{
    [UIView animateWithDuration:0.3 animations:^{
        dimmingView_.alpha = 0.0f;
        actionSheetViewController_.view.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [dimmingView_ removeFromSuperview];
        [actionSheetViewController_ removeFromParentViewController];
        [actionSheetViewController_.view removeFromSuperview];
    }];
}

@end
