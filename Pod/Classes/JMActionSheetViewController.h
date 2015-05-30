//
//  JMActionSheetViewController.h
//  Pods
//
//  Created by jerome morissard on 24/05/2015.
//  Copyright (c) 2015 Jérôme Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMActionSheetViewController;

@protocol JMActionSheetViewControllerDelegate <NSObject>
- (void)dismissActionSheetViewController:(JMActionSheetViewController *)vc;
- (void)actionSheetViewController:(JMActionSheetViewController *)vc didSelectPickerViewValue:(NSString *)selectedValue;
@end

@class JMActionSheetDescription;
@interface JMActionSheetViewController : UIViewController

@property (weak, nonatomic, readonly) id <JMActionSheetViewControllerDelegate> delegate;

- (void)reloadWithActionSheetDescription:(JMActionSheetDescription *)actionSheetDescription
                             andDelegate:(id <JMActionSheetViewControllerDelegate>)delegate;

- (CGSize)estimatedContentSizeWithDescription:(JMActionSheetDescription *)actionSheetDescription;
- (CGSize)contentSizeForViewInPopover;

@end
