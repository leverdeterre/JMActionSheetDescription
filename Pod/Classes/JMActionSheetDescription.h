//
//  JMActionSheetDescription.h
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

//items
#import "JMActionSheetItem.h"
#import "JMActionSheetImageItem.h"
#import "JMActionSheetImagesItem.h"
#import "JMActionSheetPickerItem.h"
#import "JMActionSheetDatePickerItem.h"

//actionSheet shortcuts
#import "JMDatePickerActionSheet.h"
#import "JMImagesActionSheet.h"
#import "JMPickerActionSheet.h"

@interface JMActionSheetDescription : NSObject

@property (nullable, copy, nonatomic) NSString *title;

@property (nullable, strong, nonatomic) JMActionSheetItem *cancelItem;

@property (nullable, strong, nonatomic) NSArray <JMActionSheetItem *> *items;

@property (nullable, strong, nonatomic) UIColor *actionSheetTintColor;
@property (nullable, strong, nonatomic) UIFont *actionSheetCancelButtonFont;
@property (nullable, strong, nonatomic) UIFont *actionSheetOtherButtonFont;

@end
