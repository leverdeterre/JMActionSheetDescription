//
//  JMActionSheetItem.h
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JMActionSheetItemAction)(void);

@interface JMActionSheetItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) JMActionSheetItemAction action;
@property (strong, nonatomic) UIImage *picto;

@end
