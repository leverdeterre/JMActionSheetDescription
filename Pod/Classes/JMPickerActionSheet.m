//
//  JMPickerActionSheet.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 02/06/2015.
//
//

#import "JMPickerActionSheet.h"

@implementation JMPickerActionSheet

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController selectedElement:(id)selectedElement
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title
                                                         selectedElement:selectedElement];
    [JMPickerActionSheet showActionSheetDescription:desc
                                   inViewController:viewController
                                              style:JMActionSheetStyleEdgeToEdge];
}

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view selectedElement:(id)selectedElement
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title
                                                         selectedElement:selectedElement];
    [JMPickerActionSheet showActionSheetDescription:desc
                                   inViewController:viewController
                                           fromView:view
                                              style:JMActionSheetStyleEdgeToEdge];
}

+ (void)showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections selectedElement:(id)selectedElement
{
    JMActionSheetDescription *desc = [self pickerDescriptionWithElements:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title
                                                         selectedElement:selectedElement];
    [JMPickerActionSheet showActionSheetDescription:desc
                                   inViewController:viewController
                                           fromView:view
                           permittedArrowDirections:arrowDirections
                                              style:JMActionSheetStyleEdgeToEdge];
}

+ (JMActionSheetDescription *)pickerDescriptionWithElements:(NSArray<JMActionSheetPickerItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title selectedElement:(id)selectedElement
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.title = title;
    
    JMActionSheetPickerItem *pickerItem = [[JMActionSheetPickerItem alloc] init];
    pickerItem.pickerElements = elements;
    pickerItem.selectedItem = selectedElement;
    pickerItem.pickerActionBlock = didSelectBlock;
    desc.items = @[pickerItem];
    return desc;
}

@end
