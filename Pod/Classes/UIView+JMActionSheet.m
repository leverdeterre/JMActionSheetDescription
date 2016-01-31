//
//  UIView+JMActionSheet.m
//  JMActionSheet Pod
//
//  Created by jerome morissard on 25/06/2015.
//
//

#import "UIView+JMActionSheet.h"

@implementation UIView (JMActionSheet)

- (void)jm_addSubview:(UIView *)view withEdgeInsets:(UIEdgeInsets)edgeInsets
{
    [self addSubview:view];
    
    NSMutableDictionary *viewsDict = [NSMutableDictionary new];
    viewsDict[@"childView"] = view;
    
    NSMutableDictionary *metricsDict = [NSMutableDictionary new];
    metricsDict[@"topSpace"] = @(edgeInsets.top);
    metricsDict[@"bottomSpace"] = @(edgeInsets.bottom);
    metricsDict[@"leftSpace"] = @(edgeInsets.left);
    metricsDict[@"rightSpace"] = @(edgeInsets.right);
    
     [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topSpace)-[childView]-(bottomSpace)-|"
                                                                          options:0
                                                                          metrics:metricsDict
                                                                            views:viewsDict]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leftSpace)-[childView]-(rightSpace)-|"
                                                                          options:0
                                                                          metrics:metricsDict
                                                                            views:viewsDict]];
     
}

@end
