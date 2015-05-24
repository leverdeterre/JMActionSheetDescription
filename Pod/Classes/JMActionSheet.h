//
//  JMActionSheet.h
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JMActionSheetItem.h"
#import "JMActionContextItem.h"
#import "JMActionSheetDescription.h"

@interface JMActionSheet : NSObject

+ (void)showActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription inViewController:(UIViewController *)viewController;

@end
