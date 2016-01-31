//
//  JMPickerActionSheet.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMPickerActionSheet.h"

@implementation JMPickerActionSheet

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title];
    [JMPickerActionSheet showActionSheetDescription:desc inViewController:viewController];
}

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title];
    [JMPickerActionSheet showActionSheetDescription:desc inViewController:viewController fromView:view];
}

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title];
    [JMPickerActionSheet showActionSheetDescription:desc inViewController:viewController fromView:view permittedArrowDirections:arrowDirections];
}

+ (JMActionSheetDescription *)pickerDescriptionWithElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.title = title;
    
    JMActionSheetPickerItem *pickerItem = [[JMActionSheetPickerItem alloc] init];
    pickerItem.pickerElements = elements;
    pickerItem.pickerActionBlock = didSelectBlock;
    desc.items = @[pickerItem];
    return desc;
}

@end
