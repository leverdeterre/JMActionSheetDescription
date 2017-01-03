//
//  JMActionSheetItem.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheetItem.h"

@implementation JMActionSheetItem

+ (NSString *)stringOfClass
{
    return NSStringFromClass(self);
}

@end

@implementation JMActionSheetToolbarItem
+ (instancetype)toolbarItemWithTitle:(NSString *)title
{
    JMActionSheetToolbarItem *item = [JMActionSheetToolbarItem new];
    item.title = title;
    return item;
}

@end
