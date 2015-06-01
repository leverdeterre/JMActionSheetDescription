//
//  JMCollectionItem.m
//  JMActionSheetDescription
//
//  Created by jerome morissard on 01/06/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import "JMCollectionItem.h"

@implementation JMCollectionItem


#pragma mark - JMActionSheetCollectionItem

- (NSString *)actionNameForActionSheetCollectionItem
{
    return self.actionName;
}

- (NSString *)imageNamedForActionSheetCollectionItem
{
    return self.actionImageName;
}

@end
