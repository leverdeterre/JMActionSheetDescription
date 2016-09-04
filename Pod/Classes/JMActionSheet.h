//
//  JMActionSheet.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JMActionSheetDescription.h"

#import "JMActionSheetItem.h"
#import "JMActionSheetImageItem.h"
#import "JMActionSheetImagesItem.h"
#import "JMActionSheetPickerItem.h"
#import "JMActionSheetCollectionItem.h"

@interface JMActionSheet : NSObject

/**
 *  Present a actionSheet like controller, generated using your description.
 *
 *  @param actionSheetDescription a description
 *  @param viewController         the parent view controller
 */
+ (void)showActionSheetDescription:(nonnull JMActionSheetDescription *)actionSheetDescription inViewController:(nonnull UIViewController *)viewController;

/**
 *  Present a actionSheet like controller, generated using your description and inside a particular view
 *
 *  @param actionSheetDescription a description
 *  @param viewController         the parent view controller
 *  @param view                   the parent view in hierarchy
 */
+ (void)showActionSheetDescription:(nonnull JMActionSheetDescription *)actionSheetDescription inViewController:(nonnull UIViewController *)viewController fromView:(UIView *)view;

/**
 *  Present a actionSheet like controller, generated using your description and inside a particular view and with arrow directions constraint.
 *
 *  @param actionSheetDescription a description
 *  @param viewController         the parent view controller
 *  @param view                   the parent view in hierarchy
 *  @param arrowDirections        arrows bitmasked values
 */
+ (void)showActionSheetDescription:(nonnull JMActionSheetDescription *)actionSheetDescription inViewController:(nonnull UIViewController *)viewController fromView:(nonnull UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

@end
