//
//  JMImagesActionSheet.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 04/06/2015.
//
//

#import "JMImagesActionSheet.h"
#import "JMActionSheetImagesItem.h"

@implementation JMImagesActionSheet

+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController
{
    JMActionSheetDescription *desc = [self imagesDescriptionWithImages:elements
                                                        didSelectBlock:didSelectBlock
                                                                 title:title];
    [JMImagesActionSheet showActionSheetDescription:desc inViewController:viewController];
}

+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view
{
    JMActionSheetDescription *desc = [self imagesDescriptionWithImages:elements
                                                        didSelectBlock:didSelectBlock
                                                                 title:title];
    [JMImagesActionSheet showActionSheetDescription:desc inViewController:viewController fromView:view];
}

+ (void)showImagesActionSheetImages:(NSArray <JMActionSheetImagesItemDisplayable> *)elements didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title inViewController:(UIViewController *)viewController fromView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
{
    JMActionSheetDescription *desc = [self imagesDescriptionWithImages:elements
                                                          didSelectBlock:didSelectBlock
                                                                   title:title];
    [JMImagesActionSheet showActionSheetDescription:desc inViewController:viewController fromView:view permittedArrowDirections:arrowDirections];
}

+ (JMActionSheetDescription *)imagesDescriptionWithImages:(NSArray <JMActionSheetImagesItemDisplayable> *)images didSelectBlock:(JMActionSheetSelectedItemBlock)didSelectBlock title:(NSString *)title
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.title = title;
    
    JMActionSheetImagesItem *imagesItem = [[JMActionSheetImagesItem alloc] init];
    imagesItem.images = images;
    imagesItem.imagesActionBlock = didSelectBlock;
    imagesItem.imageSize = CGSizeMake(250.0f, 170.0f);
    imagesItem.allowsMultipleSelection = YES;
    
    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"Validate";
    otherItem.textColor = [UIColor redColor];
    otherItem.action = ^(void){
        NSLog(@"Validate pressed");
    };
    
    desc.items = @[otherItem, imagesItem];
    return desc;
}

@end
