//
//  JMViewController.m
//  JMActionSheetDescription
//
//  Created by Jerome Morissard on 05/24/2015.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"
#import "JMActionSheet.h"

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
    
    if (tag >= 1) {
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
    
    if (tag == 2) {
        JMActionSheetImageItem *imageItem = [[JMActionSheetImageItem alloc] init];
        imageItem.image = [UIImage imageNamed:@"gif_experiments"];
        imageItem.imageHeight = 200.0f;
        [items addObject:imageItem];
    }

    desc.items = items;
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionAny];
}

- (IBAction)showAPicker:(id)sender
{
    JMActionSheetPickerItem *pickerItem = [[JMActionSheetPickerItem alloc] init];
    pickerItem.elements = @[@"One", @"Two", @"three", @"Four"];
    pickerItem.pickerAction = ^(NSString *selectedValue){
        NSLog(@"selectedValue %@",selectedValue);
    };
    
    JMActionSheetDescription *desc = [[JMActionSheetDescription alloc] init];
    desc.actionSheetTintColor = [UIColor grayColor];
    desc.actionSheetCancelButtonFont = [UIFont boldSystemFontOfSize:17.0f];
    desc.actionSheetOtherButtonFont = [UIFont systemFontOfSize:16.0f];
    
    JMActionSheetItem *cancelItem = [[JMActionSheetItem alloc] init];
    cancelItem.title = @"Cancel";
    desc.cancelItem = cancelItem;
    desc.items = @[pickerItem];
    
    [JMActionSheet showActionSheetDescription:desc inViewController:self fromView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft];
}

@end
