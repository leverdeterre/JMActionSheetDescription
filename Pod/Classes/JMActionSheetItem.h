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
typedef void (^JMActionSheetSelectedItemBlock)(__nonnull id selectedItem);

@interface JMActionSheetItem : NSObject

@property (nonnull, copy, nonatomic) NSString *title;
@property (nonnull, copy, nonatomic) JMActionSheetItemAction action;
@property (nonnull, strong, nonatomic) UIImage *icon;

//Appearance
@property (nullable, strong, nonatomic) UIColor *backgroundColor;
@property (nullable, strong, nonatomic) UIColor *textColor;
@property (nullable, strong, nonatomic) UIFont *textFont;

+ (nonnull NSString *)stringOfClass;

@end

@interface JMActionSheetToolbarItem : JMActionSheetItem
+ (nonnull instancetype)toolbarItemWithTitle:(nonnull NSString *)title;
@end
