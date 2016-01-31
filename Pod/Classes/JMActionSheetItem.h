//
//  JMActionSheetItem.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JMActionSheetItem;
typedef void (^JMActionSheetItemAction)(void);
typedef void (^JMActionSheetSelectedItemBlock)(id selectedItem);

@interface JMActionSheetItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) JMActionSheetItemAction action;
@property (strong, nonatomic) UIImage *icon;

//Appearance
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *textFont;

+ (NSString *)stringOfClass;

@end
