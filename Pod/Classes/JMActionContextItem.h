//
//  JMActionContextItem.h
//  Components
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JMActionContextItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat imageHeight;
@property (strong, nonatomic) NSURL *url;

@end
