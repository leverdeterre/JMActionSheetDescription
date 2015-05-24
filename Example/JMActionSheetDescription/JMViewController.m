//
//  JMViewController.m
//  JMActionSheetDescription
//
//  Created by Jerome Morissard on 05/24/2015.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "JMViewController.h"
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
    
    if (tag == 2) {
        JMActionContextItem *contextItem = [[JMActionContextItem alloc] init];
        contextItem.image = [UIImage imageNamed:@"gif_experiments"];
        contextItem.imageHeight = 200.0f;
        desc.contextItem = contextItem;
        desc.title = @"Available actions for component";
    }
    
    if (tag == 1) {
        desc.title = @"Available actions for component";
    }
    
    JMActionSheetItem *itemShare = [[JMActionSheetItem alloc] init];
    itemShare.title = @"last action";
    itemShare.action = ^(void){
        NSLog(@"last action pressed");
    };
    
    JMActionSheetItem *otherItem = [[JMActionSheetItem alloc] init];
    otherItem.title = @"otherItem";
    otherItem.action = ^(void){
        NSLog(@"otherItem pressed");
    };
    
    desc.items = @[itemShare,otherItem];
    [JMActionSheet showActionSheetDescription:desc inViewController:self];
}

@end
