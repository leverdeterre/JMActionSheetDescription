//
//  JMPickerActionSheet.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMActionSheet.h"

@interface JMPickerActionSheet : JMActionSheet

/**
 *  Present a PickerView in a actionSheet like style.
 *
 *  @param elements       presented elements (conformToProtocol JMActionSheetPickerItemDisplayable) in picker
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 */
+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController;

/**
 *  Present a PickerView in a actionSheet like style.
 *
 *  @param elements       presented elements (conformToProtocol JMActionSheetPickerItemDisplayable) in picker
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 *  @param view           parent View
 */
+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view;

/**
 *  Present a PickerView in a actionSheet like style.
 *
 *  @param elements       presented elements (conformToProtocol JMActionSheetPickerItemDisplayable) in picker
 *  @param didSelectBlock a block of action to execute on the didChangeValue
 *  @param title          title of the view
 *  @param viewController parent View Controller
 *  @param view           parent View
 *  @param arrowDirections bitmasked values to configure arrow directions
 */
+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections;

@end
