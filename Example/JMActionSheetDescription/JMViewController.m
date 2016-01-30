//
//  JMViewController.m
//  JMActionSheetDescription
//
//  Created by Jerome Morissard on 05/24/2015.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"

#import "JMActionSheet.h"
#import "JMPickerActionSheet.h"
#import "JMImagesActionSheet.h"

#import "JMCollectionItem.h"

#import "IonIcons.h"

@interface JMViewController ()
@end

@implementation JMViewController

- (IBAction)buttonPressed:(id)sender
{
    NSInteger tag = [sender tag];
    
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    
    if (tag == 1) {
        desc.title = @"Available actions for component";
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    JMActionSheetItem *itemShare = [[JMActionSheetItem alloc] init];
    itemShare.title = @"classic button";
    itemShare.action = ^(void){
        NSLog(@"classic button pressed");
    };
    [items addObject:itemShare];

    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"button with icon";
    otherItem.icon = [IonIcons imageWithIcon:ion_social_github  iconColor:[UIColor greenColor] iconSize:30.0f imageSize:CGSizeMake(30.0f, 30.0f)];;
    otherItem.action = ^(void){
        NSLog(@"button with icon pressed");
    };
    [items addObject:otherItem];

    otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"button colored";
    otherItem.backgroundColor = [UIColor redColor];
    otherItem.textColor = [UIColor whiteColor];
    otherItem.action = ^(void){
        NSLog(@"button colored pressed");
    };
    [items addObject:otherItem];

    otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"button custom font";
    otherItem.textFont = [UIFont italicSystemFontOfSize:18.0f];
    otherItem.action = ^(void){
        NSLog(@"button custom font pressed");
    };
    [items addObject:otherItem];
    
    desc.items = items;
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showActionImageView:(id)sender
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    desc.title = @"Available actions for component";
    
    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"Delete image ?";
    otherItem.textColor = [UIColor redColor];
    otherItem.action = ^(void){
        NSLog(@"Delete images pressed");
    };
    
    JMActionSheetImageItem *imageItem = [[JMActionSheetImageItem alloc] init];
    imageItem.image = [UIImage imageNamed:@"gif_experiments"];
    imageItem.imageHeight = 200.0f;
    desc.items = @[otherItem, imageItem];

    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showActionImagesView:(id)sender
{
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    desc.title = @"Available actions for component";
    
    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"Delete images ?";
    otherItem.textColor = [UIColor redColor];
    otherItem.action = ^(void){
        NSLog(@"Delete image pressed");
    };
    
    JMActionSheetImagesItem *imagesItem = [[JMActionSheetImagesItem alloc] init];
    imagesItem.images = (NSArray <JMActionSheetImagesItemDisplayable> *)@[[UIImage imageNamed:@"gif_experiments"], [UIImage imageNamed:@"gif_experiments"], [UIImage imageNamed:@"gif_experiments"]];
    imagesItem.imageSize = CGSizeMake(250.0f, 170.0f);
    //imagesItem.allowsMultipleSelection = YES;
    desc.items = @[otherItem, imagesItem];
    
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showAPicker:(id)sender
{
    JMActionSheetPickerItem *pickerItem = [[JMActionSheetPickerItem alloc] init];
    pickerItem.pickerElements = (NSArray <JMActionSheetPickerItemDisplayable> *)@[@"One", @"Two", @"three", @"Four"];
    pickerItem.pickerActionBlock = ^(NSString *selectedValue){
        NSLog(@"selectedValue %@",selectedValue);
    };
    
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    desc.title = @"Select a value";
    
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    desc.items = @[pickerItem];
    
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showAFastPicker:(id)sender
{
    [JMPickerActionSheet showPickerActionSheetElements:(NSArray<JMActionSheetPickerItemDisplayable> *)@[@"One", @"Two", @"three", @"Four"]
                                        didSelectBlock:^(NSString *selectedValue){
                                            NSLog(@"selectedValue %@",selectedValue);
                                        }
                                                 title:@"JMPickerActionSheet methods"
                                      inViewController:self
     fromView:sender];
}

- (IBAction)showCollection:(id)sender
{
    JMActionSheetCollectionItem *collectionItem = [[JMActionSheetCollectionItem alloc] init];
    NSMutableArray *collectionItems = [NSMutableArray new];
    JMCollectionItem *item = [[JMCollectionItem alloc] init];
    item.actionName = @"facebook";
    item.actionImage = [UIImage imageNamed:@"fb-icon3-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"AppStore";
    item.actionImage = [UIImage imageNamed:@"apple_store_app_icon.jpg"];
    [collectionItems addObject:item];

    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Password";
    item.actionImage = [UIImage imageNamed:@"1Pi-icon-1024-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Flipboard";
    item.actionImage = [UIImage imageNamed:@"Flipboard-App-Icon-150x150.jpg"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Gmail";
    item.actionImage = [UIImage imageNamed:@"gmail-ios-icon-app-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Mail";
    item.actionImage = [UIImage imageNamed:@"mail-iphone-150x150.jpg"];
    [collectionItems addObject:item];
    
    collectionItem.elements = (NSArray <JMActionSheetCollectionItem> *)collectionItems;
    collectionItem.collectionActionBlock = ^(JMCollectionItem *selectedValue){
        NSLog(@"collectionItem selectedValue %@",selectedValue.actionName);
    };
    
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    desc.title = @"Select a value";
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    
    JMActionSheetCollectionItem *collectionItem2 = [[JMActionSheetCollectionItem alloc] init];
    NSMutableArray *collectionItems2 = [NSMutableArray new];
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Open Plan";
    item.actionImageContentMode = UIViewContentModeCenter;
    UIImage *img = [IonIcons imageWithIcon:ion_map size:40.0f color:[UIColor grayColor]];
    item.actionImage = img;    
    [collectionItems2 addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Take a beer";
    img = [IonIcons imageWithIcon:ion_beer size:40.0f color:[UIColor grayColor]];
    item.actionImage = img;
    item.actionImageContentMode = UIViewContentModeCenter;
    [collectionItems2 addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"ApplePay";
    img = [IonIcons imageWithIcon:ion_card size:40.0f color:[UIColor grayColor]];
    item.actionImage = img;
    item.actionImageContentMode = UIViewContentModeCenter;
    [collectionItems2 addObject:item];
    
    collectionItem2.elements = (NSArray <JMActionSheetCollectionItem> *)collectionItems2;
    collectionItem2.collectionActionBlock = ^(JMCollectionItem *selectedValue){
        NSLog(@"collectionItem2 selectedValue %@",selectedValue.actionName);
    };
    
    desc.items = @[collectionItem, collectionItem2];
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showAll:(id)sender
{
    JMActionSheetCollectionItem *collectionItem = [[JMActionSheetCollectionItem alloc] init];
    NSMutableArray *collectionItems = [NSMutableArray new];
    JMCollectionItem *item = [[JMCollectionItem alloc] init];
    item.actionName = @"facebook";
    item.actionImage = [UIImage imageNamed:@"fb-icon3-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"AppStore";
    item.actionImage = [UIImage imageNamed:@"apple_store_app_icon.jpg"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Password";
    item.actionImage = [UIImage imageNamed: @"1Pi-icon-1024-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Flipboard";
    item.actionImage = [UIImage imageNamed:@"Flipboard-App-Icon-150x150.jpg"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Gmail";
    item.actionImage = [UIImage imageNamed:@"gmail-ios-icon-app-150x150.png"];
    [collectionItems addObject:item];
    
    item = [[JMCollectionItem alloc] init];
    item.actionName = @"Mail";
    item.actionImage = [UIImage imageNamed:@"mail-iphone-150x150.jpg"];
    [collectionItems addObject:item];
    
    collectionItem.elements = (NSArray <JMActionSheetCollectionItem> *)collectionItems;
    collectionItem.collectionActionBlock = ^(JMCollectionItem *selectedValue){
        NSLog(@"selectedValue %@",selectedValue.actionName);
    };
    
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    desc.title = @"Select a value";
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    
    JMActionSheetImageItem *imageItem = [[JMActionSheetImageItem alloc] init];
    imageItem.image = [UIImage imageNamed:@"gif_experiments"];
    imageItem.imageHeight = 200.0f;
    
    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"button ";
    otherItem.textColor = [UIColor blackColor];
    otherItem.action = ^(void){
        NSLog(@"button pressed");
    };
    
    desc.items = @[otherItem,imageItem,collectionItem];
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showFastActionImagesView:(id)sender
{
    [JMImagesActionSheet showImagesActionSheetImages:(NSArray<JMActionSheetImagesItemDisplayable> *)@[
                                                       [UIImage imageNamed:@"gif_experiments"],
                                                       [UIImage imageNamed:@"gif_experiments"],
                                                       [UIImage imageNamed:@"gif_experiments"]]
     
                                      didSelectBlock:^(id selectedValue) {
                                          NSLog(@"didSelectBlock %@",selectedValue);}
                                               title:@"The title"
                                    inViewController:self];
}


@end
