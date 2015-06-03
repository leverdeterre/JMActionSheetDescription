//
//  JMCollectionItem.h
//  JMActionSheetDescription
//
//  Created by jerome morissard on 01/06/2015.
//  Copyright (c) 2015 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JMActionSheetCollectionItem.h"

@interface JMCollectionItem : NSObject <JMActionSheetCollectionItem>

@property (strong, nonatomic) NSString *actionName;
@property (strong, nonatomic) UIImage *actionImage;
@property (assign, nonatomic) UIViewContentMode actionImageContentMode;

@end
