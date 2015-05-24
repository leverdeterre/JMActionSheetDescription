//
//  JMViewController.m
//  JMActionSheetDescription
//
//  Created by Jerome Morissard on 05/24/2015.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"
#import "JMActionSheet.h"
#import "JMActionSheet.h"

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
    itemShare.title = @"last action";
    itemShare.action = ^(void){
        NSLog(@"last action pressed");
    };
    [items addObject:itemShare];

    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"otherItem";
    otherItem.action = ^(void){
        NSLog(@"otherItem pressed");
    };
    [items addObject:otherItem];
    
    if (tag == 2) {
        JMActionSheetImageItem *imageItem = [[JMActionSheetImageItem alloc] init];
        imageItem.image = [UIImage imageNamed:@"gif_experiments"];
        imageItem.imageHeight = 200.0f;
        [items addObject:imageItem];
    }

    desc.items = items;
    [JMActionSheet showActionSheetDescription:desc inViewController:self];
}

@end
