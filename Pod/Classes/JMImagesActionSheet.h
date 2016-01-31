//
//  JMImagesActionSheet.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import "JMActionSheet.h"

@interface JMImagesActionSheet : JMActionSheet

/**
 *  Present a Horizontal carousel in a actionSheet like style.
 *
 *  @param elements       presented elements compliant to protocol JMActionSheetImagesItemDisplayable
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 */
+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable>*)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController;

/**
 *  Present a Horizontal carousel in a actionSheet like style.
 *
 *  @param elements       presented elements compliant to protocol JMActionSheetImagesItemDisplayable
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 *  @param view           parent View
 */
+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view;

/**
 *  Present a Horizontal carousel in a actionSheet like style.
 *
 *  @param elements       presented elements compliant to protocol JMActionSheetImagesItemDisplayable
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 *  @param view           parent View
 *  @param arrowDirections bitmasked values to configure arrow directions
 */
+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

@end
