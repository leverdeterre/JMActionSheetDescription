//
//  JMActionSheetDescription.h
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JMActionSheetItem;
@class JMActionContextItem;
@interface JMActionSheetDescription : NSObject

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) JMActionSheetItem *cancelItem;
@property (strong, nonatomic) JMActionContextItem *contextItem;

@property (strong, nonatomic) NSArray *items;   //Array of JMActionSheetItem

@property (strong, nonatomic) UIColor *actionSheetTintColor;
@property (strong, nonatomic) UIFont *actionSheetCancelButtonFont;
@property (strong, nonatomic) UIFont *actionSheetOtherButtonFont;

@end
