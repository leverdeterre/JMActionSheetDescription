//
//  JMActionSheetItemControl.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import "JMActionSheetItemControl.h"
static const CGFloat JMActionSheetItemControlSize = 30.0f;

@interface JMActionSheetItemControl ()
@end

@implementation JMActionSheetItemControl

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0.0f,0.0f , CGRectGetWidth(contentRect), CGRectGetHeight(contentRect));
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat y = (CGRectGetHeight(contentRect) - JMActionSheetItemControlSize) / 2.0f;
    return CGRectMake(y, y, JMActionSheetItemControlSize, JMActionSheetItemControlSize);
}

@end
